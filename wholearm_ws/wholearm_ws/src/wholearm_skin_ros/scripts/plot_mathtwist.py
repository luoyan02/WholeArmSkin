#!/usr/bin/env python3

import pickle
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import mpl_toolkits.axisartist as axisartist

fig = plt.figure(figsize=(5, 3.5))
plt.rc('font', family='serif', size='10')

ddata = pickle.load(open('data_collection_mathtwist.pickle', "rb"))
skin = np.array(ddata['skin'])
time = np.array(ddata['skin_time']) - ddata['skin_time'][0]
skin = skin/1000

b = np.polyfit(time, skin, 0)

fig = plt.figure(1)
ax = fig.add_subplot(111)
plt.hlines(y = b, xmin = 0, xmax = 21, color='#d95f02')
plt.plot(time, skin, color='#1b9e77')
plt.xlabel('Time (s)')
plt.ylabel(u'Δ Capacitance (pF)')
sns.despine()
plt.legend(['Math Model', 'Measured Capacitance'], loc = 'upper left', bbox_to_anchor=(0, 1), frameon=False)

plt.xlim([0, 21])
plt.ylim([-2, 2.2])
plt.tight_layout(pad=0)
ax.plot(21, -2, marker="4", ms=10, color="k", clip_on=False)
ax.plot((0), (1), ls="", marker="2", ms=10, color="k",
    transform=ax.get_xaxis_transform(), clip_on=False)

plt.savefig("mathtwist.pdf", dpi=600)
plt.show()
