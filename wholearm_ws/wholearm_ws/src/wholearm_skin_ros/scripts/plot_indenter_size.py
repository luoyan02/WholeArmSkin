#!/usr/bin/env python3

import pickle
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

plt.figure(figsize=(5.0, 3.5))
plt.rc('font', family='serif', size='10') 

dfull = pickle.load(open('data_collection_indenter_full.pickle', "rb"))
d3x3 = pickle.load(open('data_collection_indenter_3x3.pickle', "rb"))
d2x2 = pickle.load(open('data_collection_indenter_2x2.pickle', "rb"))
d1x1 = pickle.load(open('data_collection_indenter_1x1.pickle', "rb"))

ifull = np.array(dfull['skin'])/1000
ifull_f = np.array(dfull['ft'])
ifull_t = np.array(dfull['skin_time']) - dfull['skin_time'][0]

i3x3 = np.array(d3x3['skin'])/1000
i3x3_f = np.array(d3x3['ft'])
i3x3_t = np.array(d3x3['skin_time']) - d3x3['skin_time'][0]

i2x2 = np.array(d2x2['skin'])/1000
i2x2_f = np.array(d2x2['ft'])
i2x2_t = np.array(d2x2['skin_time']) - d2x2['skin_time'][0]

i1x1 = np.array(d1x1['skin'])/1000
i1x1_f = np.array(d1x1['ft'])
i1x1_t = np.array(d1x1['skin_time']) - d1x1['skin_time'][0]

half_sp = 110
whole_sp = 2*half_sp
max_len = min(len(i1x1), len(i2x2), len(i3x3), len(ifull))
off = 40

t_re = np.empty(whole_sp)
ifull_re = np.empty(whole_sp)
i3x3_re = np.empty(whole_sp)
i2x2_re = np.empty(whole_sp)
i1x1_re = np.empty(whole_sp)

t_re = i3x3_t[0:whole_sp]

# get full data
i = 1
while i < max_len:
    i = int(i)
    if i+whole_sp > max_len:
        break
    peak_i = i + np.argmax(ifull[i:i+whole_sp])
    st = peak_i - half_sp + off
    en = peak_i + half_sp + off
    if (st < 0):
        st = 0
    if (en > max_len):
        en = max_len
    i = en + half_sp
    if np.size(ifull_re) == 0:
        ifull_re = ifull[st:en]
    ifull_re = np.vstack((ifull_re, ifull[st:en]))
    # plt.plot(t_re, ifull[st:en], 'red')

# get 3x3 data
i = 1
while i < max_len:
    i = int(i)
    if i+whole_sp > max_len:
        break
    peak_i = i + np.argmax(i3x3[i:i+whole_sp])
    st = peak_i - half_sp + off
    en = peak_i + half_sp + off
    if (st < 0):
        st = 0
    if (en > max_len):
        en = max_len
    i = en + half_sp
    if np.size(i3x3_re) == 0:
        i3x3_re = i3x3[st:en]
    i3x3_re = np.vstack((i3x3_re, i3x3[st:en]))
    # plt.plot(t_re, i3x3[st:en], 'green')

# get 2x2 data
i = 1
while i < max_len:
    i = int(i)
    if i+whole_sp > max_len:
        break
    peak_i = i + np.argmax(i2x2[i:i+whole_sp])
    st = peak_i - half_sp + off
    en = peak_i + half_sp + off
    if (st < 0):
        st = 0
    if (en > max_len):
        en = max_len
    i = en + half_sp
    if np.size(i2x2_re) == 0:
        i2x2_re = i2x2[st:en]
    i2x2_re = np.vstack((i2x2_re, i2x2[st:en]))
    # plt.plot(t_re, i2x2[st:en], 'orange')

# get 1x1 data
i = 1
while i < max_len:
    i = int(i)
    if i+whole_sp > max_len:
        break
    peak_i = i + np.argmax(i1x1[i:i+whole_sp])
    st = peak_i - half_sp + off
    en = peak_i + half_sp + off
    if i1x1[peak_i] < 0.5:
        i = en + half_sp
        continue
    if (st < 0):
        st = 0
    if (en > max_len):
        en = max_len
    i = en + half_sp
    if np.size(i1x1_re) == 0:
        i1x1_re = i1x1[st:en]
    i1x1_re = np.vstack((i1x1_re, i1x1[st:en]))
    plt.plot(t_re, i1x1[st:en], 'purple')

plt.show()

ifull_avg = np.mean(ifull_re[1:-1], axis=0) # get average for each time point 
ifull_stddev = np.std(ifull_re[1:-1], axis=0) # get stddev for each time point

i3x3_avg = np.mean(i3x3_re[1:-1], axis=0) # get average for each time point 
i3x3_stddev = np.std(i3x3_re[1:-1], axis=0) # get stddev for each time point

i2x2_avg = np.mean(i2x2_re[1:-1], axis=0) # get average for each time point 
i2x2_stddev = np.std(i2x2_re[1:-1], axis=0) # get stddev for each time point

i1x1_avg = np.mean(i1x1_re[1:-1], axis=0) # get average for each time point 
i1x1_stddev = np.std(i1x1_re[1:-1], axis=0) # get stddev for each time point

ifull_avg = ifull_avg - ifull_avg[0]
i3x3_avg = i3x3_avg - i3x3_avg[0]
i2x2_avg = i2x2_avg - i2x2_avg[0]
i1x1_avg = i1x1_avg - i1x1_avg[0]

plt.plot(t_re, ifull_avg, color='red')
plt.plot(t_re, i3x3_avg, color='blue')
plt.plot(t_re, i2x2_avg, color='orange')
plt.plot(t_re, i1x1_avg, color='purple')

plt.xlabel('Time (s)')
plt.ylabel('Capacitance (pF)')
sns.despine()
plt.legend(['4cm x 4cm', '3cm x 3cm', '2cm x 2cm', '1cm x 1cm'], loc='upper left', bbox_to_anchor=(0, 1))
# plt.fill_between(t_re, inf_avg - 3*inf_stddev, inf_avg + 3*inf_stddev, alpha=0.5, color='tomato')
# plt.fill_between(t_re, force_avg - 3*force_stddev, force_avg + 3*force_stddev, alpha=0.5, color='darkblue')
plt.fill_between(t_re, ifull_avg - ifull_stddev, ifull_avg + ifull_stddev, alpha=0.5, color='red')
plt.fill_between(t_re, i3x3_avg - i3x3_stddev, i3x3_avg + i3x3_stddev, alpha=0.5, color='blue')
plt.fill_between(t_re, i2x2_avg - i2x2_stddev, i2x2_avg + i2x2_stddev, alpha=0.5, color='orange')
plt.fill_between(t_re, i1x1_avg - i1x1_stddev, i1x1_avg + i1x1_stddev, alpha=0.5, color='purple')
plt.tight_layout(pad=0)
plt.savefig("indenter.pdf", dpi=600)
plt.show()

# plt.plot(ifull, color='red')
# plt.plot(i3x3, color='blue')
# plt.plot(i2x2, color='orange')
# plt.plot(i1x1, color='purple')
# plt.show()