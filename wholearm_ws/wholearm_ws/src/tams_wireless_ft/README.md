# tams_wireless_ft

ROS driver for the ATi Wireless-FT force/torque sensor system.

This package provides a ROS caktin package for the handheld 
Wireless-FT force/torque measurment system
from ATi Industrial Automation, Inc.


## Setup and Installation

You will need [ROS] (wiki.ros.org), version Indigo or newer.
The software has only been tested using Ubuntu Linux 14.04 LTS
and 16.04 LTS, but should work on newer versions as well.

* To use this package, you will first need the ATi Wireless-FT
  handheld device
  (https://www.ati-ia.com/Library/documents/Wireless_F-T_Flyer.pdf),
  plus one or more of the ATi force/torque transducers
  (https://www.ati-ia.com/products/ft/sensors.aspx).

* Clone this repository into your catkin workspace and run `catkin_make`.


## Running the software

* Edit one of the provided launch files and configure the IP-address,
  TCP and UDP ports of your Wireless-FT system.

* Configure which Wireless F/T channels (1..6) to use, and select
  baudrate, filtering etc.

* Switch on your Wirelss F/T system and launch your node.
  The measured force/torque values are published as timestamped
  `WrenchStamped` messages.

* The sensors are typically factory calibrated, but offsets will depend
  on the sensor orientation and static payload. 
  If necessary, call the `reset_bias` service to zero the
  measurements (currently, all forces/torques for all sensors).


## Troubleshooting

* Sometimes, killing the node via cntl-c keeps the UDP connection open.
  Power-cycle the Wireless F/T system and wait until it has booted
  before trying to reconnect.


## What is in here?


    config/             - sample rviz and plotjuggler configuration files
    doc/                - example telnet session for device initialization
                          and interactive configuration; example raw data.
    launch/             - sample launch files
    scripts/            - utility scripts
    src/wireless_ft.src - the actual driver / ROS node











