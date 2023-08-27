import pickle
import scipy.linalg
import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import curve_fit

data = pickle.load(open("calibration_data.pickle", "rb"))

x = np.array(data['skin'])
y = np.array(data['ft'])
print (x.shape, y.shape)

def linear_regression(x, y):
    A = scipy.vstack([x, scipy.ones(len(x))]).T
    m, c = scipy.linalg.lstsq(A, y)[0]
    return m, c

def log_func(x, a, b, c):
    return a * np.log(b * abs(x)) + c

def log_linear_regression(x, y):
    coeff, _ = curve_fit(log_func, x, y)
    print (coeff)
    return coeff

def sigmoid(x, L ,x0, k, b):
    y = L / (1 + np.exp(-k*(x-x0))) + b
    return (y)

# m, c = linear_regression(x, y)
# model = {'m': m, 'c': c}
# with open('fitted_model.pickle', 'wb') as handle:
#     pickle.dump(model, handle, protocol=pickle.HIGHEST_PROTOCOL)

# a, b, c = log_linear_regression(x, y)
# model = {'a': a, 'b': b, 'c': c}
# with open('fitted_log_model.pickle', 'wb') as handle:
#     pickle.dump(model, handle, protocol=pickle.HIGHEST_PROTOCOL)

p0 = [max(y), np.median(x),1,min(y)] # this is an mandatory initial guess
popt, pcov = curve_fit(sigmoid, x, y, p0, method='dogbox')
L, x0, k, b = popt
# Plot the data
_ = plt.plot(x, y, 'o', label='Original data', markersize=2)

_ = plt.plot(sigmoid(x, L ,x0, k, b), 'r', label='Fitted line')

_ = plt.legend()

plt.show()