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

#define TCAADDR1 0x77 // 1st link multiplexer 111
#define TCAADDR2 0x74 // 2nd link multiplexer 100
#define TCAADDR3 0x71 // 3rd link multiplexer 001
#define TCAADDR4 0x72 // 4th link multiplexer 010

/*
 I2C Address
// R1 R2 R3
// 0  0  0   0x70
// 0  0  1   0x71
// 0  1  0   0x72
// 0  1  1   0x73
// 1  0  0   0x74
// 1  0  1   0x75
// 1  1  0   0x76
// 1  1  1   0x77
*/

#define UPPER_BOUND  0X4000                 // max readout capacitance
#define LOWER_BOUND  (-1 * UPPER_BOUND)
#define ONEA 0 // channel
#define ONEB 1
#define TWOA 2
#define TWOB 3
#define MEASURMENT 5 // need one unu sed port on each multiplexer

//taxel num+1, count from 1
#define NUM_TAXELS 1

int capdac = 5;

FDC1004 FDC;

// ROS taxel interface
ros::NodeHandle nh;

wholearm_skin_ros::TaxelData msg;
ros::Publisher pub("skin/taxels", &msg);

/****************************************************************
 * HELPER FUNCTIONS
 ****************************************************************/

void tcaselect(uint8_t bus, int tcaaddress) { 
  // bus selects which of tca outputs to write to 
  if (bus > 7) return;
  
  Wire.beginTransmission(tcaaddress);
  Wire.write(1 << bus); 
  Wire.endTransmission();
}

uint16_t gettaxelreading(uint8_t channel) {
  FDC.configureMeasurementSingle(channel, channel, capdac);
  FDC.triggerSingleMeasurement(channel, FDC1004_100HZ);

  //wait for completion
  delay(10);
  uint16_t value[2];
  if (! FDC.readMeasurement(channel, value))
  {
    int16_t msb = (int16_t) value[0];
    int32_t capacitance = ((int32_t)457) * ((int32_t)msb); //in attofarads
    capacitance /= 1000;   //in femtofarads
    capacitance += ((int32_t)3028) * ((int32_t)capdac);

    return (uint16_t) capacitance;
  }
}

/****************************************************************
 * MAIN CODE
 ****************************************************************/

void setup() {
  nh.initNode();
  nh.advertise(pub);

  Wire.begin(); // join i2c bus
  Serial.begin(115200); //start serial for output
  while (!Serial);
  delay(1000);
}


void loop() {

  uint16_t c[NUM_TAXELS] = {0};

  float measurement = 0;

  /* MULTIPLEXER 1 */
  tcaselect(0, TCAADDR1);  //scl0 sda0
  c[0] = gettaxelreading( ONEB );

  Serial.println(c[0]);

  msg.cdc = c;
  msg.cdc_length = NUM_TAXELS;
  msg.header.stamp = nh.now();

  pub.publish(&msg);
  nh.spinOnce();
  
} // end loop 
