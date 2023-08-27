#!/usr/bin/env python3

import rospy
from wholearm_skin_ros.msg import TaxelData
from geometry_msgs.msg import WrenchStamped
from std_msgs.msg import Float32MultiArray, MultiArrayDimension, MultiArrayLayout
import message_filters
from collections import deque
from scipy import signal
from digitalfilter import LiveSosFilter
import pickle
import scipy.linalg
import matplotlib.pyplot as plt
import numpy as np
from numpy_ringbuffer import RingBuffer

import threading 
# Declraing a lock
lock = threading.Lock()

num_taxels = 7 # edit this to match 

# TODO: Subscribe to skin and FT data [DONE]
# TODO: Sync skin and FT data [DONE]
# TODO: Filter skin data [DONE]
# TODO: Store pickled data [DONE]
# TODO: Fit calibration function


class DataCollection:
    def __init__(self) -> None:
        rospy.init_node('calibration', anonymous=True,disable_signals=True)
        self.skin_sub = rospy.Subscriber("/skin/taxel_fast", TaxelData, self.callback)
        self.pub = rospy.Publisher("/calibration", Float32MultiArray, queue_size=10)
        self.model_t0 = pickle.load(open("/home/emprise/wholearm_ws/fitted_poly3_model_l6t5.pickle", "rb"))
        self.model_t1 = pickle.load(open("/home/emprise/wholearm_ws/fitted_poly3_model_l6t5.pickle", "rb"))
        self.model_t2 = pickle.load(open("/home/emprise/wholearm_ws/fitted_poly3_model_l6t5.pickle", "rb"))
        self.model_t3 = pickle.load(open("/home/emprise/wholearm_ws/fitted_poly3_model_l6t5.pickle", "rb"))
        self.model_t4 = pickle.load(open("/home/emprise/wholearm_ws/fitted_poly3_model_l6t5.pickle", "rb"))
        self.model_t5 = pickle.load(open("/home/emprise/wholearm_ws/fitted_poly3_model_l6t5.pickle", "rb"))
        self.model_t6 = pickle.load(open("/home/emprise/wholearm_ws/fitted_poly3_model_l6t5.pickle", "rb"))

        # combine calibration models into one dictionary 
        for i in range(num_taxels):
            self.model = {}

        # Taring variables
        # TODO: max length should be a parameter
        self.taring = False
        # ring buffer with capacity 100, extra dimesions (num_taxels) for list of taxel readings
        self.skin_history = RingBuffer(capacity=100, dtype=(float, (num_taxels)))
        self.tare_value = [ 0 ] * num_taxels
        self.last_value = [ 0 ] * num_taxels

        # Filter variables
        # TODO: Change filter parameters
        sos = signal.iirfilter(2, Wn=1.5, fs=60, btype="lowpass", ftype="butter", output="sos")              
        self.live_sosfilter = [ LiveSosFilter(sos), LiveSosFilter(sos), LiveSosFilter(sos), LiveSosFilter(sos), \
                                LiveSosFilter(sos), LiveSosFilter(sos), LiveSosFilter(sos), LiveSosFilter(sos) ]

    def callback(self, skin_msg):
        if self.skin_history.is_full and not self.taring:
            self.taring = True
            for i in range(num_taxels):
                self.tare_value[i] = int(sum(self.skin_history[:, i]))/len(self.skin_history[:, i])

        if not self.taring:
            # print(np.shape(np.array(skin_msg.cdc)))
            # print(np.array(skin_msg.cdc).reshape(1,2))
            print("Taring...")
            self.skin_history.extend(np.array(skin_msg.cdc).reshape(1,num_taxels))
            # print(np.shape(self.skin_history))
        else:
            skin_data = np.zeros(num_taxels)
            # print("///////////////")
            for i in range(num_taxels):
                # print(i)
                # print(skin_msg.cdc[i])
                # print("skin data size: ")
                # print(len(skin_data[i]))
                filtered = self.filter(skin_msg.cdc[i] - self.tare_value[i], self.live_sosfilter[i])
                # print(filtered)
                # print(len(filtered))
                skin_data[i] = filtered
                # skin_data[i] = self.filter(skin_msg.cdc[i] - self.tare_value[i], self.live_sosfilter)
            # print(skin_data)
            
            msg = Float32MultiArray()
            msg.data = [0] * num_taxels

            self.last_value = skin_data

            # fit data to calibration model 
            for i in range(num_taxels):
                # msg.data[i] = skin_data[i] * self.model['m'] + self.model['c']
                msg.data[i] = self.model['a3'] + self.model['a2']*skin_data[i] + self.model['a1']*skin_data[i]**2 + self.model['a0']*skin_data[i]**3
                # msg.data[i] = skin_data[i]
            # msg.data = skin_data * self.model['m'] + self.model['c']
            # msg.layout = MultiArrayLayout()
            # msg.layout.dim = (MultiArrayDimension())
            # msg.layout.dim.push_back(MultiArrayDimension())
            # msg.layout.dim.size = num_taxels
            # msg.layout.dim.stride = 1
            # msg.layout.data_offset = 0
            self.pub.publish(msg)
            print(msg.data)

    def filter(self, skin_data, filter_fn):
        return filter_fn(skin_data)

if __name__ == "__main__":
    data_collector = DataCollection()
    lock.acquire()
    # try:
    rospy.loginfo("Starting inference data collection")
    rospy.spin()
    # finally:
        # data_collector.save_data()





