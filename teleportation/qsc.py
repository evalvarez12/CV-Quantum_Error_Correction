# -*- coding: utf-8 -*-
"""
Created on Mon Feb  1 10:18:53 2021

@author: z5239621
"""

import numpy as np
import scipy.optimize as op
import matplotlib.pyplot as plt

def fidelity(V, T, tsc, eps, eta, g, alpha):
    print('pars opt:', np.round(V, 3), np.round(tsc, 3), np.round(g, 3))

    gsc = np.sqrt((1 - tsc)/tsc)
    g = g*eta
    gt = g - 1

#    print(gsc, gt)

    A1 = 1/((1+gsc**2)*(V+1))
    A2 = gsc*np.sqrt(V**2-1)/(2*(V+1))
    A3 = gsc**2*V/(V+1)
    A4 = gsc**2*(V**2-1)/(2*(V+1))
    A5 = (1+g*(eps + 2 - T))/2
    A6 = 1 + A3
    A7 = -2*A2*g-A3*g**2
    A8 = A5 + (g**2+1)/2 + (g/eta)**2*(1-eta**2)/2
    A9 = gt**2/A8
    
    print('A1:', A1)
    print('A2:', A2)
    print('A3:', A3)
    print('A4:', A4)
    print('A5:', A5)
    print('A6:', A6)
    print('A7:', A7)
    print('A8:', A8)
    print('A9:', A9)

    F = A1 * np.exp(-A9*np.abs(alpha)**2) * (A6 + A7/(np.sqrt(2)*A8**3) * (4*A8 - 4*gt**2*np.abs(alpha)**2) \
                    - A4*g**2*A8**5/2* (4*A8 + 24*A8**2 + np.abs(alpha)**2*(-48*A8*gt**2 - 4*gt**2) \
                                        + 16*gt**4*(np.real(alpha)**4 + np.imag(alpha)**4)))
    return F


def fidelity_pars(pars, T, eps, eta, alpha):
    V, tsc, g = pars
    return fidelity(V, T, tsc, eps, eta, g, alpha)

def opt_fidelity(T, eps, eta, alpha):
    F = lambda P : 1 - fidelity_pars(P, T, eps, eta, alpha)
    initial_guess = [2, .2, 1]
    cons=({'type': 'ineq',
           'fun': lambda x: x[0] - 1},
          {'type': 'ineq',
           'fun': lambda x: x[1]},
          {'type': 'ineq',
           'fun': lambda x: 1.1-x[1]},
          {'type': 'ineq',
           'fun': lambda x: x[2]})
    

    res = op.minimize(F, initial_guess, constraints=cons)
#    res = op.minimize(F, initial_guess)
    print(res)
#    print('opt V:', np.round(res['x'],3))
    return fidelity_pars(res['x'], T, eps, eta, alpha)


################################################
V = np.random.rand()*4 + 1
T = np.random.rand()
tsc = np.random.rand() * 0.5
tsc = 0.2
T = 1
V = 1.8
eps = 0
alpha = 1

print('pars:', V, T, tsc)
print('F:', fidelity(V, T, tsc, eps, 1, 1, alpha))

#print('F_opt', opt_fidelity(T, eps, 1, alpha))

#print('F hand:', fidelity_pars([1.6, .999, .541], T, eps, 1, alpha))