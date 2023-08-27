import rospy
import numpy as np
from std_msgs.msg import Float32MultiArray, MultiArrayDimension
from sensor_msgs.msg import Image
from yui_bathing.srv import Perception, PerceptionResponse
from yui_bathing.srv import PatchProcessor, PatchProcessorResponse
import time
# This is a dummy perception node with a service that responds with a dummy image

def perception_callback(req):
    # Create a dummy image
    print ("Running segmentation model...")
    img = Image()
    img.header.stamp = rospy.Time.now()
    img.width = 640
    img.height = 480
    img.encoding = "rgb8"
    img.is_bigendian = False
    img.step = 640 * 3
    img.data = [1] * 640 * 480 * 3
    time.sleep(1)
    print ("Sending mask...")
    # Return the image
    return PerceptionResponse(img)

# Receive a dummy image and process it
def processer_callback(req):
    print ("Processing mask...")
    # Create a 2D array using numpy
    my_array = np.array([[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]])

    # Convert the numpy array to a ROS message
    msg = Float32MultiArray()
    msg.data = my_array.flatten().tolist()
    msg.layout.dim.append(
        MultiArrayDimension(
            label="rows",
            size=my_array.shape[0],
            stride=my_array.shape[1]*my_array.itemsize
        )
    )
    msg.layout.dim.append(
        MultiArrayDimension(
            label="columns",
            size=my_array.shape[1],
            stride=my_array.itemsize
        )
    )
    time.sleep(1)
    print ("Done processing mask")
    return PatchProcessorResponse(msg)

def perception_server():
    rospy.init_node('perception_node')
    s = rospy.Service('make_predictions', Perception, perception_callback)
    s2 = rospy.Service('process_patch', PatchProcessor, processer_callback)
    rospy.spin()

if __name__ == "__main__":
    perception_server()
