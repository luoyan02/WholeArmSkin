#!/usr/bin/env python3

import pickle
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import mpl_toolkits.axisartist as axisartist

fig = plt.figure(figsize=(5, 3.5))
ax = axisartist.Subplot(fig, 111)
fig.add_axes(ax)
plt.rc('font', family='serif', size='10') 


ddata = pickle.load(open('data_collection_mathstretch.pickle', "rb"))
skin = np.array(ddata['skin'])
time = np.array(ddata['skin_time']) - ddata['skin_time'][0]
d = time[93:116]
skin = skin[93:116]/1000
m , b = np.polyfit(d, skin, 1)


plt.plot(d, m*d + b, color='#d95f02')
plt.plot(d, skin, color='#1b9e77')
plt.xlabel('Distance (mm)')
plt.ylabel(u'Δ Capacitance (pF)')
# plt.tight_layout(pad=0)
sns.despine()
plt.legend(['Math Model', 'Estimated Forces'], loc = 'upper left', bbox_to_anchor=(0, 1), frameon=False)

plt.xlim([1.55, 1.95])
plt.ylim([1.5, 5.0])
plt.tight_layout(pad=0)
ax.axis["bottom"].set_axis_direction("bottom")
ax.axis["left"].set_axis_direction("left")
ax.axis["top"].set_visible(False)
ax.axis["right"].set_visible(False)
ax.axis["bottom"].set_axisline_style("->", size=1.0)
ax.axis["left"].set_axisline_style("->", size=1.0)

plt.savefig("mathstretch.pdf", dpi=600)
plt.show()
