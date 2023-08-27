## Skin Calibration

Packages required: `tams_wireless_ft`, `pr_controls_msgs` (for taring F/T sensor readings)

Don't forget to run `source devel/setup.bash` everytime you open a new terminal in the root of your workspace to source it.

Installation required for interfacing Arduino with ROS

`sudo apt-get install ros-noetic-rosserial ros-noetic-rosserial-arduino`

See this [tutorial](http://wiki.ros.org/rosserial_arduino/Tutorials/Arduino%20IDE%20Setup) on how to interact with Arduino using ROS.

### Steps to perform calibration

Plug in the Arduino. Make sure that the connector to the multiplexer is connected to the "top" of the multiplexer (words are upright).

The arduino code is in `test_link_read.ino`. It publishes an array with all of the capacitances from each taxel. 

To give Arduino connection permission, use 'sudo chmod a+rw /dev/ttyACM0' 

Make sure `roscore` is running.

Start publishing the taxel data, `rosrun rosserial_python serial_node.py _port:=/dev/ttyACM0 _baud:=115200`. You can check that the taxel data is being published correctly by running `rostopic echo skin/taxels` (where skin/taxels is your topic) and seeing the data being printed out in the terminal.

In a separate terminal, run `rosrun wholearm_skin_ros custom_taxel_pub.py`

In a separate terminal, start the F/T sensor `roslaunch tams_wireless_ft wireless_ft.launch`

Before collecting data for calibration, hold the F/T sensor above the surface and perform taring `rosservice call wireless_ft/reset_bias` (separate terminal). Always make sure the F/T sensor is well-tared. For taring the skin, run `rosservice call data_collection/reset_skin_bias true`. This step is only necessary if you want to tare the skin while data_collection is running (the skin is automatically tared at the beginning of the data collection). 

Now run `rosrun wholearm_skin_ros data_collection.py` to start the data collection. This node will start printing values once the zero offset for taxel values has been calculated. Post this, you can start collecting data using the intruder.

Once you're done, press `Ctrl + c` to stop the script and save the data.

After this, run `rosrun wholearm_skin_ros calibration.py` to fit the calibration function. Make sure to change the file name in the script to the file name of the data you just collected. 

To test the function, run `rosrun wholearm_skin_ros inference.py`. This will publish the force readings obtained from the skin on `/calibration` topic.

You can use `rqt_plot` to view the plots for `/calibration` and ground truth data on `forque/forqueSensor/wrench/force/z`.

### Development
Feel free to play around with the calibration function in `calibration.py` and filter function in `data_collection.py` and `inference.py`.
