#!/usr/bin/env python3

import rospy
from wholearm_skin_ros.msg import TaxelData
from geometry_msgs.msg import WrenchStamped
from std_msgs.msg import Float32
import message_filters
from collections import deque
from scipy import signal
from digitalfilter import LiveSosFilter
import pickle

from dynamic_reconfigure.server import Server
from wholearm_skin_ros.cfg import FilterConfig

import threading 
# Declraing a lock
lock = threading.Lock()



class DataCollection:
    def __init__(self) -> None:
        rospy.init_node('calibration', anonymous=True,disable_signals=True)
        self.ft_sub = message_filters.Subscriber("/forque/forqueSensor", WrenchStamped)
        self.skin_sub = message_filters.Subscriber("/skin/taxel_1_fast", TaxelData)
        self.sync_sub = message_filters.ApproximateTimeSynchronizer([self.ft_sub, self.skin_sub],
                                                               queue_size=10, slop=0.1)
        self.pub = rospy.Publisher("/calibration", Float32, queue_size=10)
        self.sync_sub.registerCallback(self.sync_callback)
        self.calibration_data = {'ft': [], 'skin': [], 'ft_time': [], 'skin_time': []}

        self.skin_history = deque(maxlen=1000)
        self.tare_value = 0
        self.taring = False

        # Filter variables
        # TODO: Change filter parameters
        sos = signal.iirfilter(5, Wn=1.5, fs=60, btype="lowpass",
                             ftype="butter", output="sos")
        self.live_sosfilter = LiveSosFilter(sos)

        # add magnitude filter

    def config_callback(self, config, level):
        sos = signal.iirfilter(config['order'], Wn=config['wn'], fs=config['fs'], btype="lowpass",
                             ftype="butter", output="sos")
        self.live_sosfilter = LiveSosFilter(sos)
        return config
        
    def sync_callback(self, ft_msg, skin_msg):
        if len(self.skin_history) == self.skin_history.maxlen and not self.taring:
            self.taring = True
            self.tare_value = int(sum(self.skin_history)/len(self.skin_history))

        if not self.taring:
            self.skin_history.append(skin_msg.cdc)
        else:
            skin_data = self.filter(skin_msg.cdc - self.tare_value)
            # skin_data = skin_msg.cdc - self.tare_value
            msg = Float32()
            msg.data = skin_data
            self.pub.publish(msg)
            print("FT: ", ft_msg.wrench.force.z, " Skin: ", skin_data, "Time diff: ", ft_msg.header.stamp - skin_msg.header.stamp)
            self.store_data(ft_msg.wrench.force.z, skin_data, skin_msg.header.stamp.to_sec(), ft_msg.header.stamp.to_sec())

    def filter(self, skin_data):
        return self.live_sosfilter(skin_data)

    def calibrate(self):
        pass

    def store_data(self, ft_data, skin_data, ft_time, skin_time):
        self.calibration_data['ft'].append(ft_data)
        self.calibration_data['skin'].append(skin_data)
        self.calibration_data['ft_time'].append(ft_time)
        self.calibration_data['skin_time'].append(skin_time)

    def save_data(self):
        rospy.loginfo('Saving calibration data')
        with open('filtering_data.pickle', 'wb') as handle:
            pickle.dump(self.calibration_data, handle, protocol=pickle.HIGHEST_PROTOCOL)

if __name__ == "__main__":
    data_collector = DataCollection()
    lock.acquire()
    try:
        rospy.loginfo("Starting calibration data collection")
        srv = Server(FilterConfig, data_collector.config_callback)
        rospy.spin()
    finally:
        data_collector.save_data()
