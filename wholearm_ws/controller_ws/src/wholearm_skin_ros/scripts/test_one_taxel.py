#!/usr/bin/env python3


from cv2 import normalize
import rospy
from wholearm_skin_ros.msg import TaxelData
from geometry_msgs.msg import WrenchStamped
from std_msgs.msg import Float32
import message_filters
from collections import deque
from scipy import signal
from digitalfilter import LiveSosFilter
import pickle
import scipy.linalg
import matplotlib.pyplot as plt
import numpy as np

import threading 
# Declraing a lock
lock = threading.Lock()

class DataCollectionIndividual:
    def __init__(self, taxels = [1,2,3,4,5]) -> None:
        rospy.init_node('calibration', anonymous=True,disable_signals=True)

        if 1 in taxels:
            self.skin_sub1 = rospy.Subscriber("/skin/taxel_1_fast", TaxelData, self.callback1)
            self.pub1 = rospy.Publisher("/calibration1", Float32, queue_size=10)
            self.model1 = pickle.load(open("/home/emprise/wholearm_ws/src/wholearm_skin_ros/taxel1_calibration_fitted_model_conductivearm_1.pickle", "rb"))
            self.taring1 = False
            self.skin_history1 = deque(maxlen=100)
            self.tare_value1 = 0
            self.last_value1 = 0

            sos1 = signal.iirfilter(2, Wn=1.5, fs=60, btype="lowpass",
                             ftype="butter", output="sos")                
            self.live_sosfilter1 = LiveSosFilter(sos1)

        elif 2 in taxels:
            self.skin_sub2 = rospy.Subscriber("/skin/taxel_2_fast", TaxelData, self.callback2)
            self.pub2 = rospy.Publisher("/calibration2", Float32, queue_size=10)
            self.model2 = pickle.load(open("/home/emprise/wholearm_ws/src/wholearm_skin_ros/taxel2_calibration_fitted_model_conductivearm_2.pickle", "rb"))
            self.taring2 = False
            self.skin_history2 = deque(maxlen=100)
            self.tare_value2 = 0
            self.last_value2 = 0
            sos2 = signal.iirfilter(2, Wn=1.5, fs=60, btype="lowpass",
                             ftype="butter", output="sos")                
            self.live_sosfilter2 = LiveSosFilter(sos2)

        elif 3 in taxels:
            self.skin_sub3 = rospy.Subscribeinfr("/skin/taxel_3_fast", TaxelData, self.callback3)
            self.pub3 = rospy.Publisher("/calibration3", Float32, queue_size=10)
            self.model3 = pickle.load(open("/home/emprise/wholearm_ws/src/wholearm_skin_ros/taxel3_calibration_fitted_model_conductivearm_1.pickle", "rb"))
            self.taring3 = False
            self.skin_history3 = deque(maxlen=100)
            self.tare_value3 = 0
            self.last_value3 = 0
            sos3 = signal.iirfilter(2, Wn=1.5, fs=60, btype="lowpass",
                             ftype="butter", output="sos")                
            self.live_sosfilter3 = LiveSosFilter(sos3)

        elif 4 in taxels:
            self.skin_sub4 = rospy.Subscribeinfr("/skin/taxel_4_fast", TaxelData, self.callback4)
            self.pub4 = rospy.Publisher("/calibration4", Float32, queue_size=10)
            self.model4 = pickle.load(open("/home/emprise/wholearm_ws/src/wholearm_skin_ros/taxel4_calibration_fitted_model_conductivearm_1.pickle", "rb"))
            self.taring4 = False
            self.skin_history4 = deque(maxlen=100)
            self.tare_value4 = 0
            self.last_value4 = 0
            sos4 = signal.iirfilter(2, Wn=1.5, fs=60, btype="lowpass",
                             ftype="butter", output="sos")                
            self.live_sosfilter4 = LiveSosFilter(sos4)
        elif 5 in taxels:
            self.skin_sub5 = rospy.Subscribeinfr("/skin/taxel_5_fast", TaxelData, self.callback5)
            self.pub5 = rospy.Publisher("/calibration5", Float32, queue_size=10)
            self.model5 = pickle.load(open("/home/emprise/wholearm_ws/src/wholearm_skin_ros/taxel5_calibration_fitted_model_conductivearm_1.pickle", "rb"))
            self.taring5 = False
            self.skin_history5 = deque(maxlen=100)
            self.tare_value5 = 0
            self.last_value5 = 0
            sos5 = signal.iirfilter(2, Wn=1.5, fs=60, btype="lowpass",
                             ftype="butter", output="sos")                
            self.live_sosfilter5 = LiveSosFilter(sos5)

    def callback1(self, skin_msg):
        if len(self.skin_history1) == self.skin_history1.maxlen and not self.taring1:
            self.taring1 = True
            self.tare_value1 = int(sum(self.skin_history1)/len(self.skin_history1))

        if not self.taring1:
            self.skin_history1.append(skin_msg.cdc)
        else:
            # self.buffer1[self.i1] = skin_msg.cdc - self.tare_value1 # m
            skin_data = self.filter(skin_msg.cdc - self.tare_value1, self.live_sosfilter1)
            # self.i1 = (self.i1 + 1) % 11 #m
            msg = Float32()

            # # remove -2 value
            if skin_msg.cdc  < 0: # timed out
                skin_data = self.last_value1
            else:
                self.last_value1 = skin_data

            msg.data = skin_data * self.model1['m'] + self.model1['c']
            # msg.data = self.log_func(skin_data)
            self.pub1.publish(msg)

    def callback2(self, skin_msg):
        # if len(self.skin_history2) == self.skin_history2.maxlen and not self.taring2:
        #     self.taring2 = True
        #     # self.tare_value2 = int(sum(self.skin_history2)/len(self.skin_history2))
        #     self.tare_value2 = max(abs(self.skin_history2))

        # if not self.taring2:
        #     self.skin_history2.append(skin_msg.cdc)
        # else:
        #     # self.buffer2[self.i2] = skin_msg.cdc - self.tare_value2
        #     skin_data = self.filter(skin_msg.cdc - self.tare_value2, self.live_sosfilter2)
        #     # self.i2 = (self.i2 + 1) % 11
        #     msg = Float32()
        #     # # remove -2 value
        #     if skin_msg.cdc < 0: # timed out
        #         skin_data = self.last_value2
        #     else:
        #         self.last_value2 = skin_data
        #     # print(self.model2['m'])
        #     msg.data = skin_data * self.model2['m'] + self.model2['c']
        #     print(msg.data)
        #     # msg.data = self.log_func(skin_data)
        #     self.pub2.publish(msg)

        if len(self.skin_history2) == self.skin_history2.maxlen and not self.taring2:
            self.taring2 = True
            self.tare_value2 = int(sum(self.skin_history2)/len(self.skin_history2))
            # self.tare_value2 = max(abs(self.skin_history2))

        if not self.taring2:
            self.skin_history2.append(skin_msg.cdc)
        else:
            # self.buffer2[self.i2] = skin_msg.cdc - self.tare_value2
            skin_data = self.filter(skin_msg.cdc - self.tare_value2, self.live_sosfilter2)
            # self.i2 = (self.i2 + 1) % 11
            msg = Float32()
            # # remove -2 value
            if skin_msg.cdc < 0: # timed out
                skin_data = self.last_value2
            else:
                self.last_value2 = skin_data
            # print(self.model2['m'])
            after_calibration = skin_data * self.model2['m'] + self.model2['c']
            normalized_calib=after_calibration - 0.3
            normalized_calib*=10
            msg.data = normalized_calib
            # msg.data = skin_data * self.model2['m'] + self.model2['c']
            print(msg.data)
            print(skin_msg.cdc)
            # msg.data = self.log_func(skin_data)
            self.pub2.publish(msg)


    def callback3(self, skin_msg):
        if len(self.skin_history3) == self.skin_history3.maxlen and not self.taring3:
            self.taring3 = True
            self.tare_value3 = int(sum(self.skin_history3)/len(self.skin_history3))

        if not self.taring3:
            self.skin_history3.append(skin_msg.cdc)
        else:
            # self.buffer3[self.i3] = skin_msg.cdc - self.tare_value3
            skin_data = self.filter(skin_msg.cdc - self.tare_value3, self.live_sosfilter3)
            # self.i3 = (self.i3 + 1) % 11
            msg = Float32()
            # # remove -2 value
            if skin_msg.cdc < 0: # timed out
                skin_data = self.last_value3
            else:
                self.last_value3 = skin_data
            msg.data = skin_data * self.model3['m'] + self.model3['c']
            # msg.data = self.log_func(skin_data)
            self.pub3.publish(msg)
            print(msg.data)

    def callback4(self, skin_msg):
        if len(self.skin_history4) == self.skin_history4.maxlen and not self.taring4:
            self.taring4 = True
            self.tare_value4 = int(sum(self.skin_history4)/len(self.skin_history4))

        if not self.taring4:
            
            self.skin_history4.append(skin_msg.cdc)
        else:
            # self.buffer4[self.i4] = skin_msg.cdc - self.tare_value4
            skin_data = self.filter(skin_msg.cdc - self.tare_value4, self.live_sosfilter4)
            # self.i4 = (self.i4 + 1) % 11
            msg = Float32()
            # # remove -2 value
            if skin_msg.cdc < 0 : # timed out
                skin_data = self.last_value4
            else:
                self.last_value4 = skin_data
            msg.data = skin_data * self.model4['m'] + self.model4['c']
            # msg.data = self.log_func(skin_data)
            self.pub4.publish(msg)

    def callback5(self, skin_msg):
        if len(self.skin_history5) == self.skin_history5.maxlen and not self.taring5:
            self.taring5 = True
            self.tare_value5 = int(sum(self.skin_history5)/len(self.skin_history5))

        if not self.taring5:
            
            self.skin_history5.append(skin_msg.cdc)
        else:
            # self.buffer5[self.i5] = skin_msg.cdc - self.tare_value5
            skin_data = self.filter(skin_msg.cdc - self.tare_value5, self.live_sosfilter5)
            # self.i5 = (self.i5 + 1) % 11
            msg = Float32()
            # # remove -2 value
            if skin_msg.cdc < 0: # timed out
                skin_data = self.last_value5
            else:
                self.last_value5 = skin_data
            msg.data = skin_data * self.model5['m'] + self.model5['c']
            # msg.data = self.log_func(skin_data)
            self.pub5.publish(msg)

    def log_func(self, x):
        return self.model['a'] * np.log(self.model['b'] * abs(x)) + self.model['c']

    def filter(self, skin_data, filter_fn):
        # skin_data = np.median(buffer) # m
        # return skin_data
        return filter_fn(skin_data)
   

    def calibrate(self):
        pass

    def filter_taxel_2(self, num_sample):
        pass
    
if __name__ == "__main__":
    data_collector = DataCollectionIndividual(taxels = [2])
    lock.acquire()
    # try:
    rospy.loginfo("Starting calibration data collection")
    rospy.spin()
