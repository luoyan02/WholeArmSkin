#!/usr/bin/env python3

# import pickle
# import scipy.linalg
# import matplotlib.pyplot as plt
# import numpy as np
# from scipy.optimize import curve_fit
# import sys, getopt

# filename_shield = "0517_shield_01"
# filename_active = "0517_onlyactive_03"
# data_shield = pickle.load(open("data_collection_" + filename_shield + ".pickle", "rb"))
# data_active = pickle.load(open("data_collection_" + filename_active + ".pickle", "rb"))

# skin_shield = np.array(data_shield['skin'])
# skin_active = np.array(data_active['skin'])

# end_index = min(np.size(skin_shield), np.size(skin_active))
# # t = np.array(data['skin_time']) - data['skin_time'][0]
# # print(np.size(t))

# avg_shield = np.mean(skin_shield, axis=0)
# avg_active = np.mean(skin_active, axis=0)
# # avg_plot = np.array([avg_reading for i in range(np.size(t))])
# # print(np.size(avg_reading))
# # std_dev = np.std(skin)
# # print(std_dev)

# plt.plot(skin_active[0:end_index] - avg_active)
# plt.plot(skin_shield[0:end_index] - avg_shield)
# # plt.plot(t, avg_plot)
# # plt.fill_between(t, avg_plot - std_dev, avg_plot + std_dev, alpha=0.5)
# plt.show()

#!/usr/bin/env python3

import pickle
import scipy.linalg
import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import curve_fit
import sys, getopt

filename_shield = "0517_shield_03"
filename_active = "0517_onlyactive_05"
data_shield = pickle.load(open("data_collection_" + filename_shield + ".pickle", "rb"))
data_active = pickle.load(open("data_collection_" + filename_active + ".pickle", "rb"))

ft_shield = np.array(data_shield['ft'])
skin_shield = np.array(data_shield['skin'])
ft_active = np.array(data_active['ft'])
skin_active = np.array(data_active['skin'])

# end_index = min(np.size(skin_shield), np.size(skin_active))
# t = np.array(data['skin_time']) - data['skin_time'][0]
# print(np.size(t))

avg_shield = np.mean(skin_shield, axis=0)
avg_active = np.mean(skin_active, axis=0)
# avg_plot = np.array([avg_reading for i in range(np.size(t))])
# print(np.size(avg_reading))
# std_dev = np.std(skin)
# print(std_dev)

plt.plot(skin_active[0:end_index] - avg_active)
plt.plot(skin_shield[0:end_index] - avg_shield)
# plt.plot(t, avg_plot)
# plt.fill_between(t, avg_plot - std_dev, avg_plot + std_dev, alpha=0.5)
plt.show()