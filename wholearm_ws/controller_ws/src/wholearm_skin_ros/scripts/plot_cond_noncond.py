#!/usr/bin/env python3

import pickle
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

plt.figure(figsize=(5.0, 3.5))
plt.rc('font', family='serif', size='10') 

noncond_data = pickle.load(open('inference_data_t3_mult_50.pickle', "rb"))
cond_data = pickle.load(open('inference_data_t3_cond.pickle', "rb"))

nc = np.array(noncond_data['skin'])/1000
f_nc = np.array(noncond_data['ft'])
t_nc = np.array(noncond_data['skin_time']) - noncond_data['skin_time'][0]

c = np.array(cond_data['skin'])/1000
f_c = np.array(cond_data['ft'])
t_c = np.array(cond_data['skin_time']) - cond_data['skin_time'][0]

half_sp = 300
whole_sp = 2*half_sp
max_len = len(c)

t_re = np.empty(whole_sp)
c_re = np.empty(whole_sp)
f_c_re = np.empty(whole_sp)
nc_re = np.empty(whole_sp)
f_nc_re = np.empty(whole_sp)

t_re = t_c[0:whole_sp]


# get conductive data
i = 1
while i < max_len:
    i = int(i)
    if i+whole_sp > max_len:
        break
    peak_i = i + np.argmax(c[i:i+whole_sp])
    st = peak_i - half_sp
    en = peak_i + half_sp
    if (st < 0):
        st = 0
    if (en > max_len):
        en = max_len
    i = en + half_sp
    if np.size(c_re) == 0:
        c_re = c[st:en]
        f_c_re = f_c[st:en]
    c_re = np.vstack((c_re, c[st:en]))
    f_c_re = np.vstack((f_c_re, f_c[st:en]))
    # plt.plot(t_re, c[st:en], 'tomato')
    

# get nonconductive data
i = 1
while i < max_len:
    i = int(i)
    if i+whole_sp > max_len:
        break
    peak_i = i + np.argmax(nc[i:i+whole_sp])
    st = peak_i - half_sp
    en = peak_i + half_sp
    if (st < 0):
        st = 0
    if (en > max_len):
        en = max_len
    i = en + half_sp
    if np.size(nc_re) == 0:
        nc_re = nc[st:en]
        f_nc_re = f_nc[st:en]
    nc_re = np.vstack((nc_re, nc[st:en]))
    f_c_re = np.vstack((f_nc_re, f_nc[st:en]))
    # plt.plot(t_re, nc[st:en], 'darkblue')

c_avg = np.mean(c_re[1:], axis=0) # get average for each time point 
c_stddev = np.std(c_re[1:], axis=0) # get stddev for each time point
nc_avg = np.mean(nc_re[1:], axis=0) # get average for each time point
nc_stddev = np.std(nc_re[1:], axis=0) # get stddev for each time point


fig = plt.figure(1)
ax = fig.add_subplot(111)
plt.plot(t_re, c_avg, color='#1b9e77')
plt.plot(t_re, nc_avg, color='#d95f02')

plt.xlabel('Time (s)')
plt.ylabel(u'Δ Capacitance (pF)')
sns.despine()
plt.legend(['Conductive Indenter', 'Nonconductive Indenter'], loc='lower center', bbox_to_anchor=(0.5, 0), frameon=False)
# plt.fill_between(t_re, inf_avg - 3*inf_stddev, inf_avg + 3*inf_stddev, alpha=0.5, color='tomato')
# plt.fill_between(t_re, force_avg - 3*force_stddev, force_avg + 3*force_stddev, alpha=0.5, color='darkblue')
plt.fill_between(t_re, c_avg - c_stddev, c_avg + c_stddev, alpha=0.5, color='#1b9e77')
plt.fill_between(t_re, nc_avg - nc_stddev, nc_avg + nc_stddev, alpha=0.5, color='#d95f02')
plt.tight_layout(pad=0)
plt.xlim([0, max(t_re)])
plt.ylim([0, max(c_avg) + 0.2])
ax.plot((1), (0), ls="", marker="4", ms=10, color="k",
    transform=ax.get_yaxis_transform(), clip_on=False)
ax.plot((0), (1), ls="", marker="2", ms=10, color="k",
    transform=ax.get_xaxis_transform(), clip_on=False)
plt.savefig("cond_v_noncond.pdf", dpi=600)
plt.show()