/* wireless_ft.cpp - ROS driver for the ATi Wireless F/T system
 *
 * When started, the node first connects to the Wireless F/T
 * at the given hostname/IP-address via telnet (port 23)
 * and configures the device parameters, including active
 * transducers, rate, filtering, and power settings.
 * Once this finished, we open the second UDP port (49152)
 * and start the ROS loop that periodically reads incoming
 * UDP packets. We then send the UDP command to start data
 * streaming.

 * Incoming data is published both as raw values and converted
 * into WrenchStamped via the factory calibration matrices
 * provided by ATi/Schunk.
 *
 * If the number of dropped packets grows too large, we try
 * to reconnect.
 *
 * TODO:
 * - use rosparam to set/read the calibration matrices
 * - provide gravity-compensation for tools mounted on the sensors
 * - clean-up the Calibration class.
 *
 * 2019.03.26 - github upload
 * 2019.03.13 - add cntl-c handler
 * 2018.03.12 - merge "reset_bias" service pull request
 * 2018.03.12 - implement "channels" node parameter
 * 2017.05.22 - getWrench returns sensor readings in N and Nm (after bias reset, Stephan)
 * 2017.03.16 - created (from scratch / datasheet)
 *
 * (C) 2017, 2018, 2019, fnh, hendrich@informatik.uni-hamburg.de
 */


#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>

#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <netinet/udp.h>

#include <Eigen/Core>
#include <Eigen/Dense>

#include <csignal>
#include <sstream>

#include <ros/ros.h>
#include <sensor_msgs/Joy.h>  // buttons: channel on/off, axes: sensor counts
#include <geometry_msgs/WrenchStamped.h>
#include <std_srvs/Empty.h>


// conversion factors, see WirelessFTSensorPanel.java
//
#define CONVERT_FORCE_POUND_LBF           1.0;
#define CONVERT_FORCE_KILOPOUND_KLBF   1000.0;
#define CONVERT_FORCE_NEWTON_N            4.448222;
#define CONVERT_FORCE_KILONEWTON_KN       0.004448222;
#define CONVERT_FORCE_GRAM_G            453.5924;
#define CONVERT_FORCE_KILOGRAM_KG         0.4535924;

#define CONVERT_TORQUE_POUND_INCHES_LBFIN           1.0;
#define CONVERT_TORQUE_POUND_FEET_LBFFT             0.0833333;
#define CONVERT_TORQUE_NEWTON_METER_NM              0.1129848;
#define CONVERT_TORQUE_NEWTON_MILLIMETER_NMM      112.984829;
#define CONVERT_TORQUE_KILOGRAM_CENTIMETER_KGCM     1.15212462;
#define CONVERT_TORQUE_KILONEWTON_METER             0.000112985;


// UDP data packet definition
//
#define NUMBER_OF_ANALOG_BOARDS                2
#define NUMBER_OF_TRANSDUCERS                  6
#define NUMBER_OF_STRAIN_GAGES                 6

/*
struct TxPacket_S
{
  unsigned long timeStamp;    // UTC
  unsigned long sequence;
  unsigned long statusWord1;  // board 1
  unsigned long statusWord2;  // board 2
  unsigned char batteryLevel; // unspecified values
  unsigned char transMask;    // 8-bit, bit set if transducer active: 00T6T5 T4T3T2T1
  signed long  gage_data[ NUMBER_OF_TRANSDUCERS ] [NUMBER_OF_STRAIN_GAGES]
}
__attribute__ ((__packed__));
*/

// status bits in UDP data packet, status word 1
//
#define WFT_STATUS1_BRIDGE_VOLTAGE_LOW_T3     (1 << 29)
#define WFT_STATUS1_BRIDGE_VOLTAGE_LOW_T2     (1 << 28)
#define WFT_STATUS1_BRIDGE_VOLTAGE_LOW_T1     (1 << 27)
#define WFT_STATUS1_SATURATED_DATA_T3         (1 << 26)
#define WFT_STATUS1_SATURATED_DATA_T2         (1 << 25)
#define WFT_STATUS1_SATURATED_DATA_T1         (1 << 24)

#define WFT_STATUS1_T3_BRIDGE                 (1 << 21)
#define WFT_STATUS1_T3_AFE                    (1 << 20)
#define WFT_STATUS1_T2_BRIDGE                 (1 << 19)
#define WFT_STATUS1_T2_AFE                    (1 << 18)
#define WFT_STATUS1_T1_BRIDGE                 (1 << 17)
#define WFT_STATUS1_T1_AFE                    (1 << 16)

#define WFT_STATUS1_BATTERY_GREEN             (1 << 11)
#define WFT_STATUS1_BATTERY_RED               (1 << 10)
#define WFT_STATUS1_EXT_POWER_GREEN           (1 <<  9)
#define WFT_STATUS1_EXT_POWER_RED             (1 <<  8)
#define WFT_STATUS1_WLAN_GREEN                (1 <<  7)
#define WFT_STATUS1_WLAN_RED                  (1 <<  6)
#define WFT_STATUS1_T3_GREEN                  (1 <<  5)
#define WFT_STATUS1_T3_RED                    (1 <<  4)
#define WFT_STATUS1_T2_GREEN                  (1 <<  3)
#define WFT_STATUS1_T2_RED                    (1 <<  2)
#define WFT_STATUS1_T1_GREEN                  (1 <<  1)
#define WFT_STATUS1_T1_RED                    (1 <<  0)

// status bits in UDP data packet, status word 1
//
#define WFT_STATUS2_BRIDGE_VOLTAGE_LOW_T6     (1 << 29)
#define WFT_STATUS2_BRIDGE_VOLTAGE_LOW_T5     (1 << 28)
#define WFT_STATUS2_BRIDGE_VOLTAGE_LOW_T4     (1 << 27)
#define WFT_STATUS2_SATURATED_DATA_T6         (1 << 26)
#define WFT_STATUS2_SATURATED_DATA_T5         (1 << 25)
#define WFT_STATUS2_SATURATED_DATA_T4         (1 << 24)

#define WFT_STATUS2_T6_BRIDGE                 (1 << 21)
#define WFT_STATUS2_T6_AFE                    (1 << 20)
#define WFT_STATUS2_T5_BRIDGE                 (1 << 19)
#define WFT_STATUS2_T5_AFE                    (1 << 18)
#define WFT_STATUS2_T4_BRIDGE                 (1 << 17)
#define WFT_STATUS2_T4_AFE                    (1 << 16)

#define WFT_STATUS2_T6_GREEN                  (1 <<  5)
#define WFT_STATUS2_T6_RED                    (1 <<  4)
#define WFT_STATUS2_T5_GREEN                  (1 <<  3)
#define WFT_STATUS2_T5_RED                    (1 <<  2)
#define WFT_STATUS2_T4_GREEN                  (1 <<  1)
#define WFT_STATUS2_T4_RED                    (1 <<  0)



static pthread_mutex_t mutex;
static bool debug = false;


/**
 * WirelessFTCalibration: helper class to store and manage
 * calibration of the ATi force/torque transducers.
 *
 * Note: as the raw counts returned from the Wireless F/T system
 * turned out to be (factory-) calibrated, we currently bypass
 * all our own custom calibration code. Instead, getWrench just
 * returns the sensor counts rescaled to Newton and Newtonmeter
 * as expected by ROS.
 */
class WirelessFTCalibration {
  public:
    WirelessFTCalibration( std::string transducerName, std::string calibrationName, int verbose );
    Eigen::VectorXd getWrench( Eigen::VectorXd counts );
    void parseGains( std::string tokens );
    void parseOffsets( std::string tokens );
    void parseCalibration( std::string tokens );
    void parseYaml( std::string paramName );

  // private:
    int verbose;
    int NG; // 6
    Eigen::VectorXd gains;
    Eigen::VectorXd offsets;
    Eigen::MatrixXd calibration; // (Fx Fy Fz Tx Ty Tz) * NG
    std::string     transducerName;
    std::string     calibrationName;
    double          countsPerN;
    double          countsPerNm;
};


WirelessFTCalibration::WirelessFTCalibration( std::string transducerName,
                                              std::string calibrationName,
                                              int verbose ):
  NG( 6 ), gains( 6 ), offsets( 6 ), calibration( 6, 6 ), verbose( verbose ),
  transducerName( transducerName ),
  calibrationName( calibrationName )
{
  if (verbose > 0) ROS_INFO( "WirelessFTCalibration::<init>..." );
  gains.setOnes();
  offsets.setZero();
  calibration.setIdentity();
}

/**
* @param: counts in N and Nm force units * 1 000 000
* return: force values in N and torque values in Nm
*/

Eigen::VectorXd WirelessFTCalibration::getWrench( Eigen::VectorXd counts ) {
  if (verbose > 2) std::cout << "getWrench(" << transducerName << "," << calibrationName << "):" << "\n";
  Eigen::VectorXd    valuesF = counts / 1000000; // N
  Eigen::VectorXd    valuesT = (counts / 1000000); //Nmm to Nm
  Eigen::VectorXd    valuesFT(6);

  valuesFT << valuesF[0], valuesF[1], valuesF[2], valuesT[3], valuesT[4], valuesT[5];
  if (verbose > 2) std::cout << "... valuesFT:\n" << valuesFT << "\n";
  return valuesFT;
}


void WirelessFTCalibration::parseGains( std::string tokens ) {
  std::stringstream ss;
  ss << tokens;
  for( int i=0; i < NG; i++ ) {
    double value = 0.0;
    ss >> value;
    gains( i ) = value;
  }
  if (verbose > 2) std::cout << "parseGains(" << transducerName << "," << calibrationName << "):\n" << gains << "\n";
}


void WirelessFTCalibration::parseOffsets( std::string tokens ) {
  std::stringstream ss;
  ss << tokens;
  for( int i=0; i < NG; i++ ) {
    double value = 0.0;
    ss >> value;
    offsets( i ) = value;
  }
  if (verbose > 2) std::cout << "parseOffsets(" << transducerName << "," << calibrationName << "):\n" << offsets << "\n";
}


void WirelessFTCalibration::parseCalibration( std::string tokens ) {
  std::stringstream ss;
  ss << tokens;
  for( int i=0; i < 6; i++ ) { // Fx Fy Fz Tx Ty Tz
    for( int j=0; j < NG; j++ ) {
      double value = 0.0;
      ss >> value;
      calibration(i,j) = value;
    }
  }
  if (verbose > 2) std::cout << "parseCalibration(" << transducerName << "," << calibrationName << "):\n" << calibration << "\n";
}


void WirelessFTCalibration::parseYaml( std::string paramName) {
  ROS_ERROR( "WirelessFTCalibration::parseYaml: IMPLEMENT ME!!!" );
}





/**
 * WirelessFT: ROS C++ driver for the ATi Wireless F/T system.
 */
class WirelessFT {
  public:
    WirelessFT();
    ~WirelessFT();

    int  telnetConnect();
    int  telnetDisconnect();
    int  telnetCommand( std::string & response, std::string command, unsigned int micros );

    int  udpConnect();
    int  udpStartStreaming();
    int  udpStopStreaming();
    int  udpPing();
    int  udpResetTelnetSocket();

    int  readDataPacket();
    int  decodeDataPacket( char* buffer, unsigned int n_bytes );
    void run();
    void shutdown();


  private:
    unsigned char  udpCommandSequence;
    unsigned short crcBuf( char* buff, int len );
    unsigned short crcByte( unsigned short crc, char ch );

    bool serviceCallback( std_srvs::Empty::Request &req, std_srvs::Empty::Response &res );

    // double sensor_counts[NUMBER_OF_TRANSDUCERS][NUMBER_OF_STRAIN_GAGES];
    Eigen::MatrixXd  sensor_counts;
    std::vector<WirelessFTCalibration> factory_calibrations;

    ros::NodeHandle     nh;
    ros::Publisher      raw_sensor_counts_publisher;
    ros::Publisher      wrench_1_publisher;
    ros::Publisher      wrench_2_publisher;
    ros::Publisher      wrench_3_publisher;
    ros::Publisher      wrench_4_publisher;
    ros::Publisher      wrench_5_publisher;
    ros::Publisher      wrench_6_publisher;
    ros::ServiceServer  reset_bias_service; // reset/tara bias all channels
    ros::ServiceServer  command_service;    // text in, text out

    int active_channels_mask; // bit i <=> channel (i+1) active
    int verbose; // 0=silent, 1..

    // networking stuff
    std::string localHostname;
    int telnetPort;
    int udpPort;
    int telnetSocket; // port 23 aka telnet
    int udpSocket;    // port 49152 for data streaming
    bool streaming;

}; // end class WirelessFT



WirelessFT::WirelessFT() :
  streaming( false ), verbose( 0 )
{
  ROS_INFO( "WirelessFT::<init>..." );
  pthread_mutexattr_t attr;
  pthread_mutexattr_init(&attr);
  pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
  pthread_mutex_init(&mutex, &attr);

  char  udpCommandSequence = 0;

  ros::NodeHandle nnh( "~" );
  nnh.param( "verbose", verbose, 1 );
  ROS_ERROR( "verbose level is %d", verbose );

  std::string token;
  nnh.param( "active_channels", token, std::string( "123456" ));
  ROS_ERROR( "param active_channels: got %s", token.c_str() );

  nnh.param( "ip_address", localHostname, std::string( "192.168.0.123") );

  nnh.param( "telnet_port", telnetPort, 23 );
  nnh.param( "udp_port", udpPort, 49152 );

  ROS_ERROR( "connecting to %s:%d udp, telnet port: %d", localHostname.c_str(), udpPort, telnetPort );

  active_channels_mask = 0x0;
  for( int i=0; i < 6; i++ ) {
    const char* found = strchr( token.c_str(), '0'+i+1 );
    // ROS_ERROR( "index %d found %p", i, found );
    if (found != NULL) active_channels_mask  |= (1 << i);
    else               active_channels_mask  &= (0x3F ^ (1 << i));
    // ROS_ERROR( "active channels mask is %d", active_channels_mask );
  }
  if (verbose > 0) ROS_ERROR( "active channels mask is %d", active_channels_mask );


  // TODO xxxzzz: read node params

  // calibration stuff
  //
  if (verbose > 0) ROS_INFO( "initializing factory calibration..." );
  // WirelessFTCalibration cal1( "T1", "CALIB_1", verbose );
  // cal1.parseGains( "574 594 618 650 602 586" );
  // cal1.parseOffsets( "0 0 0 0 0 0" );
  // cal1.parseCalibration(
  //     "-1.840735  14.82621  24.62213 -504.6677 -41.82769  517.6721 "
  //     " -28.2255  612.1705  8.692911  -272.207  29.95003 -315.0209 "
  //     " 600.7707 -1.183056  566.2838   20.7928  567.9268  18.35527 "
  //     "-222.2077  3693.643  3252.839 -1542.229 -2947.771 -1979.439 "
  //     "-3853.554 -52.50696  1631.666  3108.785   2139.37 -3090.429 "
  //     "-91.21972  2335.882 -113.9305  2182.562 -173.7546  2260.616 " );

  // WirelessFTCalibration cal2( "T2", "CALIB_1", verbose );
  // cal2.parseGains( "598 622 638 650 614 602" );
  // cal2.parseOffsets( "31087 32019 29522 31190 28980 30852" );
  // cal2.parseCalibration(
  //     "0.6105832  11.82515 -27.75596 -517.7919  28.04681  531.0735 "
  //     " 25.59246  616.7253 -14.80488 -284.2845 -18.88448 -315.8253 "
  //     " 593.0466  14.84871  558.9457 -10.66256  562.8641  10.35539 "
  //     " 130.5689  3726.847  3047.324 -1787.495 -3209.956 -1953.829 "
  //     "-3797.911 -156.7664   1916.83  3090.215  1702.124 -3183.832 "
  //     " 104.3058  2344.414  130.2406  2179.418  109.7938   2272.98 " );

  // WirelessFTCalibration cal3( "T3", "CALIB_1", verbose );
  // cal3.parseGains( "618 650 638 638 686 706" );
  // cal3.parseOffsets( "29906 31020 29168 30516 28134 30628" );
  // cal3.parseCalibration(
  //     "0.5407506 -11.06681  603.3965  -109.276 -3841.928  -39.5272 "
  //     "-10.44727  616.4824  25.85361  3717.271 -104.0906  2258.229 "
  //     " 29.16257  17.27281  568.6636  3233.831  1654.897 -136.5534 "
  //     "-532.5557 -309.5431  6.927393 -1816.022  3245.616  2312.379 "
  //     "-27.62092  14.28631  549.3841 -3022.306  1944.764 -101.4407 "
  //     " 501.5891 -292.6168  24.70506  -1906.68 -2954.505    2185.1 " );


  // CALIBRATION INFO FOR Mini 45 FT30835
  WirelessFTCalibration cal3( "T3", "CALIB_1", verbose );
  cal3.parseGains( "918 906 926 914 922 898" );
  cal3.parseOffsets( "31624 31634 31750 31412 31306 31498" );
  cal3.parseCalibration(
      " -95.5181574684788 3.17606636648504 -161.714068028088 4044.17703206811 224.972149821766 -4028.37285551958  "
      " 201.420699698049 -4747.54803357857 -238.726575984978 2361.58548201335 -48.8286081566173 2315.68957289399 "
      " 7922.72898213729 -186.750865628935 7883.30188512908 157.206093402525 7736.43953138598 21.0341577971094 "
      " 2.45801255222984 -40.3108897022307 73.8623672922901 21.6094166980102 -75.7480526749821 19.4977511434179 "
      " -88.8702206374856 2.57423423757304 46.565492112122 -33.6734824246489 40.9159234816892 34.2086745418685 "
      " 0.723166170362916 -37.6192179851038 2.60378168453361 -37.5405843756573 1.62607268661438 -36.7507395105944 " );

  WirelessFTCalibration cal4( "T4", "CALIB_1", verbose );
  WirelessFTCalibration cal5( "T5", "CALIB_1", verbose );
  WirelessFTCalibration cal6( "T6", "CALIB_1", verbose );

  factory_calibrations.push_back( cal3 );
  factory_calibrations.push_back( cal3 );
  factory_calibrations.push_back( cal3 );
  factory_calibrations.push_back( cal4 );
  factory_calibrations.push_back( cal5 );
  factory_calibrations.push_back( cal6 );


  if (verbose > 3) ROS_ERROR( "before sensor_counts" );
  sensor_counts = Eigen::MatrixXd( NUMBER_OF_TRANSDUCERS, NUMBER_OF_STRAIN_GAGES );
  for( int t=0; t < NUMBER_OF_TRANSDUCERS; t++ ) {
    for( int g=0; g < NUMBER_OF_STRAIN_GAGES; g++ ) {
      // sensor_counts[t][g] = NAN;
      sensor_counts(t,g) = NAN;
    }
  }
  if (verbose > 0) ROS_INFO( "sensor_counts initialized..." );

  // publishers
  raw_sensor_counts_publisher = nh.advertise<sensor_msgs::Joy>( "wireless_ft/raw_sensor_counts", 1 );

  if (active_channels_mask & 0x01)
    wrench_1_publisher = nh.advertise<geometry_msgs::WrenchStamped>( "wireless_ft/wrench_1", 1 );
  if (active_channels_mask & 0x02)
    wrench_2_publisher = nh.advertise<geometry_msgs::WrenchStamped>( "wireless_ft/wrench_2", 1 );
  if (active_channels_mask & 0x04)
    wrench_3_publisher = nh.advertise<geometry_msgs::WrenchStamped>( "wireless_ft/wrench_3", 1 );
  if (active_channels_mask & 0x08)
    wrench_4_publisher = nh.advertise<geometry_msgs::WrenchStamped>( "wireless_ft/wrench_4", 1 );
  if (active_channels_mask & 0x10)
    wrench_5_publisher = nh.advertise<geometry_msgs::WrenchStamped>( "wireless_ft/wrench_5", 1 );
  if (active_channels_mask & 0x20)
    wrench_6_publisher = nh.advertise<geometry_msgs::WrenchStamped>( "wireless_ft/wrench_6", 1 );

  // services
  reset_bias_service = nh.advertiseService("wireless_ft/reset_bias", &WirelessFT::serviceCallback, this);

  if (verbose > 0) ROS_INFO( "WirelessFT<init> completed." );
}


WirelessFT::~WirelessFT() {
  ; // empty
}


/**
 * tries to connect to the Wireless F/T controller using the
 * given IP-address (e.g. 192.168.104.107) and port (typically 23).
 * Returns 0 on success, -1 on error.
 */
int WirelessFT::telnetConnect() {
  telnetSocket = socket( AF_INET, SOCK_STREAM, 0 );
  if (telnetSocket < 0) {
    ROS_ERROR( "WirelessFT: ferror opening client socket" );
    return -1;
  }

  struct hostent *server = gethostbyname( localHostname.c_str() );
  if (server == NULL) {
    ROS_ERROR( "WirelessFT: no such host: '%s'", localHostname.c_str() );
    exit( -1 );
  }

  struct sockaddr_in serv_addr;
  bzero((char *) &serv_addr, sizeof(serv_addr));
  serv_addr.sin_family = AF_INET;
  serv_addr.sin_port = htons( telnetPort );
  bcopy( (char*) server->h_addr,
         (char*) &serv_addr.sin_addr.s_addr,
         server->h_length );

  if (connect( telnetSocket, (sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) {
    ROS_ERROR( "WirelessFT: error connecting to socket at host '%s' port '%d'", localHostname.c_str(), telnetPort );
    exit( -1 );
  }

  int nodelay = 1; // 1=on, 0=off
  int result = setsockopt( telnetSocket,
                           IPPROTO_TCP,
                           TCP_NODELAY,
                           (char*) &nodelay, sizeof(int));
  if (result < 0) {
     ROS_ERROR( "WirelessFT: failed to set TCP_NODELAY on the socket..." );
  }

  return 0;
}


int WirelessFT::telnetDisconnect() {
  ROS_INFO( "WirelessFT: telnetDisconnect..." );
  try {
    if (telnetSocket >= 0) {
      ::shutdown( telnetSocket, SHUT_RDWR );
      close( telnetSocket );
      return 0;
    }
  }
  catch( ... ) {
    ROS_ERROR( "Exception in telnetDisconnect" );
    return -1;
  }
}


/**
 * sends the given command to the telnet socket, waits for the
 * specified interval (microseconds), then tries to read the response
 * from the socket.
 * Returns 0 on success, -1 on errors.
 */
int WirelessFT::telnetCommand( std::string & response, std::string cmd, unsigned int micros=1000 ) {
  try {
    if (verbose > 2) ROS_INFO( "sending telnet command '%s'", cmd.c_str() );

    char buffer[2048]; // size is big enough for all documented Wireless FT data packets
    response = "";

    int n;
    strncpy( buffer, cmd.c_str(), 2047 );
    n = write( telnetSocket, buffer, strlen(buffer) );
    if (n < 0) {
       ROS_ERROR( "Error writing to telnet socket." );
       response = "";
       return -1;
    }
    else {
       if (verbose > 2) ROS_INFO( "socket write: sent %d bytes, ok.", n );
    }

    // sleep a bit to give the device time to respond
    //
    usleep( micros );
    // usleep( 500*1000 );

    // read Wireless FT response
    //
    bzero( buffer, 2048 );
    n = read( telnetSocket, buffer, 2047);
    if (n < 0) {
       ROS_ERROR( "Error reading from socket" );;
       response = "";
       return -1;
    }
    else {
       if (verbose > 2) ROS_INFO( "socket read: got %d bytes.", n );
       response = std::string( buffer );
    }

    if (verbose > 2) ROS_INFO( "response: '%s'", response.c_str() );
    return 0;
  }
  catch (...) {
    ROS_ERROR( "Exception while reading from socket" );;
    response = "";
    return -1;
  }
}



/**
 * tries to connect to the Wireless F/T controller using the
 * given IP-address (e.g. 192.168.104.107) and port 49152.
 * Returns 0 on success, -1 on error.
 */
int WirelessFT::udpConnect() {
  udpSocket = socket( AF_INET, SOCK_DGRAM, IPPROTO_UDP);
  if (udpSocket < 0) {
    ROS_ERROR( "WirelessFT: ferror creating UDP client socket" );
    return -1;
  }

/*
  // zero out the structure
  memset((char *) &si_me, 0, sizeof(si_me));

  si_me.sin_family = AF_INET;
  si_me.sin_port = htons(PORT);
  si_me.sin_addr.s_addr = htonl(INADDR_ANY);

  //bind socket to port
  if( bind(s , (struct sockaddr*)&si_me, sizeof(si_me) ) == -1)
  {
    die("bind");
  }}
*/

  struct hostent *server = gethostbyname( localHostname.c_str() );
  if (server == NULL) {
    ROS_ERROR( "WirelessFT: no such host: '%s'", localHostname.c_str() );
    exit( -1 );
  }

  struct sockaddr_in serv_addr;
  bzero((char *) &serv_addr, sizeof(serv_addr));
  serv_addr.sin_family = AF_INET;
  serv_addr.sin_port = htons( udpPort );
  bcopy( (char*) server->h_addr,
         (char*) &serv_addr.sin_addr.s_addr,
         server->h_length );

  if (connect( udpSocket, (sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) {
    ROS_ERROR( "WirelessFT: error connecting to socket at host '%s' port '%d'", localHostname.c_str(), udpPort);
    exit( -1 );
  }

  return 0;
}


/**
 * CRC checksum calculation, converted from ATi's crc.java
 * @author Sam Skuce
 */
unsigned short WirelessFT::crcByte( unsigned short crc, char ch )
{
        static int ccitt_crc16_table[32*8] =
        {
            0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
            0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
            0x1231, 0x0210, 0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7, 0x62d6,
            0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c, 0xf3ff, 0xe3de,
            0x2462, 0x3443, 0x0420, 0x1401, 0x64e6, 0x74c7, 0x44a4, 0x5485,
            0xa56a, 0xb54b, 0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d,
            0x3653, 0x2672, 0x1611, 0x0630, 0x76d7, 0x66f6, 0x5695, 0x46b4,
            0xb75b, 0xa77a, 0x9719, 0x8738, 0xf7df, 0xe7fe, 0xd79d, 0xc7bc,
            0x48c4, 0x58e5, 0x6886, 0x78a7, 0x0840, 0x1861, 0x2802, 0x3823,
            0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948, 0x9969, 0xa90a, 0xb92b,
            0x5af5, 0x4ad4, 0x7ab7, 0x6a96, 0x1a71, 0x0a50, 0x3a33, 0x2a12,
            0xdbfd, 0xcbdc, 0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b, 0xab1a,
            0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03, 0x0c60, 0x1c41,
            0xedae, 0xfd8f, 0xcdec, 0xddcd, 0xad2a, 0xbd0b, 0x8d68, 0x9d49,
            0x7e97, 0x6eb6, 0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70,
            0xff9f, 0xefbe, 0xdfdd, 0xcffc, 0xbf1b, 0xaf3a, 0x9f59, 0x8f78,
            0x9188, 0x81a9, 0xb1ca, 0xa1eb, 0xd10c, 0xc12d, 0xf14e, 0xe16f,
            0x1080, 0x00a1, 0x30c2, 0x20e3, 0x5004, 0x4025, 0x7046, 0x6067,
            0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d, 0xd31c, 0xe37f, 0xf35e,
            0x02b1, 0x1290, 0x22f3, 0x32d2, 0x4235, 0x5214, 0x6277, 0x7256,
            0xb5ea, 0xa5cb, 0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c, 0xc50d,
            0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
            0xa7db, 0xb7fa, 0x8799, 0x97b8, 0xe75f, 0xf77e, 0xc71d, 0xd73c,
            0x26d3, 0x36f2, 0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634,
            0xd94c, 0xc96d, 0xf90e, 0xe92f, 0x99c8, 0x89e9, 0xb98a, 0xa9ab,
            0x5844, 0x4865, 0x7806, 0x6827, 0x18c0, 0x08e1, 0x3882, 0x28a3,
            0xcb7d, 0xdb5c, 0xeb3f, 0xfb1e, 0x8bf9, 0x9bd8, 0xabbb, 0xbb9a,
            0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1, 0x1ad0, 0x2ab3, 0x3a92,
            0xfd2e, 0xed0f, 0xdd6c, 0xcd4d, 0xbdaa, 0xad8b, 0x9de8, 0x8dc9,
            0x7c26, 0x6c07, 0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0, 0x0cc1,
            0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba, 0x8fd9, 0x9ff8,
            0x6e17, 0x7e36, 0x4e55, 0x5e74, 0x2e93, 0x3eb2, 0x0ed1, 0x1ef0
        };
        return (short) (ccitt_crc16_table[((crc >> 8) ^ ch) & 0xff] ^ (crc << 8));
}


unsigned short WirelessFT::crcBuf( char* buff, int len )
{
  int i;
  short crc = 0x1234; // CRC seed.

  for (i = 0; i < len; i++)
  {
    crc = crcByte(crc, buff[i]);
  }
  return crc;
}


int WirelessFT::udpStartStreaming()
{
  ROS_ERROR( "udpStartStreaming: IMPLEMENT ME!!!" );
  // bytes  start streaming:
  //  2     length including crc = 10
  //  1     sequence number, 0,1,2,...255,0,...
  //  1     value 1 = start_streaming_command
  //  4     number_of_packets, 0 for infinite
  //  2     crc

  char buffer[10];
  buffer[0] = 0;
  buffer[1] = (unsigned char) (0x00FF & 10); // length
  buffer[2] = udpCommandSequence;            // seq-number
  buffer[3] = (unsigned char) 1;             // start_streaming
  buffer[4] = (unsigned char) 0;             // number of packets
  buffer[5] = (unsigned char) 0;
  buffer[6] = (unsigned char) 0; // 10
  buffer[7] = (unsigned char) 0; // 255;

  unsigned short crc = crcBuf( buffer, 8 );
  buffer[8] = (unsigned char) (crc >> 8);
  buffer[9] = (unsigned char) (crc & 0x00ff);

  unsigned int length = 10;
  int n = write( udpSocket, buffer, length );
  ROS_INFO( "udpStartStreaming: wrote %d bytes", n );
}


int WirelessFT::udpStopStreaming()
{
  // bytes  stop streaming:
  //  2     length including crc = 6
  //  1     sequence number, 0,1,2,...255,0,...
  //  1     value 1 = start_streaming_command
  //  2     crc

  char buffer[6];
  buffer[0] = 0;
  buffer[1] = (unsigned char) (0x00FF & 6); // length including crc
  buffer[2] = udpCommandSequence;           // seq-number
  buffer[3] = (unsigned char) 2;            // stop_streaming

  unsigned short crc = crcBuf( buffer, 4 );
  buffer[4] = (unsigned char) (crc >> 8);
  buffer[5] = (unsigned char) (crc & 0x00ff);

  unsigned int length = 6;
  int n = write( udpSocket, buffer, length );
  ROS_INFO( "udpStopStreaming: wrote %d bytes", n );
}


int WirelessFT::udpPing()
{
  // bytes  ping:
  //  2     length including crc = 6
  //  1     sequence number, 0,1,2,...255,0,...
  //  1     value 4 = ping
  //  2     crc

  char buffer[6];
  buffer[0] = 0;
  buffer[1] = (unsigned char) (0x00FF & 6); // length including crc
  buffer[2] = udpCommandSequence;           // seq-number
  buffer[3] = (unsigned char) 4;            // stop_streaming

  unsigned short crc = crcBuf( buffer, 4 );
  buffer[4] = (unsigned char) (crc >> 8);
  buffer[5] = (unsigned char) (crc & 0x00ff);

  unsigned int length = 6;
  int n = write( udpSocket, buffer, length );
  ROS_INFO( "udpStopStreaming: wrote %d bytes", n );
}


int WirelessFT::udpResetTelnetSocket()
{
  // bytes  reset telnet socket:
  //  2     length including crc = 6
  //  1     sequence number, 0,1,2,...255,0,...
  //  1     value 5 = reset telnet socket
  //  2     crc

  char buffer[6];
  buffer[0] = 0;
  buffer[1] = (unsigned char) (0x00FF & 6); // length including crc
  buffer[2] = udpCommandSequence;           // seq-number
  buffer[3] = (unsigned char) 5;            // reset_telnet_socket

  unsigned short crc = crcBuf( buffer, 4 );
  buffer[4] = (unsigned char) (crc >> 8);
  buffer[5] = (unsigned char) (crc & 0x00ff);

  unsigned int length = 6;
  int n = write( udpSocket, buffer, length );
  ROS_INFO( "udpStopStreaming: wrote %d bytes", n );
}





int parseInteger( char* buffer, int pos ) {
  int value = ((0x00ff & buffer[pos]) << 24)
            + ((0x00ff & buffer[pos+1]) << 16)
            + ((0x00ff & buffer[pos+2]) << 8)
            + ((0x00ff & buffer[pos+3]) << 0);
  return value;
}


int WirelessFT::decodeDataPacket( char* buffer, unsigned int n_bytes ) {
  if (verbose > 2) ROS_INFO( "decodeDataPacket:" );
  char hex[18] = "0123456789ABCDEF_";


  if (verbose > 3) { // dump original packet
    for( unsigned int i=0; i < n_bytes; i++ ) {
      printf( "%.2x ", (0x00ff & buffer[i]) );
    }
    printf( "\n\n" );
    for( unsigned int i=0; i < n_bytes; i++ ) {
      int tmp = buffer[i];
      printf( "%c%c ", hex[0x000F&(tmp>>4)], hex[0x000F&tmp] );
      if ((i % 20) == 19) printf( "\n" );
    }
    printf( "\n" );

    printf( "timestamp %.8x\n", parseInteger( buffer, 0 ));
    printf( "sequence  %.8x\n", parseInteger( buffer, 4 ));
    printf( "status 1  %.8x\n", parseInteger( buffer, 8 ));
    printf( "status 2  %.8x\n", parseInteger( buffer, 12 ));
    printf( "battery   %.2d\n", (0x00ff & buffer[16]));
    printf( "mask      %.2x\n", (0x00ff & buffer[17]));
  }

  int pos = 18;
  for( int t=0; t < 6; t++ ) {
    if (verbose > 2) {
      printf( "transducer %d   %8d  %8d  %8d    %8d  %8d  %8d\n",
              (t+1),
              parseInteger( buffer, pos+0 ),
              parseInteger( buffer, pos+4 ),
              parseInteger( buffer, pos+8 ),
              parseInteger( buffer, pos+12 ),
              parseInteger( buffer, pos+16 ),
              parseInteger( buffer, pos+20 ) );
    }

    sensor_counts(t,0) = parseInteger( buffer, pos+0 );
    sensor_counts(t,1) = parseInteger( buffer, pos+4 );
    sensor_counts(t,2) = parseInteger( buffer, pos+8 );
    sensor_counts(t,3) = parseInteger( buffer, pos+12 );
    sensor_counts(t,4) = parseInteger( buffer, pos+16 );
    sensor_counts(t,5) = parseInteger( buffer, pos+20 );

    pos += 24;
  }
  if (verbose > 2) printf( "\n\n" );

  int seq = parseInteger( buffer, 4 );

  sensor_msgs::Joy joy;
  joy.header.stamp    = ros::Time::now();
  joy.header.frame_id = "Wireless FT";
  joy.header.seq      = seq;
  joy.axes.resize( 6*NUMBER_OF_STRAIN_GAGES ); // six channels on Wireless F/T
  for( int t=0; t < 6; t++ ) {
    for( int g=0; g < NUMBER_OF_STRAIN_GAGES; g++ ) {
      joy.axes[ t*6+g ] = sensor_counts(t,g);
    }
  }
  raw_sensor_counts_publisher.publish( joy );

  // convert to Wrench
  Eigen::VectorXd w4 = factory_calibrations[3].getWrench( sensor_counts.row(3) );
  Eigen::VectorXd w5 = factory_calibrations[4].getWrench( sensor_counts.row(4) );
  Eigen::VectorXd w6 = factory_calibrations[5].getWrench( sensor_counts.row(5) );
  // ...

  if (active_channels_mask & 0x01) {
    Eigen::VectorXd w1 = factory_calibrations[0].getWrench( sensor_counts.row(0) );
    geometry_msgs::WrenchStamped wrench1;
    wrench1.header.stamp = ros::Time::now();
    wrench1.header.seq   = seq;
    wrench1.header.frame_id = "transducer1";
    wrench1.wrench.force.x  = w1(0);
    wrench1.wrench.force.y  = w1(1);
    wrench1.wrench.force.z  = w1(2);
    wrench1.wrench.torque.x = w1(3);
    wrench1.wrench.torque.y = w1(4);
    wrench1.wrench.torque.z = w1(5);
    wrench_1_publisher.publish( wrench1 );
  }

  if (active_channels_mask & 0x02) {
    Eigen::VectorXd w2 = factory_calibrations[1].getWrench( sensor_counts.row(1) );
    geometry_msgs::WrenchStamped wrench2;
    wrench2.header.stamp = ros::Time::now();
    wrench2.header.seq   = seq;
    wrench2.header.frame_id = "transducer2";
    wrench2.wrench.force.x  = w2(0);
    wrench2.wrench.force.y  = w2(1);
    wrench2.wrench.force.z  = w2(2);
    wrench2.wrench.torque.x = w2(3);
    wrench2.wrench.torque.y = w2(4);
    wrench2.wrench.torque.z = w2(5);
    wrench_2_publisher.publish( wrench2 );
  }

  if (active_channels_mask & 0x04) {
    Eigen::VectorXd w3 = factory_calibrations[2].getWrench( sensor_counts.row(2) );
    geometry_msgs::WrenchStamped wrench3;
    wrench3.header.stamp = ros::Time::now();
    wrench3.header.seq   = seq;
    wrench3.header.frame_id = "transducer3";
    wrench3.wrench.force.x  = w3(0);
    wrench3.wrench.force.y  = w3(1);
    wrench3.wrench.force.z  = w3(2);
    wrench3.wrench.torque.x = w3(3);
    wrench3.wrench.torque.y = w3(4);
    wrench3.wrench.torque.z = w3(5);
    wrench_3_publisher.publish( wrench3 );
  }

  if (active_channels_mask & 0x08) {
    Eigen::VectorXd w3 = factory_calibrations[3].getWrench( sensor_counts.row(3) );
    geometry_msgs::WrenchStamped wrench4;
    wrench4.header.stamp = ros::Time::now();
    wrench4.header.seq   = seq;
    wrench4.header.frame_id = "transducer4";
    wrench4.wrench.force.x  = w4(0);
    wrench4.wrench.force.y  = w4(1);
    wrench4.wrench.force.z  = w4(2);
    wrench4.wrench.torque.x = w4(3);
    wrench4.wrench.torque.y = w4(4);
    wrench4.wrench.torque.z = w4(5);
    wrench_4_publisher.publish( wrench4 );
  }

  if (active_channels_mask & 0x10) {
    Eigen::VectorXd w5 = factory_calibrations[4].getWrench( sensor_counts.row(4) );
    geometry_msgs::WrenchStamped wrench5;
    wrench5.header.stamp = ros::Time::now();
    wrench5.header.seq   = seq;
    wrench5.header.frame_id = "transducer5";
    wrench5.wrench.force.x  = w5(0);
    wrench5.wrench.force.y  = w5(1);
    wrench5.wrench.force.z  = w5(2);
    wrench5.wrench.torque.x = w5(3);
    wrench5.wrench.torque.y = w5(4);
    wrench5.wrench.torque.z = w5(5);
    wrench_5_publisher.publish( wrench5 );
  }

  if (active_channels_mask & 0x20) {
    Eigen::VectorXd w6 = factory_calibrations[5].getWrench( sensor_counts.row(5) );
    geometry_msgs::WrenchStamped wrench6;
    wrench6.header.stamp = ros::Time::now();
    wrench6.header.seq   = seq;
    wrench6.header.frame_id = "transducer6";
    wrench6.wrench.force.x  = w6(0);
    wrench6.wrench.force.y  = w6(1);
    wrench6.wrench.force.z  = w6(2);
    wrench6.wrench.torque.x = w6(3);
    wrench6.wrench.torque.y = w6(4);
    wrench6.wrench.torque.z = w6(5);
    wrench_6_publisher.publish( wrench6 );
  }
}


int WirelessFT::readDataPacket()
{
    char buffer[2048];
    bzero( buffer, 2048 );

    // one data packet has 4+4+2*4+1+1+N_TRANSDUCERS*N_GAGES*4 bytes + 2;
    // for our configuration with 5 transducers and 6 gages/sensor,
    // we have 140 bytes...
    int n = read( udpSocket, buffer, 140 );
    if (n < 0) {
       ROS_ERROR( "Error reading from socket" );;
       return -1;
    }
    else {
       if (verbose > 2) ROS_INFO( "socket read: got %d bytes.", n );
       decodeDataPacket( buffer, 140 );
    }
    return 0;
}


/**
 * reset sensor bias (aka "tara"). At the moment,
 * clears the bias on all sensors. Command syntax is:
 * "BIAS s1 s2" where s1 = "1,2,3,4,5,6,or*" and s2="ON or OFF".
 * We use "BIAS * ON".
 */
bool WirelessFT::serviceCallback( std_srvs::Empty::Request &req, std_srvs::Empty::Response &res ) {
  std::string response;
  // telnetCommand( response, "bias 3 on\r\n"); // only channel 3
  telnetCommand( response, "bias * on\r\n");
  usleep( 0.2*1000*1000 );
}


void WirelessFT::run() {
  ROS_INFO( "WirelessFT::run()..." );

  // TODO: refactor into configure() method...
  std::string response;
  int status = telnetConnect();
  if (status == 0) ROS_INFO( "Connected to Wireless FT..." );
  else ROS_ERROR( "Failure to connect." );
  usleep( 3*1000*1000 );
  // telnetCommand( response, " \r\n" );
  // usleep( 1*1000*1000 );
  // telnetCommand( response, " \r\n" );
  // usleep( 1*1000*1000 );

  telnetCommand( response, "band\r\n" );
  // usleeps necessary to not get stuck in telnet communication
    usleep( 0.2*1000*1000 );

  telnetCommand( response, "ssid\r\n" );
    usleep( 0.2*1000*1000 );

  telnetCommand( response, "gateip\r\n" );
    usleep( 0.2*1000*1000 );

  telnetCommand( response, "ip\r\n", 5000 );
    usleep( 0.2*1000*1000 );

  telnetCommand( response, "bright\r\n" );
    usleep( 0.2*1000*1000 );

  telnetCommand( response, "xpwr off\r\n" );
    usleep( 0.2*1000*1000 );

  //telnetCommand( response, "bias 3 on\r\n");
  //  usleep( 0.2*1000*1000 );



  telnetCommand( response, "trans 1\r\n" );
  telnetCommand( response, "calib 1\r\n" );
  telnetCommand( response, "cal\r\n" );

  telnetCommand( response, "trans 2\r\n" );
  telnetCommand( response, "calib 1\r\n" );
  telnetCommand( response, "cal\r\n" );

  telnetCommand( response, "trans 3\r\n" );
  telnetCommand( response, "calib 1\r\n" );
  telnetCommand( response, "cal\r\n" );

/*
  telnetCommand( response, "trans 3\r\n" );
  telnetCommand( response, "calib 1\r\n" );
  telnetCommand( response, "cal\r\n" );

  telnetCommand( response, "trans 4\r\n" );
  telnetCommand( response, "calib 1\r\n" );
  telnetCommand( response, "cal\r\n" );

  telnetCommand( response, "trans 5\r\n" );
  telnetCommand( response, "calib 1\r\n" );
  telnetCommand( response, "cal\r\n" );
*/

  telnetCommand( response, "trans 6\r\n" );
  telnetCommand( response, "calib 1\r\n" );
  telnetCommand( response, "cal\r\n" );

  // active all selected channels
  for( int i=0; i < 6; i++ ) {
    std::stringstream ss;
    ss << "xpwr " << i << " on\r\n";
    if (active_channels_mask & (1 << i)) {
      telnetCommand( response, ss.str() );
      ROS_ERROR( "sending XPWR: %s", ss.str().c_str() );
    }
  }
  // telnetCommand( response, "xpwr on\r\n" );

  telnetCommand( response, "rate 125 16\r\n" );
  // telnetCommand( response, "filter 1 \n" );




  ROS_ERROR( "Connecting to UDP now..." );
  status = udpConnect();
  if (status == 0) ROS_INFO( "Connected at port 49152..." );

  udpStartStreaming(); // send start streaming
  streaming = true;

  unsigned int iteration = 0;
  unsigned int received = 0;
  ros::Rate rate( 125 );
  while( ros::ok() ) {
    if (verbose > 1) ROS_INFO( "WirelessFT: iteration %ul received %ul", iteration, received );
    iteration ++;

    try {
      readDataPacket();
      received++;
    }
    catch( ... ) {
      ROS_ERROR( "Exception while reading from UDP socket" );
    }

    ros::spinOnce();
    rate.sleep();
  }

  if (streaming) udpStopStreaming();
  telnetDisconnect();
}



void WirelessFT::shutdown() {
  ROS_ERROR( "WirelessFT.shutdown(): IMPLEMENT ME!!!" );
  if (streaming) udpStopStreaming();
  telnetDisconnect();
}


static WirelessFT * wireless_ft_ptr;


// we want our own handler for graceful reaction to cntl-c:
// stop streaming and disconnect from the telnet control port.
//
void SIGINT_handler(int signal)
{
  ROS_ERROR( "tams_wireless_ft: received SIGINT, stopping streaming..." );
  if (wireless_ft_ptr != NULL) {
    wireless_ft_ptr->shutdown();
  }
  usleep( 1000*1000 );
  ROS_ERROR( "tams_wireless_ft: exiting now..." );
  exit( 0 );
}



int main( int argc, char ** argv ) {
  std::signal(SIGINT, SIGINT_handler );
  ros::init( argc, argv, "WirelessFT", 1 ); // no default cntl-c handler
  ros::AsyncSpinner spinner( 2 );
  spinner.start();

  WirelessFT wirelessFT;
  wirelessFT.run();

}
