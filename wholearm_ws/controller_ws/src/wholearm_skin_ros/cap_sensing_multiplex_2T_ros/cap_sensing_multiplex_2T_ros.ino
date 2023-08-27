#include <Wire.h>
#include <Protocentral_FDC1004.h>

#include <ros.h>
#include <ros/time.h>
#include <std_msgs/UInt32.h>
#include <wholearm_skin_ros/TaxelData.h>

#define TCAADDR 0x70

#define UPPER_BOUND  0X4000                 // max readout capacitance
#define LOWER_BOUND  (-1 * UPPER_BOUND)
#define CHANNEL3 3  
#define CHANNEL1 1

// ROS taxel interface
ros::NodeHandle nh;

wholearm_skin_ros::TaxelData msg1;
// wholearm_skin_ros::TaxelData msg2;


ros::Publisher pub1("skin/taxel_1", &msg1);
// ros::Publisher pub2("skin/taxel_2", &msg2);


FDC1004 FDC;

// helper function for mux 
void tcaselect(uint8_t bus) { 
  // bus selects which of tca outputs to write to 
  if (bus > 7) return;
 
  Wire.beginTransmission(TCAADDR);
  Wire.write(1 << bus); 
  Wire.endTransmission();  
}


void setup() {
  // ros
  nh.initNode();
  nh.advertise(pub1);
  // nh.advertise(pub2);
  Serial.begin(115200);
  
  while (!Serial);
  delay(1000);

  // i2c
  Wire.begin();
    
  Serial.begin(115200);

  tcaselect(7);
}

void loop() {
  // put your main code here, to run repeatedly:
  float measurement = 0;

  /*
   * SENSOR 1 READING
   */

  delay(15);
  FDC.configureMeasurementSingle(CHANNEL3, CHANNEL3, 0);
  delay(15);
  FDC.triggerSingleMeasurement(CHANNEL3, FDC1004_100HZ);

  delay(15);
  uint16_t value[2];

  if (! FDC.readMeasurement(CHANNEL3, value))
  {
    int16_t msb = (int16_t) value[0];
    int32_t capacitance = ((int32_t)457) * ((int32_t)msb); //in attofarads
    capacitance /= 1000;   //in femtofarads
    capacitance += ((int32_t)3028); // * ((int32_t)capdac);
    
    if(((float)capacitance/1000) < 1000){
        msg1.cdc = (float)capacitance;
        msg1.header.stamp = nh.now();
    }
  } // end measurement if

  pub1.publish(&msg1);
  nh.spinOnce();

  /*
   * SENSOR 2 READING
   */

/*
  delay(15);
  FDC.configureMeasurementSingle(CHANNEL1, CHANNEL1, 0);
  delay(15);
  FDC.triggerSingleMeasurement(CHANNEL1, FDC1004_100HZ);

  delay(15);

  if (! FDC.readMeasurement(CHANNEL1, value))
  {
    int16_t msb = (int16_t) value[0];
    int32_t capacitance = ((int32_t)457) * ((int32_t)msb); //in attofarads
    capacitance /= 1000;   //in femtofarads
    capacitance += ((int32_t)3028); // * ((int32_t)capdac);

    if(((float)capacitance/1000) < 1000){
        msg2.cdc = (float)capacitance/1000;
        msg2.header.stamp = nh.now();
    }

    delay(100);
  } // end measurement if

  pub2.publish(&msg2);
  nh.spinOnce();
  */

  
} // end loop 
