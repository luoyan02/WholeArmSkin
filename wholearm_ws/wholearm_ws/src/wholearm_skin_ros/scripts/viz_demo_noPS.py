import rospy
from visualization_msgs.msg import Marker
import numpy as np
import math
from std_msgs.msg import Float32MultiArray

def publish_cubes():
    rospy.init_node("cube_markers")
    pub = rospy.Publisher("cube_markers", Marker, queue_size=10)
    rate = rospy.Rate(30) # 30 Hz

    marker = Marker()
    marker.header.frame_id = "world"
    marker.type = Marker.CUBE
    marker.action = Marker.ADD
    marker.scale.x = 0.1
    marker.scale.y = 0.1
    marker.color.r = 1.0
    marker.color.g = 0.0
    marker.color.b = 0.0
    marker.color.a = 1.0

    t = 0.0
    while not rospy.is_shutdown():
        for i in range(8): 
            marker.id = i 
            if i <= 4:
                marker.pose.position.x = i * 0.15 - 0.225
                marker.pose.position.y = 0
            elif i <=6:
                 marker.pose.position.x = 0.075 + (i-4) * 0.15 - 0.225
                 marker.pose.position.y = .15
            else:
                marker.pose.position.x = (i-5) * 0.15 - 0.225
                marker.pose.position.y = .30
            marker.pose.position.z = 0.0
            marker.scale.z = .2*math.sin(t*2*math.pi+marker.id*math.pi/3) + 0.5
            marker.pose.position.z = marker.scale.z / 2
            marker.color.a = max(0.4, (marker.scale.z - 0.5))
            pub.publish(marker)
        t += 0.01
        rate.sleep()

if __name__ == "__main__":
    try:
        publish_cubes()
    except rospy.ROSInterruptException:
        pass
