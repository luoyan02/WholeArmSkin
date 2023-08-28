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


ddata = pickle.load(open('data_collection_mathtwist.pickle', "rb"))
skin = np.array(ddata['skin'])
time = np.array(ddata['skin_time']) - ddata['skin_time'][0]
# d = time[119:201]
# print(d)
# d = 2.272 - 0.339 * d
# d = 10/d
skin = skin/1000
# skin = skin[119:201]/1000
# m , b = np.polyfit(d, skin, 1)


# plt.plot(d, m*d + b, color='#d95f02')
plt.plot(time, skin, color='#1b9e77')
plt.xlabel('Distance (mm)')
plt.ylabel(u'Δ Capacitance (pF)')
# plt.tight_layout(pad=0)
sns.despine()
plt.legend(['Math Model'], loc = 'upper left', bbox_to_anchor=(0, 1), frameon=False)

# plt.xlim([6, 9])
plt.ylim([0, 3])
plt.tight_layout(pad=0)
ax.axis["bottom"].set_axis_direction("bottom")
ax.axis["left"].set_axis_direction("left")
ax.axis["top"].set_visible(False)
ax.axis["right"].set_visible(False)
ax.axis["bottom"].set_axisline_style("->", size=1.0)
ax.axis["left"].set_axisline_style("->", size=1.0)

plt.savefig("mathpush.pdf", dpi=600)
plt.show()
