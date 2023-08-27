/****************************************************************
 * Takes the readings from all sensors in femtofarads, puts them in an 
 *      array, and sends the array over the topic 
 * Note: FDC library has been modified from the default installation
 ****************************************************************/
 
#include <Wire.h>
#include <Protocentral_FDC1004.h>

#include <ros.h>
#include <ros/time.h>
#include <std_msgs/UInt16.h>
#include <wholearm_skin_ros/TaxelData.h>

#define SENSOR1 3 // sensor 1 uses channel 3
#define SENSOR2 1 // sensor 2 uses channel 1
uint8_t TCAADDR[8] = { 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77 };
#define UNUSED 5 // need one unused port on each multiplexer

#define NUM_TAXELS 78

FDC1004 FDC;

// ROS taxel interface
ros::NodeHandle nh;

wholearm_skin_ros::TaxelData msg;
ros::Publisher pub("skin/taxels", &msg);

/*
 * format of array 
 *    every port of the multiplexer is connected to 2 taxels, 
 *        meaning 14 sensors per multiplexer 
 *        -- even numbers correspond to the first taxel, 
 *        -- odd numbers correspond to the second taxel
 *    multiplexer | indeces
 *           0x70 | [ 0:13]
 *           0x71 | [14:27]
 *           0x72 | [28:41]
 *           0x73 | [42:55]
 *           0x74 | [56:69]
 *           0x75 | [70:83]
 *           0x76 | [84:97]
 *           0x77 | [98:111]
 */
//uint16_t taxel_readings[2]; // NUM_TAXELS];

/****************************************************************
 * HELPER FUNCTIONS
 ****************************************************************/

/*
 * tcaselect
 * parameters: 
 *    tcaaddress: i2c address of the selected multiplexer
 *    bus: multiplexer port (0 through 7) to send data over 
 * selects which bus in the system to transmit i2c message over
 */
void tcaselect(uint8_t bus, int tcaaddress) { 
  // bus selects which of tca outputs to write to 
  if (bus > 7) return;
 
  Wire.beginTransmission(tcaaddress);
  Wire.write(1 << bus); 
  Wire.endTransmission();  
}

/*
 * deselect
 * parameters: 
 *    tcaaddress: i2c address of the multiplexer that is getting read from 
 * deselects the unused multiplexers to avoid interference when reading 
 */
void deselect_others( int tcaaddress ) {
  for (int i = 0; i < 8; i++) {
    if (TCAADDR[i] != tcaaddress){
      Wire.beginTransmission(TCAADDR[i]);
      Wire.write(1 << UNUSED); 
      Wire.endTransmission();  
    }
  }
}

/*
 * gettaxelreading
 * parameters:
 *    channel, defined by which sensor is chosen 
 * returns: 
 *    capacitance in femtofarads of sensor, float 
 * gets capacitance reading from single taxel
 */
uint16_t gettaxelreading(uint8_t channel) {
  delay(10);
  FDC.configureMeasurementSingle(channel, channel, 0);
  delay(10);
  FDC.triggerSingleMeasurement(channel, FDC1004_100HZ);

  delay(10);
  uint16_t value[2];

  if (! FDC.readMeasurement(channel, value))
  {
    int16_t msb = (int16_t) value[0];
    int32_t capacitance = ((int32_t)457) * ((int32_t)msb); //in attofarads
    capacitance /= 1000;   //in femtofarads
    capacitance += ((int32_t)3028); // * ((int32_t)capdac);

    return (uint16_t)capacitance;
  } // end measurement if
}

/****************************************************************
 * MAIN CODE
 ****************************************************************/

void setup() {
  // ros
  nh.initNode();
  nh.advertise(pub);
  
  Serial.begin(115200);
  while (!Serial);
  delay(1000);

  // i2c
  Wire.begin();
  tcaselect(0, 0X71); // switch to empty output 
//  tcaselect(7, 0X70);
}

void loop() {

  /*
  float measurement = 0;
  uint8_t sensor = 0;
  uint8_t mult_addr = 0;
  uint8_t bus = 0;

  for (int t = 0; t < NUM_TAXELS; t++){
    // choose which multiplexer to use 
    mult_addr = TCAADDR[(uint8_t)(t/14)];
    
    // choose which bus to use
    bus = (uint8_t)((t%14)/2);
    if (bus >= 5) bus++; // offset since 5 is unused bit 

    deselect_others( mult_addr );
    tcaselect( bus, mult_addr );

    // choose which sensor to use 
    if (t%2 == 0) sensor = SENSOR1;
    else          sensor = SENSOR2;
    taxel_readings[t] = gettaxelreading( sensor );
  }
  */

  uint16_t c[2];

  float measurement = 0;

  /* MULTIPLEXER 0, SENSOR 1 */
  tcaselect(0, 0X71); 
//  tcaselect(7, 0X70);
  c[0] = gettaxelreading( SENSOR1 );
  c[1] = gettaxelreading( SENSOR2 );

  /* MULTIPLEXER 1, SENSOR 1 */
//  tcaselect(1, 0X70); // switch to empty output 
//  tcaselect(0, 0X71);
//  c[1] = gettaxelreading( SENSOR1 );

  msg.cdc = c;
  msg.cdc_length = 2;
  msg.header.stamp = nh.now();

  pub.publish(&msg);
  nh.spinOnce();
  
  
} // end loop 
