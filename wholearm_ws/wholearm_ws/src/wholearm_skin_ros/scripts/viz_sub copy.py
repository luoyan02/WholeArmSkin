#! /usr/bin/env python 

import rospy
# Other imports
import rospy
from std_msgs.msg import Float32MultiArray
from visualization_msgs.msg import Marker, MarkerArray
import random
import tf
import tf2_ros
import numpy as np
import matplotlib.pyplot as plt
import time
import rospy
from sensor_msgs.msg import JointState
from scipy.spatial.transform import Rotation as R
# Program Code

time.sleep(10)
cmap = plt.cm.Reds

pub = rospy.Publisher("random_float_markers", MarkerArray, queue_size=10)
#x,y,z,roll,pitch,yaw

#taken from Fusion 360 model in mmm and degrees, ROS wants meters and radians
pos = [[.013964,44.504,.042851, -.5, .5, -.5, .5], [-.013978, .044373, .042945, -.5, .5, -.5, .5],[.015138,.045408,.09334,-.5, .5, -.5, .5],
[-.015254,.045412, .093575, -.5, .5, -.5, .5], [.015,.047612,.1381,-.5, .5, -.5, .5], [-.014998, .047613, .137402, -.5, .5, -.5, .5]]

"""
[0, -59.434, 260.438, 81.303, 0, 270.0], [-20.672, -57.692, 304.084, 93.082, 0, 250.00], [20.673, -57.702, 304.086, 93.072, 0, 280], 
[-19.573, -54.952, 348.666, 93.562, 0, 250], [19.843, -54.885, 348.823, 93.577, 0, 280], [-18.162, -52.60, 394.471, 91.373, 0, 250], 
[18.181, -52.619, 394.175, 91.432, 0, 280],

[0, -56.428, 440.124, 87.95, 180, 90], [36.757, -37.739, 440.124, 90, 180, 150], [36.147, 4.352, 440.124, 70.297, 160, 210], 
[.047, 23.07, 440.023, 59.734, 160, 270], [-35.955, 4.276, 440.124, 70.185, 160, 330], [-37.018, -37.855, 440.124, 9.143, 180, 30],

[0.041, -57.747, 484.514, 90.00, 190, 90], [39.956, -34.544, 484.514, 90 ,190 , 150], [39.719, 11.454, 484.514, 90, 180, 210], 
[0,34.25, 484.495, 90, 180, 270], [-39.671, 11.535, 484.514, 90, 180, 330], [-40.002, -34.461, 484.514, 90, 190, 30],

 [.02, -57.016, 526.302, 101.598, 180, 90],[39.129, -34.183, 526.677, 96.579, 180, 150], [39.217, 11.022, 526.982, 92.981, 180, 210], 
 [0.05, 33.731, 527.23, 91.859, 180, 270], [-39.167, 11.113, 526.982, -92.982, 180, 330], [-39.167, -34.081, 526.673, 96.605, 180, 30],
 
 [8.739, 31.523, 570.829, 91.206, 0, 90], [-8.844, 31.499, 570.829, 91.207, 0, 90], [10.069, 32.338, 622.447, 86.715, 0, 90], 
 [-9.895, 32.332, 622.08, 86.73, 0, 90], [11.872, 34.638, 667.549, 86.336, 0, 90], [-11.701, 34.645, 667.449, 86.336, 0, 90], 
 [0, 37.252, 707.728, 89.86, 0, 90],
 
 [0, -73.572, 691.351, 85.557, 0, 270], [-14.701, -72.926, 725.332, 93.521, 0, 270], [14.749, -72.921, 725.327, 93.523, 0, 270],
  [-11.652, -69.509, 767.149, 95.538, 0, 270], [11.772, -69.488, 767.163, 95.547, 0, 270], [-8.496, -65.496, 809.544, 97.087, 0, 270], 
  [8.412, -65.50, 809.412, 82.932, 0, 270],
  
  [-.005, -62.5, 858.469, 94.439, 180, 90], [29.40, -44.479, 858.469, 92.926, 180, 150], [27.66, -11.536, 858.469, 74.875, 160, 210], 
  [0, 3.741, 858.469, 66.96, 160, 270], [-27.68, -11.514, 858.469, 74.875, 160, 330], [-29.418, -44.479, 858.469, 92.924, 180, 30],
  
  [-.044, -59.498, 909.882, 90, 180, 90], [30.059, -42.429, 909.90, 90, 180, 150], [30.56, -7.439, 909.90, 90, 180, 210],
   [0, 10.5, 909.9, 90, 180, 270], [-30.464, -7.268, 909.9, 90 , 180, 330], [-30.157, -42.263, 909.9, 90, 180, 30],
   
   [0, -59.111, 945.212, 96.617,190, 90], [29.488, -41.053, 945.212, 99.922, 200, 150], [29.948, -6.737, 945.212, 81.286, 180, 210], 
   [0, 11.14, 945.238, 84.985, 180, 270], [-29.582, -6.737, 945.212, 81.259, 180, 330], [-29.852, -41.207, 945.212, 81.259, 200, 30],
   
   [14.885, 22.245, 1000.345, 73.447, 20.489, 78], [-14.885, 22.245, 1000.345, 73.447, 20.489, 102] , [0, 28.276, 1030.399, 98.374, 0, 90],
   
   [0, -77.824, 1010.989, 84.141, 0, 270], [-14.146, -71.622, 1039.875, 106.657, -20.176, 258], [14.131, -71.624, 1039.876, 106.657, -20.176, 282],
   
   [.007, -61.50, 1091.835, 95.965, 5.965, 270], [30.306, -42.989, 1091.835, 100.465, 18, 330], [29.084, -8.7, 1091.835, 74.562, 18, 30], 
   [-.004, 9.295, 1091.835, 78.054, 11.946, 90], [-29.111, -8.7, 1091.835, 74.579, 18, 150], [-30.278, -42.989, 1091.835, 100.476, 18, 210],
   
   [0, -59.85, 1131.38, 90, 180, 90], [30.249, -42.457, 1131.382, 90, 180, 150], [30.373, -7.458, 1131.382, 90, 180, 210], 
   [0, 10.15, 1131.382, 90, 180, 270], [-30.373, -7.459, 1131.382, 90, 180, 330], [-30.248, -42.458, 1131.382, 90, 180, 30]]
"""

true_pos = np.copy(pos)
rospy.init_node('random_float_array_subscriber')

tf2_buffer = tf2_ros.Buffer()
tf2_listener = tf2_ros.TransformListener(tf2_buffer)

def callback(data):
    
    try:
        tran = tf2_buffer.lookup_transform("base_link", "shoulder_link", rospy.Time(0))
    except (tf2_ros.LookupException, tf2_ros.ConnectivityException, tf2_ros.ExtrapolationException):
        return
    x,y,z = tran.transform.translation.x, tran.transform.translation.y, tran.transform.translation.z
    a,b,c,d = tran.transform.rotation.x, tran.transform.rotation.y, tran.transform.rotation.z, tran.transform.rotation.w
    # yaw,pitch,roll =  (tf.transformations.euler_from_quaternion([tran.transform.rotation.x, tran.transform.rotation.y, tran.transform.rotation.z, tran.transform.rotation.w]))
    # yaw, pitch, roll = yaw*180/np.pi, pitch*180/np.pi, roll*180/np.pi
    arr = np.asarray([x,y,z,a,b,c,d])
    for i in range(len(pos)):
        if i >= len(data.data):
            return
        #new_position = pos[i][:3] + arr
        #old_orientation = R.from_euler('xyz', pos[i][3:], degrees=False).as_matrix()
        #new_orientation = np.matmul(rot_mat, old_orientation)
        #true_pos[i] = np.concatenate((new_position, R.from_matrix(new_orientation).as_euler('xyz')), axis=None)
        true_pos[i] = np.asarray(pos[i]) + arr
        # true_pos[i] = np.asarray(pos[i]) + arr
        if i == 0:
            print("transform: ", arr)
            print("updated pos: ", true_pos[i])
        marker_array = MarkerArray()
        value = data.data[i]
        marker = Marker()
        marker.header.frame_id = "base_link"
        marker.type = marker.ARROW
        marker.action = marker.ADD
        min = 0
        max = 20
        normalized = np.abs((value - min) / (max - min))
        if normalized >=1:
            normalized = .99
        elif normalized < 0:
            normalized = 0
        color = cmap(normalized*15)
        marker.color.a = 1
        marker.color.r = color[0]
        marker.color.g = color[1]
        marker.color.b = color[2]
        marker.scale.x = normalized/10 * 7.5
        marker.scale.y = .0075
        marker.scale.z = .0075
        marker.pose.position.x = true_pos[i][0] 
        marker.pose.position.y = true_pos[i][1]
        marker.pose.position.z = true_pos[i][2]
        marker.pose.orientation.x = true_pos[i][3]
        marker.pose.orientation.y = true_pos[i][4]
        marker.pose.orientation.z = true_pos[i][5]
        #quaternion = R.from_matrix(new_orientation).as_quat()
        #tf.transformations.quaternion_from_euler(np.radians(true_pos[i][3]), np.radians(true_pos[i][4]), np.radians(true_pos[i][5]))
        #print ("idx: ", i, " Quat: ", quaternion)
        #marker.pose.orientation.x = quaternion[0]
        #marker.pose.orientation.y = quaternion[1]
        #marker.pose.orientation.z = quaternion[2]
        #marker.pose.orientation.w = quaternion[3]
        marker.id = i
        marker_array.markers.append(marker)
    pub.publish(marker_array)

rospy.Subscriber("random_float_array", Float32MultiArray, callback)

#rospy.Subscriber("/joint_states", JointState, joint_state_callback)
rospy.spin()
# End of Code