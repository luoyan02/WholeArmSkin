#!/usr/bin/env python3

import pickle
import scipy.linalg
import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import curve_fit

plt.rc('font', family='serif') 

data = pickle.load(open("calibration_data_l6t3_0217.pickle", "rb"))

x = np.array(data['skin'])
y = np.array(data['ft'])
t = np.array(data['skin_time']) - data['skin_time'][0]

for i in range(1,len(x)):
    if (abs(x[i] - x[i-1]) > 25):
        x[i] = x[i-1]

fig, ax1 = plt.subplots()

ax2 = ax1.twinx()
ax1.plot(t, x/1000, 'crimson', label='Capacitive Skin')
ax2.plot(t, -y, 'gray', label='Forque Sensor')
plt.title('Capacitance and Force Measurements vs. Time')
ax2.set_xlabel('Time (s)')
ax1.set_ylabel('Capacitance (pF)')
ax2.set_ylabel('Force (N)')
fig.legend(loc='upper left', bbox_to_anchor=(0, 1), bbox_transform=ax2.transAxes)
plt.xticks(np.arange(min(t), max(t)+10, 10.0))
plt.show()