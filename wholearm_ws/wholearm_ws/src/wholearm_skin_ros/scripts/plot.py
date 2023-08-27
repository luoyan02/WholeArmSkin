#!/usr/bin/env python3

import pickle
import scipy.linalg
import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import curve_fit
import sys, getopt

# take in names of each file 
# arguments = sys.argv[1:]
# short_options = "c:s:f:g:"
# long_options = ["touch_type="]

# options, values = getopt.getopt(arguments, short_options, long_options)

# touch_type = ""
# for o, v in options:
#     if o in ("-t", "--touch_type"):
#         touch_type = "".join(str(v).split())

data_cc = pickle.load(open("inference_data_cc.pickle", "rb")) # conductive - clothed
data_cs = pickle.load(open("inference_data_cs.pickle", "rb")) # conductive - skin 
data_nc1 = pickle.load(open("inference_data_nc1.pickle", "rb")) # nonconductive - object 1
data_nc2 = pickle.load(open("inference_data_nc2.pickle", "rb")) # nonconductive - object 2
model = pickle.load(open("/home/emprise/wholearm_ws/fitted_model.pickle", "rb"))

m = model['m']
c = model['c']

x_cc = np.array(data_cc['skin'])
t0_cc = data_cc['skin_time'][0]

x_cs = np.array(data_cs['skin'])
t0_cs = data_cs['skin_time'][0]

x_nc1 = np.array(data_nc1['skin'])
t0_nc1 = data_nc1['skin_time'][0]

x_nc2 = np.array(data_nc2['skin'])
t0_nc2 = data_nc2['skin_time'][0]

# TODO: change to have 4 subplots for each of the touches
# TODO: fill between lines if press of conductive touch is greater than min of nonconductive light touch 

fig, (ax_cc, ax_cs, ax_nc1, ax_nc2,) = plt.subplots(1, 4, sharey=True)

ax_cc.plot(abs(np.array(data_cc['skin_time'])-t0_cc), x_cc*m+c, 'c', label='Skin data')
ax_cc.set_xlabel('Time (s)')
ax_cc.set_ylabel('Force Readings from Robot Skin (N)')
ax_cc.set_title('Conductive Touch - Cloth')
ax_cc.legend()

ax_cs.plot(abs(np.array(data_cc['skin_time'])-t0_cs), x_cs*m+c, 'c', label='Skin data')
ax_cs.set_xlabel('Time (s)')
ax_cs.set_ylabel('Force Readings from Robot Skin (N)')
ax_cs.set_title('Conductive Touch - Skin')
ax_cs.legend()

ax_nc1.plot(abs(np.array(data_cc['skin_time'])-t0_nc1), x_nc1*m+c, 'c', label='Skin data')
ax_nc1.set_xlabel('Time (s)')
ax_nc1.set_ylabel('Force Readings from Robot Skin (N)')
ax_nc1.set_title('Nonconductive Touch - Object 1')
ax_nc1.legend()

ax_nc2.plot(abs(np.array(data_cc['skin_time'])-t0_nc2), x_nc2*m+c, 'c', label='Skin data')
ax_nc2.set_xlabel('Time (s)')
ax_nc2.set_ylabel('Force Readings from Robot Skin (N)')
ax_nc2.set_title('Nonconductive Touch - Object 2')
ax_nc2.legend()

textstr = "\nm = "+str(m)+"\nc = "+str(c)
fig.set_title("Force vs. Time"+textstr)
plt.show()