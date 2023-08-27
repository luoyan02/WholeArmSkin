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

num_taxels = 8 # edit this to match 

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
        # self.model = pickle.load(open("/home/emprise/wholearm_ws/fitted_model.pickle", "rb"))
        self.model = pickle.load(open("/home/emprise/wholearm_ws/fitted_poly3_model_0427_06.pickle", "rb"))

        # Taring variables
        # TODO: max length should be a parameter
        self.taring = False
        # ring buffer with capacity 100, extra dimesions (num_taxels) for list of taxel readings
        self.skin_history = RingBuffer(capacity=100, dtype=(float, (num_taxels)))
        # ring buffer with capacity 1000, extra dimesions (num_taxels) for list of taxel readings
        self.running_history = RingBuffer(capacity=1000, dtype=(float, (num_taxels)))
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

            # self.last_value = skin_data

            # fit data to calibration model 
            for i in range(num_taxels):
                # msg.data[i] = skin_data[i] * self.model['m'] + self.model['c']
                msg.data[i] = self.model['a3'] + self.model['a2']*skin_data[i] + self.model['a1']*skin_data[i]**2 + self.model['a0']*skin_data[i]**3
                if (msg.data[i] > 0):
                    msg.data[i] = 0
                # if i == 1:
                #     msg.data[i] = msg.data[i]/20
                # elif i == 0 or i == 2 or i == 3:
                #     msg.data[i] = msg.data[i]/2
                # if (msg.data[i] < -50):
                #     msg.data[i] = self.last_value[i]
                # msg.data[i] = skin_data[i]/100

                # live retaring 
                if self.running_history.is_full:
                    average_val = int(sum(self.running_history[:, i]))/len(self.running_history[:, i])
                    if abs(skin_data[i] - average_val) > 50:
                        self.tare_value[i] = average_val
                
                
            self.running_history.extend(np.array(skin_msg.cdc).reshape(1,num_taxels))
                
            self.last_value = msg.data

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





