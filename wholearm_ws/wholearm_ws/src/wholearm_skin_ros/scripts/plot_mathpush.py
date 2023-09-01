#!/usr/bin/env python3

import pickle
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import mpl_toolkits.axisartist as axisartist

fig = plt.figure(figsize=(10, 3.5))
plt.rc('font', family='serif', size='10')

ddata = pickle.load(open('data_collection_mathpush.pickle', "rb"))
skin = np.array(ddata['skin'])
time = np.array(ddata['skin_time']) - ddata['skin_time'][0]
d = time[119:201]
# d = time[0:300]
d = 2.367 - 0.41 * d
print(d)
# d = 1/(10*d)
skin = skin + 3000
skin = skin[119:201]/1000
print(skin)

m , b = np.polyfit(1/d, skin, 1)

fig = plt.figure(1)
ax = fig.add_subplot(111)
plt.plot(d, m*(1/d) + b, color='#d95f02')
plt.plot(d, skin, color='#1b9e77')
plt.xlabel(u'Distance (cm)')
plt.ylabel(u'Capacitance (pF)')
sns.despine()
plt.legend(['Math Model', 'Measured Capacitance'], loc = 'upper right', bbox_to_anchor=(1, 1), frameon=False)

plt.xlim([0.97, 1.57])
plt.ylim([3.75, 5.78])
plt.tight_layout(pad=0)
ax.xaxis.set_major_locator(plt.NullLocator())
ax.yaxis.set_major_locator(plt.NullLocator())

ax.plot(1.57, 3.75, marker="4", ms=10, color="k", clip_on=False)
ax.plot(0.97, 5.78, marker="2", ms=10, color="k", clip_on=False)

desired_ticks = [1.00, 1.55]
ax.set_xticks(desired_ticks)

ax.plot([1.00, 1.00], [3.75, 5.618], ls="--", linewidth = 2, color='#1b9e77')
ax.plot([0.97, 1.00], [5.618, 5.618], ls="--", linewidth = 2, color='#1b9e77')
ax.plot(1.00, 5.618, ls="", marker='o', ms=5, color='#1b9e77')
ax.plot([1.55, 1.55], [3.75, 3.850], ls="--", linewidth = 2, color='#1b9e77')
ax.plot([0.97, 1.55], [3.850, 3.850], ls="--", linewidth = 2, color='#1b9e77')
ax.plot(1.55, 3.850, ls="", marker='o', ms=5, color='#1b9e77')
desired_ticks = [3.850, 5.618]
ax.set_yticks(desired_ticks)

ax.arrow(1.57, 3.75, 10, 0, head_width=0.15, head_length=0.1, fc='#1b9e77', ec='#1b9e77')

plt.savefig("mathpush.pdf", dpi=600)
plt.show()
