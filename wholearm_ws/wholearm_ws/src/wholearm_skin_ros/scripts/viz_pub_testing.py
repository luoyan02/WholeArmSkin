#! /usr/bin/env python 
import rospy
from std_msgs.msg import Float32MultiArray
import math
import random

def talker():
    pub = rospy.Publisher('random_float_array', Float32MultiArray, queue_size=10)
    rospy.init_node('random_float_array_publisher', anonymous=True)
    rate = rospy.Rate(30)  # 30 Hz
    t = 0.0
    while not rospy.is_shutdown():
        float_array = Float32MultiArray()
        float_array.data = [(.2*math.sin(t*2*math.pi+i*math.pi/3) + 0.5) for i in range(9)]
        #float_array.data = [.5 for i in range(8)]
        print(float_array.data)
        pub.publish(float_array)
        t += 0.01
        rate.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
