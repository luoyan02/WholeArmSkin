#!/usr/bin/env python3

import pickle
import scipy.linalg
import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import curve_fit

# filename = "0427_06"
filename = "0517_noshield_02"

data = pickle.load(open("data_collection_" + filename + ".pickle", "rb"))

prev_val = 0
skin = np.array(data['skin'])
ft = np.array(data['ft'])

# for i in range(1,len(x)):
#     if (abs(x[i] - x[i-1]) > 100):
#         x[i] = x[i-1]

maxlen = len(data['skin'])
halflen = int(maxlen/2)

# print (x.shape, y.shape)

def linear_regression(x, y):
    A = scipy.vstack([x, scipy.ones(len(x))]).T
    m, c = scipy.linalg.lstsq(A, y)[0]
    print("linear_regression")
    print(m)
    return m, c

def log_func(x, a, b, k):
    return a * np.log(b * abs(x)) + k

def log_linear_regression(x, y):
    coeff, _ = curve_fit(log_func, x, y)
    print (coeff)
    return coeff

def poly3_regression(x, y):
    coeff = np.polyfit(x, y, 3)
    print (coeff)
    return coeff

def poly5_regression(x, y):
    coeff = np.polyfit(x, y, 5)
    print (coeff)
    return coeff

m, c = linear_regression(ft, skin)
model_l = {'m': m, 'c': c}
with open("fitted_model_" + filename + ".pickle", 'wb') as handle:
    pickle.dump(model_l, handle, protocol=pickle.HIGHEST_PROTOCOL)

# a, b, k = log_linear_regression(x, y)
# model_ll = {'a': a, 'b': b, 'k': k}
# with open('fitted_log_model_l6t5.pickle', 'wb') as handle:
#     pickle.dump(model_ll, handle, protocol=pickle.HIGHEST_PROTOCOL)

a0, a1, a2, a3 = poly3_regression(ft, skin)
model_p3 = {'a0': a0, 'a1': a1, 'a2': a2, 'a3': a3}
with open("fitted_poly3_model_" + filename + ".pickle", 'wb') as handle:
    pickle.dump(model_p3, handle, protocol=pickle.HIGHEST_PROTOCOL)

c0, c1, c2, c3, c4, c5 = poly5_regression(ft, skin)
model_p5 = {'c0': c0, 'c1': c1, 'c2': c2, 'c3': c3, 'c4': c4, 'c5': c5}
with open("fitted_poly5_model_" + filename + ".pickle", 'wb') as handle:
    pickle.dump(model_p5, handle, protocol=pickle.HIGHEST_PROTOCOL)


# Plot the data
# _ = plt.plot(x, y, 'o', label='Original data', markersize=2)
# _= plt.plot(np.array(data['skin_time']), x, 'o', label='Skin data')
# _= plt.plot(np.array(data['skin_time']), y, 'r', label='Forque data')


# _ = plt.plot(x, x * m + c, 'r', label='Fitted line')
# _ = plt.plot(log_func(x, a, b, c), 'r', label='Fitted line')

# _ = plt.legend()

# fig, (ax2, ax3, ax4, ax5) = plt.subplots(4)
# # ax1.plot(x, y, 'o', label='Original data', markersize=2)
# # ax1.plot(x, x * m + c, 'r', label='Fitted line')
# # ax1.set_title('Forque vs. Skin data')


# ax2.plot(np.array(data['skin_time'][0:halflen]), x[0:halflen], 'c', label='Skin data')
# # ax2.plot(np.array(data['skin_time']), y, 'r', label='Forque data')
# ax2.set_title('Skin vs. Time')

# ax3.set_title("Log. Magnitude Spectrum of Skin Data")
# ax3.magnitude_spectrum(x[0:halflen], Fs=60, scale='dB')


# ax4.plot(np.array(data['skin_time'][halflen:maxlen]), x[halflen:maxlen], 'c', label='Skin data')
# # ax2.plot(np.array(data['skin_time']), y, 'r', label='Forque data')
# ax4.set_title('Skin vs. Time')

# ax5.set_title("Log. Magnitude Spectrum of Skin Data")
# ax5.magnitude_spectrum(x[halflen:maxlen], Fs=60, scale='dB')

print("plotted m")
print(m)

# fig, (ax1, ax2, ax3,) = plt.subplots(3)
fig, (ax1, ax2,) = plt.subplots(2)
ax1.plot(ft, skin, 'o' 'c', label='Original data', markersize=2)
#ax1.plot(ft, ft * m + c, 'r', label='Fitted line - linear')
# ax1.plot(ft, log_func(ft, a, b, k), 'b--', dashes=(5, 10), label='Fitted line - log linear')
#ax1.plot(ft, a3 + a2*ft + a1*ft**2 + a0*ft**3, 'g', label='Fitted line - poly3')
#ax1.plot(ft, c5 + c4*ft + c3*ft**2 + c2*ft**3 + c1*ft**4 + c0*ft**5, 'm',  label='Fitted line - poly5')
ax1.set_xlabel('Forque readings')
ax1.set_ylabel('Skin readings')
ax1.set_title('Forque vs. Skin data')
ax1.legend()

ratio = (max(skin)-min(skin))/(min(ft)-max(ft))

ax2.plot(np.array(data['skin_time']), skin, 'c', label='Skin data')
ax2.plot(np.array(data['skin_time']), ft*ratio, 'r', label='Forque data (scaled by %f)' %ratio)
# ax2.plot(np.array(data['skin_time']), ft, 'r', label='Forque data')
ax2.set_xlabel('Time')
ax2.set_ylabel('Skin readings')
ax2.set_title('Skin vs. Time')
ax2.legend()

# ax3.set_title("Log. Magnitude Spectrum of Skin Data")
# ax3.magnitude_spectrum(x, Fs=60, scale='dB', color='c')

plt.show()

# plt.plot(x)
# plt.show()
