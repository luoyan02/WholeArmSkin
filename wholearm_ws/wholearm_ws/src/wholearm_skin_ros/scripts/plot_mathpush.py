#!/usr/bin/env python3

import pickle
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import mpl_toolkits.axisartist as axisartist

fig = plt.figure(figsize=(5, 3.5))
plt.rc('font', family='serif', size='10')

ddata = pickle.load(open('data_collection_mathpush.pickle', "rb"))
skin = np.array(ddata['skin'])
time = np.array(ddata['skin_time']) - ddata['skin_time'][0]
d = time[119:201]
d = 2.272 - 0.339 * d
print(d)
d = 1/(10*d)
skin = skin[119:201]/1000
skin = skin - skin[0]

print(skin)
m , b = np.polyfit(d, skin, 1)

fig = plt.figure(1)
ax = fig.add_subplot(111)
plt.plot(d, m*d + b, color='#d95f02')
plt.plot(d, skin, color='#1b9e77')
plt.xlabel('$Distance^{-1}(mm^{-1})$')
plt.ylabel(u'Δ Capacitance (pF)')
sns.despine()
plt.legend(['Math Model', 'Measured Capacitance'], loc = 'upper left', bbox_to_anchor=(0, 1), frameon=False)

plt.xlim([0.062, 0.088])
plt.ylim([0, 2.04])
plt.tight_layout(pad=0)
ax.plot((1), (0), ls="", marker="4", ms=10, color="k",
    transform=ax.get_yaxis_transform(), clip_on=False)
# ax.plot((0), (1), ls="", marker="2", ms=10, color="k",
#     transform=ax.get_xaxis_transform(), clip_on=False)
ax.plot(0.062, 2.04, marker="2", ms=10, color="k", clip_on=False)

plt.savefig("mathpush.pdf", dpi=600)
plt.show()
