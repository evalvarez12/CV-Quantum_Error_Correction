# -*- coding: utf-8 -*-
"""
Created on Wed Dec 11 14:24:13 2019

@author: z5239621
"""

import TMSV as tmsv
import coherent as co
import scipy.io
import numpy as np
import matplotlib.pyplot as plt

plt.close('all')
plt.rcParams["font.family"] = "Times New Roman"
############################# TRANSMISSIVITIES PLOT


t_ext_db = 2
eta_db = 0
eta = 10**(-eta_db/10)
t_ext = 10**(-t_ext_db/10)


colors_fill = {'up':'darkblue', 'upEM':'skyblue', 'down':'darkgreen', 'downEM':'lawngreen'}
colors = {'uplink':'b', 'downlink':'g'}

zs = [0, 5, 10, 15, 20 , 25, 30, 35, 40, 45, 50, 55, 60]
rs = [1]
fig = plt.figure()
ax = fig.add_subplot(111)
# ax2 = ax.twinx()


for r in rs:
   uplink_avg = []
   uplink_std = []
   downlink_avg = []
   downlink_std = []
   uplinkEM_avg = []
   uplinkEM_std = []
   downlinkEM_avg = []
   downlinkEM_std = []

   for z in zs:

       tag = "_z=" + str(z) + "_1024_10000"
       data_file = "../../Laser_propagation/data/TELE_DOWN_I_r=" + str(r) + tag
       downlink_data = scipy.io.loadmat(data_file)['res'].transpose()

       data_file = "../../Laser_propagation/data/TELE_UP_I_r=" + str(r) + tag
       uplink_data = scipy.io.loadmat(data_file)['res'].transpose()

       T_down = downlink_data * t_ext
       T_up = uplink_data * t_ext

       downlink_avg += [np.average(T_down)]
       downlink_std += [np.std(T_down)]

       uplink_avg += [np.average(T_up)]
       uplink_std += [np.std(T_up)]

       r_em = 1
       data_file = "../../Laser_propagation/data/DOWNLINK_PDF_EM_r=" + str(r_em) + '_z=' + str(z)
       downlinkEM_data = scipy.io.loadmat(data_file)['t'].transpose()

       data_file = "../../Laser_propagation/data/UPLINK_PDF_EM_r=" + str(r_em) + '_z=' + str(z)
       uplinkEM_data = scipy.io.loadmat(data_file)['t'].transpose()

       T_downEM = downlinkEM_data * t_ext
       T_upEM = uplinkEM_data * t_ext

       downlinkEM_avg += [np.average(T_downEM)]
       downlinkEM_std += [np.std(T_downEM)]

       uplinkEM_avg += [np.average(T_upEM)]
       uplinkEM_std += [np.std(T_upEM)]


       print('z =', z, 'DOWN T_Avg =', np.average(T_down))
       print('z =', z, 'UP T_Avg =', np.average(T_up))

       print('z =', z, 'DOWN scint =', np.average(T_down**2)/(np.average(T_down)**2) - 1)
       print('z =', z, 'DOWN scint EM =', np.average(T_downEM**2)/(np.average(T_downEM)**2) - 1)

       print('z =', z, 'UP scint =', np.average(T_up**2)/(np.average(T_up)**2) - 1)
       print('z =', z, 'UP scint EM =', np.average(T_upEM**2)/(np.average(T_upEM)**2) - 1)
       print('---------------')


   # Y1 = [y - e for y, e in zip(Tavg, Tstd)]
   # Y2 = [y + e for y, e in zip(Tavg, Tstd)]
   #
   # Y1_EM = [y - e for y, e in zip(Tavg_EM, Tstd_EM)]
   # Y2_EM = [y + e for y, e in zip(Tavg_EM, Tstd_EM)]
   #
   # ax.fill_between(zs, Y1_EM, Y2_EM, alpha=0.25, color=colors_fill[str(r)+'EM'])
   # ax.errorbar(zs, Tavg_EM, Tstd_EM, label=r'$r_d=' + str(r)+'$m EM', alpha=1, fmt=':', capsize=4, markersize=4, linewidth=1.5, c=colors_fill[str(r)+'EM'])
   #
   # ax.fill_between(zs, Y1, Y2, alpha=0.5, color=colors_fill[str(r)])
   # ax.errorbar(zs, Tavg, Tstd, label=r'$r_d=' + str(r)+'$m', alpha=1, fmt=':', capsize=4, markersize=4, linewidth=1.5, c=colors_fill[str(r)])


   ax.errorbar(zs, downlink_avg, downlink_std, label=r'downlink', linestyle='-', marker='o', capsize=4, markersize=4, linewidth=1.5, c=colors['downlink'])
   ax.errorbar(zs, uplink_avg, uplink_std, label=r'uplink', linestyle='-', marker='o', capsize=4, markersize=4, linewidth=1.5, c=colors['uplink'])

   ax.errorbar(zs, downlinkEM_avg, downlinkEM_std, label=r'downlink EM', linestyle='--', marker='o', capsize=4, markersize=4, linewidth=1.5, c=colors['downlink'])
   ax.errorbar(zs, uplinkEM_avg, uplinkEM_std, label=r'uplink EM', linestyle='--', marker='o', capsize=4, markersize=4, linewidth=1.5, c=colors['uplink'])



ax.set_xlabel(r'$\zeta$ (deg)')
ax.set_ylabel(r'$T$')
# ax2.set_ylabel(r'$\gamma$')
ax.grid()
ax.legend()





############ UPLINK & DOWNLINK CHANNELS PROPERTIES PLOT


#
# plt.figure()
# #for z in [0, 5, 10, 15, 20, 25, 30, 35, 40, 45]:
# r = 1
#
# colors_cycle = plt.rcParams['axes.prop_cycle'].by_key()['color']
# colors = {0: colors_cycle[0], 15:colors_cycle[1], 30:colors_cycle[2], 45:colors_cycle[3], 60:colors_cycle[4], 75:colors_cycle[5]}
#
# bins = np.arange(0.03, .450, .001)
# bins2 = np.arange(0.0, 1, .001)
#
# for z in [0, 15, 30, 45, 60]:
#     tag = "_z=" + str(z) + "_1024_10000"
#     data_file = "../../Laser_propagation/data/TELE_DOWN_I_r=" + str(r) + tag
#     downlink_data = scipy.io.loadmat(data_file)['res'].transpose()
#
#     data_file = "../../Laser_propagation/data/TELE_UP_I_r=" + str(r) + tag
#     uplink_data = scipy.io.loadmat(data_file)['res'].transpose()
#
#     print('z = ', z)
#     plt.hist(uplink_data * t_ext, bins=bins, histtype='step', label=str(z), density=True, linewidth=2, color=colors[z], linestyle=':')
#
# #    plt.hist((1-P)/P * db2, bins=bins2, histtype='step', label=str(z), density=True, linewidth=1.5, color=colors[z])


# for z in [0, 30, 75]:
#     tag = "_z=" + str(z) + "_1024_10000"
#     data_file = "l0d=0.1SH_DOWN_I_r=" + str(r)  + tag
#     I = scipy.io.loadmat(data_file)['res']
#     plt.hist(I * t_ext, bins=bins, histtype='step', label=str(z), density=True, linewidth=1.5, linestyle=':', color=colors[z])


#    plt.hist(P0*I, bins=bins)
    #plt.hist(I, bins=bins)
plt.xlabel('$T$')
plt.ylabel('PDF')
plt.legend()


scint_up = {}
scint_down = {}

colors = {'uplink':'b', 'downlink':'g'}
zs = [0, 5, 10, 15, 20 , 25, 30, 35, 40, 45, 50, 55, 60]
rs = [1]
fig = plt.figure()
ax = fig.add_subplot(111)
# ax2 = ax.twinx()
for r in rs:
   uplink_avg = []
   uplink_std = []
   downlink_avg = []
   downlink_std = []
   for z in zs:

       tag = "_z=" + str(z) + "_1024_10000"
       data_file = "../../Laser_propagation/data/TELE_DOWN_I_r=" + str(r) + tag
       downlink_data = scipy.io.loadmat(data_file)['res'].transpose()

       data_file = "../../Laser_propagation/data/TELE_UP_I_r=" + str(r) + tag
       uplink_data = scipy.io.loadmat(data_file)['res'].transpose()


       T_down = downlink_data * t_ext
       T_up = uplink_data * t_ext

       T_down_db = -10 * np.log10(T_down)
       T_up_db = -10 * np.log10(T_up)

       downlink_avg += [np.average(T_down_db)]
       downlink_std += [np.std(T_down_db)]

       uplink_avg += [np.average(T_up_db)]
       uplink_std += [np.std(T_up_db)]

       scint_down.update( {z : np.average(T_down**2)/(np.average(T_down)**2) - 1} )
       scint_up.update({z : np.average(T_up**2)/(np.average(T_up)**2) - 1} )


   # ax2.errorbar(zs, Pavg, Pstd,  linestyle=':', label=r'$r_d=' + str(r)+'$m', marker='^', capsize=1, markersize=4, c=colorsP[r])

   ax.errorbar(zs, downlink_avg, downlink_std, label=r'downlink', linestyle='--', marker='o', capsize=4, markersize=4, linewidth=1.5, c='navy')
   ax.errorbar(zs, uplink_avg, uplink_std, label=r'uplink', linestyle='--', marker='s', capsize=4, markersize=4, linewidth=1.5, c='dodgerblue')


   ax2 = ax.twinx()  # instantiate a second axes that shares the same x-axis

   ax2.set_ylabel(r'$\sigma_{SI}$', color='red')  # we already handled the x-label with ax
   ax2.plot(zs, list(scint_down.values()), 'v-', label=r'downlink', color='crimson')
   ax2.plot(zs, list(scint_up.values()), '^-', label=r'uplink', color='tomato')
   ax2.tick_params(axis='y', labelcolor='red')
   ax2.set_ylim(0.035, -0.001)
   ax2.legend()

#ax.set_zorder(1)
#ax.patch.set_visible(False)
ax.set_xlabel(r'$\zeta$ (deg)')
ax.set_ylabel(r'$\langle t \rangle (dB) $', color='blue')
ax.tick_params(axis='y', labelcolor='blue')
# ax2.set_ylabel(r'$\gamma$')
ax.grid()
ax.set_ylim(2.9, 17.5)

ax.legend()


############################# FIXED LOSS FIDELITIES PLOT
fig = plt.figure()
ax = fig.add_subplot(111)

T = np.logspace(0, -1.3, base=10)
Tdb = -10 * np.log10(T)
eps = 0.02
alpha = [(1 + 1j)*.8, 1 + 1j, (1 + 1j)*1.2,]

f_dir1 = []
f_dir2 = []
f_dir3 = []
f_tele = []

for it in T:
    f_tele += [tmsv.opt_fidelity(it, eps, eta, alpha=alpha[2])]
    f_dir1 += [co.fidelity(it, eps, alpha[0])]
    f_dir2 += [co.fidelity(it, eps, alpha[1])]
    f_dir3 += [co.fidelity(it, eps, alpha[2])]


ax.plot(Tdb, f_tele, label='Teleportation', linestyle='--', marker='o', markersize=4, linewidth=1.5)
ax.plot(Tdb, f_dir1, label=r'Direct $|\alpha|^2= $' + str(np.round(np.abs(alpha[0]),2)), linestyle='--', marker='o', markersize=4, linewidth=1.5)
ax.plot(Tdb, f_dir2, label=r'Direct $|\alpha|^2= $' + str(np.round(np.abs(alpha[1]),2)), linestyle='--', marker='o', markersize=4, linewidth=1.5)
ax.plot(Tdb, f_dir3, label=r'Direct $|\alpha|^2= $' + str(np.round(np.abs(alpha[2]),2)), linestyle='--', marker='o', markersize=4, linewidth=1.5)

clasical = np.ones_like(f_tele) * .5
plt.plot(Tdb, clasical, 'r--')

ax.set_xlabel(r'$t(dB)$')
ax.set_ylabel(r'Fidelity')
# plt.ylim([-0.005, 0.2])

ax.set_xlim(0, 13)
ax.set_ylim(.49, 1)
#ax.set_xscale('log')
ax.grid()
ax.legend()

############################## UPLINK & TELEPORTATION FIDELITIES PLOT
fig = plt.figure()
ax = fig.add_subplot(111)

zs = [0, 5, 10, 15, 20 , 25, 30, 35, 40, 45, 50, 55, 60]
rs = [1]


alpha = [(1 + 1j)*.8, 1 + 1j, (1 + 1j)*1.2,]


for r in rs:
   uplink_avg = []
   uplink_std = []
   downlink_avg = []
   downlink_std = []

   f_up1_avg = []
   f_up1_std = []
   f_up2_avg = []
   f_up2_std = []
   f_up3_avg = []
   f_up3_std = []

   f_tmsv_avg = []
   f_tmsv_std = []

   for z in zs:

       tag = "_z=" + str(z) + "_1024_10000"
       data_file = "../../Laser_propagation/data/TELE_DOWN_I_r=" + str(r) + tag
       downlink_data = scipy.io.loadmat(data_file)['res'].transpose()

       data_file = "../../Laser_propagation/data/TELE_UP_I_r=" + str(r) + tag
       uplink_data = scipy.io.loadmat(data_file)['res'].transpose()


       T_down = downlink_data * t_ext
       T_up = uplink_data * t_ext

       downlink_avg += [np.average(T_down)]
       downlink_std += [np.std(T_down)]

       uplink_avg += [np.average(T_up)]
       uplink_std += [np.std(T_up)]

       # TMSV
       eps = scint_down[z] * 2
       V_opt, F_opt = tmsv.opt_values(np.average(T_down), eps, eta, alpha=alpha[2])
       print("z =", z, V_opt, F_opt)

       eps = scint_down[z] * V_opt
       f_tmsv_avg += [np.average(tmsv.fidelity(V_opt, T_down, eps, eta, alpha[2]))]
       f_tmsv_std += [np.std(tmsv.fidelity(V_opt, T_down, eps, eta, alpha[2]))]

       eps = scint_up[z] * np.abs(alpha[0])
       f_up1_avg += [np.average(co.fidelity(T_up, eps, alpha[0]))]
       f_up1_std += [np.std(co.fidelity(T_up, eps, alpha[0]))]

       eps = scint_up[z] * np.abs(alpha[1])
       f_up2_avg += [np.average(co.fidelity(T_up, eps, alpha[1]))]
       f_up2_std += [np.std(co.fidelity(T_up, eps, alpha[1]))]

       eps = scint_up[z] * np.abs(alpha[2])
       f_up3_avg += [np.average(co.fidelity(T_up, eps, alpha[2]))]
       f_up3_std += [np.std(co.fidelity(T_up, eps, alpha[2]))]

   ax.errorbar(zs, f_tmsv_avg, f_tmsv_std, label=r'Teleportation', linestyle='--', marker='o', capsize=4, markersize=4, linewidth=1.5)
   ax.errorbar(zs, f_up1_avg, f_up1_std, label=r'Uplink $|\alpha|^2= $' + str(np.round(np.abs(alpha[0]),2)), linestyle='--', marker='o', capsize=4, markersize=4, linewidth=1.5)
   ax.errorbar(zs, f_up2_avg, f_up2_std, label=r'Uplink $|\alpha|^2= $' + str(np.round(np.abs(alpha[1]),2)), linestyle='--', marker='o', capsize=4, markersize=4, linewidth=1.5)
   ax.errorbar(zs, f_up3_avg, f_up3_std, label=r'Uplink $|\alpha|^2= $' + str(np.round(np.abs(alpha[2]),2)), linestyle='--', marker='o', capsize=4, markersize=4, linewidth=1.5)

#plt.plot(zs, np.zeros_like(zs), ls='--', c='k')

clasical = np.ones_like(f_tmsv_avg) * .5
plt.plot(zs, clasical, 'r--')


ax.set_xlabel(r'$\zeta$ (deg)')
ax.set_ylabel(r'Fidelity')
# plt.ylim([-0.005, 0.2])
ax.set_ylim(0.47, 0.81)
ax.set_xlim(-1, 71)
ax.grid()
ax.legend()





plt.show()
