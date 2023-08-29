#!/usr/bin/env python3

import pickle
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import mpl_toolkits.axisartist as axisartist

fig = plt.figure(figsize=(5, 3.5))
plt.rc('font', family='serif', size='10')

ddata = pickle.load(open('data_collection_mathbend.pickle', "rb"))
skin = np.array(ddata['skin'])
time = np.array(ddata['skin_time']) - ddata['skin_time'][0]
d = time[173:184]
theta = 352.94 * d -986.47
skin = skin[173:184]/100
skin = skin - skin[0]
m , b = np.polyfit(theta, skin, 1)

fig = plt.figure(1)
ax = fig.add_subplot(111)

plt.plot(theta, m*theta + b, color='#d95f02')
plt.plot(theta, skin, color='#1b9e77')
plt.xlabel('Angle (deg)')
plt.ylabel(u'Δ Capacitance (pF)')
sns.despine()
plt.legend(['Math Model', 'Measured Capacitance'], loc = 'upper left', bbox_to_anchor=(0, 1), frameon=False)

plt.xlim([30, 91])
plt.ylim([0.00, 3.6])

plt.tight_layout(pad=0)
ax.plot((1), (0), ls="", marker="4", ms=10, color="k",
    transform=ax.get_yaxis_transform(), clip_on=False)
ax.plot(30, 3.6, marker="2", ms=10, color="k", clip_on=False)

plt.savefig("mathbend.pdf", dpi=600)
plt.show()
