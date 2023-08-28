
# Terminal 1
In `wholearm_ws`:
```
cd controller_ws 
roscore
```

# Terminal 2
In `wholearm_ws`:
```
cd wholearm_ws
source devel/setup.bash 
rosrun rosserial_python serial_node.py _port:=/dev/ttyUSB0 _baud:=115200
```
enable the arduino to start publishing the TaxelData

# Terminal 3
In `wholearm_ws`:
```
cd wholearm_ws
source devel/setup.bash 
rostopic echo skin/taxels
```
skin/taxels is your topic. If everything went well, you will see the data being printed out in the terminal

# Terminl 4
In `wholearm_ws`:
```
cd wholearm_ws
source devel/setup.bash 
rosrun wholearm_skin_ros custom_taxel_pub.py
```
This will init a node and publish the TaxelData to the topic '/skin/taxel_fast/'

# Terminal 5
In `wholearm_ws`:
```
cd wholearm_ws
source devel/setup.bash 
rosrun wholearm_skin_ros data_collection.py
```
if everything goes well, it will begin to collect data and save it into the 'data_collection_filename.pickle' file.
You can see the values printed to the terminal once the zero offset for taxel values has been calculated.

You can press 'Ctrl+C' to stop the process whenever you think you are done.

then, you can run
```
rosrun wholearm_skin_ros plot_test.py
```
to see a raw picture and check if this is what you want
if the data looks nice, then all you need to do is write a scripts to draw a nice figure with this data!




