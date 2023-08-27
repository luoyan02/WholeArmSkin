#!/usr/bin/env python3

import pickle
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

plt.figure(figsize=(5.0, 3.5))
plt.rc('font', family='serif', size='10') 

dfull = pickle.load(open('data_collection_indenter_full.pickle', "rb"))
d10x10 = pickle.load(open('data_collection_10x10taxel.pickle', "rb"))
d1x1 = pickle.load(open('data_collection_1x1taxel.pickle', "rb"))

ifull = np.array(dfull['skin'])/1000
ifull_f = np.array(dfull['ft'])
ifull_t = np.array(dfull['skin_time']) - dfull['skin_time'][0]

i10x10 = np.array(d10x10['skin'])/1000
i10x10_f = np.array(d10x10['ft'])
i10x10_t = np.array(d10x10['skin_time']) - d10x10['skin_time'][0]

i1x1 = np.array(d1x1['skin'])/1000
i1x1_f = np.array(d1x1['ft'])
i1x1_t = np.array(d1x1['skin_time']) - d1x1['skin_time'][0]

half_sp = 150
whole_sp = 2*half_sp
max_len = min(len(i1x1), len(i10x10), len(ifull))
off = 40

t_re = np.empty(whole_sp)
ifull_re = np.empty(whole_sp)
i10x10_re = np.empty(whole_sp)
i1x1_re = np.empty(whole_sp)

t_re = i10x10_t[0:whole_sp]

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

# get 10x10 data
# i = 1
# while i < max_len:
    # i = int(i)
    # if i+whole_sp > max_len:
    #     break
    # peak_i = i + np.argmax(i10x10[i:i+whole_sp])
    # st = peak_i - half_sp + off
    # en = peak_i + half_sp + off
    # if (st < 0):
    #     st = 0
    # if (en > max_len):
    #     en = max_len
    # i = en + half_sp
    # if np.size(i10x10_re) == 0:
    #     i10x10_re = i10x10[st:en]
    # i10x10_re = np.vstack((i10x10_re, i10x10[st:en]))
    # plt.plot(t_re, i10x10[st:en], 'green')

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
        i10x10_re = i10x10[st:en]
    i1x1_re = np.vstack((i1x1_re, i1x1[st:en]))
    i10x10_re = np.vstack((i10x10_re, i10x10[st:en]))
    # plt.plot(t_re, i1x1[st:en], 'orange')
    # plt.plot(t_re, i10x10[st:en], 'green')

ifull_avg = np.mean(ifull_re[1:-1], axis=0) # get average for each time point 
ifull_stddev = np.std(ifull_re[1:-1], axis=0) # get stddev for each time point

i10x10_avg = np.mean(i10x10_re[1:-1], axis=0) # get average for each time point 
i10x10_stddev = np.std(i10x10_re[1:-1], axis=0) # get stddev for each time point

i1x1_avg = np.mean(i1x1_re[1:-1], axis=0) # get average for each time point 
i1x1_stddev = np.std(i1x1_re[1:-1], axis=0) # get stddev for each time point

# ifull_avg = ifull_avg - ifull_avg[0]
# i10x10_avg = i10x10_avg - i10x10_avg[0]
# i1x1_avg = i1x1_avg - i1x1_avg[0]

plt.plot(t_re, i10x10_avg, color='red')
plt.plot(t_re, ifull_avg, color='blue')
plt.plot(t_re, i1x1_avg, color='orange')

plt.xlabel('Time (s)')
plt.ylabel('Capacitance (pF)')
sns.despine()
plt.legend(['10cm x 10cm', '4cm x 4cm', '1cm x 1cm'], loc='upper right', bbox_to_anchor=(1, 1))
# plt.fill_between(t_re, inf_avg - 3*inf_stddev, inf_avg + 3*inf_stddev, alpha=0.5, color='tomato')
# plt.fill_between(t_re, force_avg - 3*force_stddev, force_avg + 3*force_stddev, alpha=0.5, color='darkblue')
plt.fill_between(t_re, i10x10_avg - i10x10_stddev, i10x10_avg + i10x10_stddev, alpha=0.5, color='red')
plt.fill_between(t_re, ifull_avg - ifull_stddev, ifull_avg + ifull_stddev, alpha=0.5, color='blue')
plt.fill_between(t_re, i1x1_avg - i1x1_stddev, i1x1_avg + i1x1_stddev, alpha=0.5, color='orange')
plt.tight_layout(pad=0)
plt.savefig("taxelsize.pdf", dpi=600)
plt.show()

# plt.plot(ifull, color='red')
# plt.plot(i10x10, color='blue')
# plt.plot(i1x1, color='orange')
# plt.show()