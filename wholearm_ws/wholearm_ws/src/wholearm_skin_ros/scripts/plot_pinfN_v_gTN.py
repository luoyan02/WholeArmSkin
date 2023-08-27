#!/usr/bin/env python3

import pickle
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

plt.figure(figsize=(5, 3.5))
plt.rc('font', family='serif', size='10') 

model = pickle.load(open('fitted_poly3_model_l6t3_0217_mult.pickle', "rb"))
data = pickle.load(open('inference_data_t3_mult_50.pickle', "rb"))

x = np.array(data['skin'])
inf = model['a3'] + model['a2']*x + model['a1']*x**2 + model['a0']*x**3
force = np.array(data['ft'])
t = np.array(data['skin_time']) - data['skin_time'][0]

half_sp = 250
whole_sp = 2*half_sp
max_len = len(x)

t_re = np.empty(whole_sp)
inf_re = np.empty(whole_sp)
force_re = np.empty(whole_sp)

i = 1
while i < max_len:
    i = int(i)
    if i+whole_sp > max_len:
        break
    peak_i = i + np.argmin(force[i:i+whole_sp])
    # print(peak_i)
    st = peak_i - half_sp
    en = peak_i + half_sp
    if (st < 0):
        st = 0
    if (en > max_len):
        en = max_len
    i = en + half_sp
    if np.size(inf_re) == 0:
        inf_re = inf[st:en]
        force_re = force[st:en]
    # if np.size(t_re) == 0 and np.size(inf_re) != 0:
    #     t_re = t[st:en] - t[st]
    inf_re = np.vstack((inf_re, inf[st:en]))
    force_re = np.vstack((force_re, force[st:en]))
    # plt.plot(t[st:en] - t[st], inf[st:en], 'tomato')
    # plt.plot(t[st:en] - t[st], force[st:en], 'darkblue')

t_re = t[0:whole_sp]

inf_avg = np.mean(inf_re[1:], axis=0) # get average for each time point 
inf_stddev = np.std(inf_re[1:], axis=0) # get stddev for each time point
force_avg = np.mean(force_re[1:], axis=0) # get average for each time point
force_stddev = np.std(force_re[1:], axis=0) # get stddev for each time point


fig = plt.figure(1)
ax = fig.add_subplot(111)
plt.plot(t_re, -inf_avg, color='#1b9e77')
plt.plot(t_re, -force_avg, color='#d95f02')

plt.xlabel('Time (s)')
plt.ylabel('Force (N)')
sns.despine()
plt.legend(['Estimated Force', 'Ground Truth Force'], loc='upper left', bbox_to_anchor=(0, 1), frameon=False)
# plt.legend(['Estimated Force', 'Ground Truth Force'], loc='upper left', bbox_to_anchor=(1.05, 1.0))
# plt.fill_between(t_re, inf_avg - 3*inf_stddev, inf_avg + 3*inf_stddev, alpha=0.5, color='tomato')
# plt.fill_between(t_re, force_avg - 3*force_stddev, force_avg + 3*force_stddev, alpha=0.5, color='darkblue')
plt.fill_between(t_re, inf_avg - inf_stddev, inf_avg + inf_stddev, alpha=0.5, color='#1b9e77')
plt.fill_between(t_re, force_avg - force_stddev, force_avg + force_stddev, alpha=0.5, color='#d95f02')
plt.xlim([0, max(t_re)])
plt.ylim([0, -min(force_avg) + 10])
plt.tight_layout(pad=0)
ax.plot((1), (0), ls="", marker="4", ms=10, color="k",
    transform=ax.get_yaxis_transform(), clip_on=False)
ax.plot((0), (1), ls="", marker="2", ms=10, color="k",
    transform=ax.get_xaxis_transform(), clip_on=False)
plt.savefig("force_v_gTforce.pdf", dpi=600)
plt.show()