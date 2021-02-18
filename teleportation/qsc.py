# -*- coding: utf-8 -*-
"""
Created on Mon Feb  1 10:18:53 2021

@author: z5239621
"""

import numpy as np
import scipy.optimize as op
import matplotlib.pyplot as plt




def avg_fidelity(V, T, tsc, eps, eta, g, sigma):
    gsc = np.sqrt((1 - tsc)/tsc)
    g = g*eta
    gt = g - 1

#    print('gsc:', gsc)

    norm = 2 / (V+1) - (gsc*2/(V+1))**2 * (1 / (1 + gsc**2))

    A1 = 2/(V + 1) + gsc**2*(2/(V+1) + 4/(V+1)**2)
    B1u = gsc*g*4*np.sqrt(T*(V**2 - 1))/(V+1)**2 - gsc**2 * \
          (2*(V-1)/(V+1)**2 + T*g**2*(2/(V+1) + 4/(V+1)**2))
    B1v = - gsc*g*4*np.sqrt(T*(V**2 - 1))/(V+1)**2 - gsc**2 * \
          (2*(V-1)/(V+1)**2 + T*g**2*(2/(V+1) + 4/(V+1)**2))
    A2 = 2*T*(V-1)*g**2/(V+1)**2
    A3 = 1/2*(g**2*(eps + 1) + 2 + g**2 + (g/eta)**2 * (1-eta**2))
    A4 = A1/A3 + A2/A3**3 * (12 + 1/4) + 1/(2 * A3**2) * (B1u + B1v)
    B2u = -gt**2 * (B1u/A3**3 - A2/A3**4 * (24 + 1/2))  
    B2v = -gt**2 * (B1v/A3**3 - A2/A3**4 * (24 + 1/2))  
    A5 = gt**4 * A2/A3**5 
    A6 = gt**2/A3 + 1/sigma    
    
#    print('A2:', A2)
#    print('A3:', A3)
#    print('A5:', A5)
#    print('A6:', A6)
#    print('norm:', norm)

    F = (1 / (1 + gsc**2)) * 1/sigma * (A4/A6 + (1/(2*A6**2))* (B2u + B2v) + A5/(A6**3)* (96 + 1/4))
    return F
    

def fidelity(V, T, tsc, eps, eta, g, alpha):
#    print('pars opt:', np.round(V, 3), np.round(tsc, 3), np.round(g, 3))

    gsc = np.sqrt((1 - tsc)/tsc)
    g = g*eta
    gt = g - 1

#    print(gsc, gt)

    norm = 2 / (V+1) - (gsc*2/(V+1))**2 * (1 / (1 + gsc**2))

    A1 = 2/(V + 1) + gsc**2*(2/(V+1) + 4/(V+1)**2) 
    B1u = gsc*g*4*np.sqrt(T*(V**2 - 1))/(V+1)**2 - gsc**2 * \
          (2*(V-1)/(V+1)**2 + T*g**2*(2/(V+1) + 4/(V+1)**2))
    B1v = - gsc*g*4*np.sqrt(T*(V**2 - 1))/(V+1)**2 - gsc**2 * \
          (2*(V-1)/(V+1)**2 + T*g**2*(2/(V+1) + 4/(V+1)**2))
    A2 = 2*T*(V-1)*g**2/(V+1)**2
    A3 = 1/2*(g**2*(eps + 1) + 2 + g**2 + (g/eta)**2 * (1-eta**2))
    A4 = A1/A3 + A2/A3**3 * (12 + 1/4) + 1/(2 * A3**2) * (B1u + B1v)
    B2u = -gt**2 * (B1u/A3**3 - A2/A3**4 * (24 + 1/2))  
    B2v = -gt**2 * (B1v/A3**3 - A2/A3**4 * (24 + 1/2))  
    A5 = gt**4 * A2/A3**5 
    
    
#    print('A1:', A1)
#    print('A2:', A2)
#    print('A3:', A3)
#    print('A4:', A4)
#    print('A5:', A5)
#    print('norm:', norm)

    F = (1 / (1 + gsc**2)) * np.exp(-(gt**2/A3)*np.abs(alpha)**2) * \
        (A4 + B2u * np.imag(alpha)**2 + B2v * np.real(alpha)**2 + \
         A5 * (np.real(alpha)*np.imag(alpha))**2 + \
         8*A5 * (np.real(alpha)**4 + np.imag(alpha)**4))
    return F


def fidelity_pars(pars, T, eps, eta, alpha):
    V, tsc, g = pars
    return fidelity(V, T, tsc, eps, eta, g, alpha)


def avg_fidelity_pars(pars, T, eps, eta, sigma):
    V, tsc, g = pars
    return avg_fidelity(V, T, tsc, eps, eta, g, sigma)


def opt_fidelity(T, eps, eta, alpha):
    F = lambda P : 1 - fidelity_pars(P, T, eps, eta, alpha)
    initial_guess = [2, .2, 1]
    cons=({'type': 'ineq',
           'fun': lambda x: x[0] - 1.01},
          {'type': 'ineq',
           'fun': lambda x: x[1]},
          {'type': 'ineq',
           'fun': lambda x: 1 - x[1]},
          {'type': 'ineq',
           'fun': lambda x: x[2]})
    

    res = op.minimize(F, initial_guess, constraints=cons)
#    res = op.minimize(F, initial_guess)
    print(res)
#    print('opt V:', np.round(res['x'],3))
    return fidelity_pars(res['x'], T, eps, eta, alpha)



def opt_avg_fidelity(T, eps, eta, sigma):
    F = lambda P : 1 - avg_fidelity_pars(P, T, eps, eta, sigma)
    initial_guess = [2, .2, 1]
    cons=({'type': 'ineq',
           'fun': lambda x: x[0] - 1.01},
          {'type': 'ineq',
           'fun': lambda x: x[1] - 0.01},
          {'type': 'ineq',
           'fun': lambda x: 1 - x[1]},
          {'type': 'ineq',
           'fun': lambda x: x[2]})
    

    res = op.minimize(F, initial_guess, constraints=cons)
#    res = op.minimize(F, initial_guess)
    print(res)
#    print('opt V:', np.round(res['x'],3))
    return avg_fidelity_pars(res['x'], T, eps, eta, sigma)

################################################
V = np.random.rand() + 1
T = np.random.rand() *.1
tsc = np.random.rand() * 1
#tsc = 0.2
#T = 1
#V = 1.00001
eps = 0.05
alpha = 5

sigma = 5
eta = .9
g = 1
print('pars:', np.round([V, T, tsc], 3))
print('F:', fidelity(V, T, tsc, eps, eta, g, alpha))

#print('F_opt', opt_fidelity(T, eps, 1, alpha))


print('F_avg:', avg_fidelity(V, T, tsc, eps, eta, g, sigma))
print('F_avg:', avg_fidelity(1., T, .01, eps, eta, g, sigma))

print('F_avg_opt', opt_avg_fidelity(T, eps, eta, alpha))
#print('F hand:', fidelity_pars([1.6, .999, .541], T, eps, 1, alpha))