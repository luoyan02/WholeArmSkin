#!/bin/bash

# Find the next available bag file number
count=1
while [ -f "bag_$count.bag" ]; do
  count=$((count + 1))
done

# Record the bag file
rosbag record -O "bag_$count.bag" -a