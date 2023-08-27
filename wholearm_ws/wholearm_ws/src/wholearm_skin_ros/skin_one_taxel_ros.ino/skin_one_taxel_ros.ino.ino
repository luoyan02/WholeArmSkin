#include <CapacitiveSensor.h>
#include <ros.h>
#include <ros/time.h>
#include <std_msgs/UInt32.h>
#include <wholearm_skin_ros/TaxelData.h>

// ROS taxel interface
ros::NodeHandle nh;

wholearm_skin_ros::TaxelData msg1;
wholearm_skin_ros::TaxelData msg2;
wholearm_skin_ros::TaxelData msg3;
wholearm_skin_ros::TaxelData msg4;
wholearm_skin_ros::TaxelData msg5;

ros::Publisher pub1("skin/taxel_1", &msg1);
ros::Publisher pub2("skin/taxel_2", &msg2);
ros::Publisher pub3("skin/taxel_3", &msg3);
ros::Publisher pub4("skin/taxel_4", &msg4);   
ros::Publisher pub5("skin/taxel_5", &msg5);

//set 13 as sending pin, 12 as receive pin
CapacitiveSensor sensor_1 = CapacitiveSensor(13,12);
CapacitiveSensor sensor_2 = CapacitiveSensor(11,10);
CapacitiveSensor sensor_3 = CapacitiveSensor(9,8);
CapacitiveSensor sensor_4 = CapacitiveSensor(7,6);
CapacitiveSensor sensor_5 = CapacitiveSensor(5,4);


void setup() {
  // put your setup code here, to run once:
  nh.initNode();
  nh.advertise(pub1);
  nh.advertise(pub2);
  nh.advertise(pub3);
  nh.advertise(pub4);
  nh.advertise(pub5);
  Serial.begin(115200);
  while(!Serial);
//  Serial.println("test begin");

}

void loop() {
//  // put your main code here, to run repeatedly:

////  increase samples --> higher resolution --> higher delay
  long cs_sensor_1 = sensor_1.capacitiveSensorRaw(1);
  long cs_sensor_2 = sensor_2.capacitiveSensorRaw(1);
  long cs_sensor_3 = sensor_3.capacitiveSensorRaw(1);
  long cs_sensor_4 = sensor_4.capacitiveSensorRaw(1);
  long cs_sensor_5 = sensor_5.capacitiveSensorRaw(1);
  
  msg1.cdc = cs_sensor_1;
  msg1.header.stamp = nh.now();
  msg2.cdc = cs_sensor_2;
  msg2.header.stamp = nh.now();
  msg3.cdc = cs_sensor_3;
  msg3.header.stamp = nh.now();
  msg4.cdc = cs_sensor_4;
  msg4.header.stamp = nh.now();
  msg5.cdc = cs_sensor_5;
  msg5.header.stamp = nh.now();

  
//  msg.header.stamp = ros::Time::now();
////  long cs_sensor_2 = sensor_2.capacitiveSensorRaw(50);
//
////  Serial.print("sensor:");
////  Serial.println(cs_sensor_1);


  pub1.publish(&msg1);
  pub2.publish(&msg2);
  pub3.publish(&msg3);
  pub4.publish(&msg4);
  pub5.publish(&msg5);
  nh.spinOnce();
  delay(10);
//  Serial.print("1: ");
//  Serial.print(cs_sensor_1);
//  Serial.print(",  ");
//  Serial.print(cs_sensor_2);
//  Serial.print(",  ");
//  Serial.print(cs_sensor_3);
//  Serial.print(",  ");
//  Serial.print(cs_sensor_4);
//  Serial.print(",  ");
//  Serial.println(cs_sensor_5);
//
////  Serial.print(",");
////  Serial.println(5000);

//  long cs_sensor_1 = sensor_1.capacitiveSensorRaw(1);
//  msg1.cdc = cs_sensor_1;
//  msg1.header.stamp = nh.now();
//  pub1.publish(&msg1);
//  
//  long cs_sensor_2 = sensor_2.capacitiveSensorRaw(1);
//  msg2.cdc = cs_sensor_2;
//  msg2.header.stamp = nh.now();
//  pub2.publish(&msg2);
//  
//  long cs_sensor_3 = sensor_3.capacitiveSensorRaw(1);
//  msg3.cdc = cs_sensor_3;
//  msg3.header.stamp = nh.now();
//  pub3.publish(&msg3);
//  
//  long cs_sensor_4 = sensor_4.capacitiveSensorRaw(1);
//  msg4.cdc = cs_sensor_4;
//  msg4.header.stamp = nh.now();
//  pub4.publish(&msg4);
//  
//  long cs_sensor_5 = sensor_5.capacitiveSensorRaw(1);
//  msg5.cdc = cs_sensor_5;
//  msg5.header.stamp = nh.now();
//  pub5.publish(&msg5);
//  
//  nh.spinOnce();
  
}
