# -*- coding: utf-8 -*-
"""
Create results for the GLOBECOMM paper
Created on Mon Mar  8 11:32:18 2021

@author: z5239621
"""


import TMSV as tmsv
import qsc as qs_t
import qsc_rec as qs_r
import scipy.io
import numpy as np
import matplotlib.pyplot as plt

plt.close('all')

############################## FIXED LOSS FIDELITIES PLOT - NON AVERAGE
#fig = plt.figure()
#ax = fig.add_subplot(111)
#
#T = np.linspace(0.01, 1)
#eps = 0.02
#eta = 10**(-1/10)
#alpha = [1, 3, 8, 10]
#
#f_tmsv = []
#f_qs_t = []
#f_qs_r = []
#
#for alp_ind in range(len(alpha)):
#    f_tmsv_i = []
#    f_qs_t_i = []
#    f_qs_r_i = []
#    
#    for it in T:
#        f_tmsv_i += [tmsv.opt_fidelity(it, eps, eta, alpha[alp_ind])]
#        f_qs_t_i += [qs_t.opt_fidelity(it, eps, eta, alpha[alp_ind])]
##        f_qs_r_i += [qs_r.opt_avg_fidelity(it, eps, eta, sigmaT[sig_ind])]
#    
#    f_tmsv += [f_tmsv_i]
#    f_qs_t += [f_qs_t_i]
#    f_qs_r += [f_qs_r_i]
#
#    
#    
#    
#ax.plot(T, f_tmsv[0], label=r'TMSV $\alpha= $' + str(np.round(np.abs(alpha[0]),2)), linestyle='-', marker='o', markersize=4, linewidth=1.5)
#ax.plot(T, f_tmsv[1], label=r'TMSV $\alpha= $' + str(np.round(np.abs(alpha[1]),2)), linestyle='-', marker='o', markersize=4, linewidth=1.5)
#ax.plot(T, f_tmsv[2], label=r'TMSV $\alpha= $' + str(np.round(np.abs(alpha[2]),2)), linestyle='-', marker='o', markersize=4, linewidth=1.5)
#ax.plot(T, f_tmsv[3], label=r'TMSV $\alpha= $' + str(np.round(np.abs(alpha[3]),2)), linestyle='-', marker='o', markersize=4, linewidth=1.5)
#
#ax.plot(T, f_qs_t[0], label=r'QS_t $\alpha= $' + str(np.round(np.abs(alpha[0]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
#ax.plot(T, f_qs_t[1], label=r'QS_t $\alpha= $' + str(np.round(np.abs(alpha[1]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
#ax.plot(T, f_qs_t[2], label=r'QS_t $\alpha= $' + str(np.round(np.abs(alpha[2]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
#ax.plot(T, f_qs_t[3], label=r'QS_t $\alpha= $' + str(np.round(np.abs(alpha[3]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
#
##ax.plot(T, f_qs_r[0], label=r'QS_r $\sigma= $' + str(np.round(np.abs(sigmaD[0]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
##ax.plot(T, f_qs_r[1], label=r'QS_r $\sigma= $' + str(np.round(np.abs(sigmaD[1]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
##ax.plot(T, f_qs_r[2], label=r'QS_r $\sigma= $' + str(np.round(np.abs(sigmaD[2]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
##ax.plot(T, f_qs_r[3], label=r'QS_r $\sigma= $' + str(np.round(np.abs(sigmaD[3]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
#
#
#clasical = np.ones_like(f_tmsv[0]) * .5
#plt.plot(T, clasical, 'r--')
#
#ax.set_xlabel(r'Fixed Loss')
#ax.set_ylabel(r'$\bar{\mathcal{F}} $')
## plt.ylim([-0.005, 0.2])
#
##ax.set_xlim(-0.1, 13)
#ax.set_ylim(.3, 1)
##ax.set_xscale('log')
#ax.grid()
#ax.legend()
#
#### To MATLAB
##data = [Tdb, f_tele1, f_tele2, f_tele3, f_tele4, f_dir1, f_dir2, f_dir3, f_dir4]
##scipy.io.savemat('matlab/fixed.mat', {'data':data})
#
#

############################# FIXED LOSS FIDELITIES PLOT
fig = plt.figure()
ax = fig.add_subplot(111)

T = np.linspace(0.0, 1, 15)
eps = 0.007
eta = 10**(-1/10)
eta = 0.9
sigmaT = [2, 4, 10, 25]
sigmaD = [6, 8, 13, 20]

sigma = [1]


f_tmsv = []
f_qs_t = []
f_qs_r = []

for sig_ind in range(len(sigma)):
    f_tmsv_i = []
    f_qs_t_i = []
    f_qs_r_i = []
    
    for it in T:
        f_tmsv_i += [tmsv.opt_fidelity_alphabet_gopt(it, eps, eta, sigma[sig_ind])]
#        f_qs_t_i += [qs_t.opt_avg_fidelity(it, eps, eta, sigmaD[sig_ind])]
#        f_qs_r_i += [qs_r.opt_avg_fidelity(it, eps, eta, sigmaT[sig_ind])]
    
    f_tmsv += [f_tmsv_i]
    f_qs_t += [f_qs_t_i]
    f_qs_r += [f_qs_r_i]

    
    
    
ax.plot(T, f_tmsv[0], label=r'TMSV $\sigma= $' + str(np.round(np.abs(sigmaT[0]),2)), linestyle='-', marker='o', markersize=4, linewidth=1.5)
#ax.plot(T, f_tmsv[1], label=r'TMSV $\sigma= $' + str(np.round(np.abs(sigmaT[1]),2)), linestyle='-', marker='o', markersize=4, linewidth=1.5)
#ax.plot(T, f_tmsv[2], label=r'TMSV $\sigma= $' + str(np.round(np.abs(sigmaT[2]),2)), linestyle='-', marker='o', markersize=4, linewidth=1.5)
#ax.plot(T, f_tmsv[3], label=r'TMSV $\sigma= $' + str(np.round(np.abs(sigmaT[3]),2)), linestyle='-', marker='o', markersize=4, linewidth=1.5)

#ax.plot(T, f_qs_t[0], label=r'QS_t $\sigma= $' + str(np.round(np.abs(sigmaD[0]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
#ax.plot(T, f_qs_t[1], label=r'QS_t $\sigma= $' + str(np.round(np.abs(sigmaD[1]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
#ax.plot(T, f_qs_t[2], label=r'QS_t $\sigma= $' + str(np.round(np.abs(sigmaD[2]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
#ax.plot(T, f_qs_t[3], label=r'QS_t $\sigma= $' + str(np.round(np.abs(sigmaD[3]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)

#ax.plot(T, f_qs_r[0], label=r'QS_r $\sigma= $' + str(np.round(np.abs(sigmaD[0]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
#ax.plot(T, f_qs_r[1], label=r'QS_r $\sigma= $' + str(np.round(np.abs(sigmaD[1]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
#ax.plot(T, f_qs_r[2], label=r'QS_r $\sigma= $' + str(np.round(np.abs(sigmaD[2]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)
#ax.plot(T, f_qs_r[3], label=r'QS_r $\sigma= $' + str(np.round(np.abs(sigmaD[3]),2)), linestyle='-', marker='*', markersize=4, linewidth=1.5)


clasical = np.ones_like(f_tmsv[0]) * .5
plt.plot(T, clasical, 'r--')

ax.set_xlabel(r'Fixed Loss')
ax.set_ylabel(r'$\bar{\mathcal{F}} $')
# plt.ylim([-0.005, 0.2])

#ax.set_xlim(-0.1, 13)
#ax.set_ylim(.49, 1)
#ax.set_xscale('log')
ax.grid()
ax.legend()

### To MATLAB
#data = [Tdb, f_tele1, f_tele2, f_tele3, f_tele4, f_dir1, f_dir2, f_dir3, f_dir4]
#scipy.io.savemat('matlab/fixed.mat', {'data':data})

plt.show()