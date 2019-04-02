# -*- coding: utf-8 -*-
"""
Basic CV operations

Created on Fri Feb 15 12:05:43 2019

@author: Eduardo Villasenor
"""

import qutip as qt
import numpy as np
import tools



def displace(a, alpha):
    return (alpha*a.dag() - alpha.conjugate()*a).expm()


def squeeze(a, z):
#    return ((z.conjugate()*a**2 - z*(a.dag()**2))/2).expm()
    return qt.squeezing(a, a, 2*z)


def tmsqueeze(N, z):
    a = qt.tensor(qt.destroy(N), qt.identity(N))
    b = qt.tensor(qt.identity(N), qt.destroy(N))
    
#    S = (z.conjugate()*a*b - z*a.dag()*b.dag()).expm()
    return qt.squeezing(a, b, 2*z)
    

def homodyne_operator2(N, phase, amplitude=1):
    z = amplitude*np.exp(1j*phase)
    print(z)
#    S = 1j*z*qt.create(N) - 1j*z.conjugate()*qt.destroy(N)
#    S = qt.squeeze(N, z)
    
    X = (qt.destroy(N) + qt.create(N))
    Y = -1j*(qt.destroy(N) - qt.create(N))
    S = abs(z)*(X*np.sin(np.angle(z)) + Y*np.cos(np.angle(z)))
    
    return S


def homodyne_operator(a, phase, amplitude=1):
    z = amplitude*np.exp(1j*phase)
#    S = 1j*z*qt.create(N) - 1j*z.conjugate()*qt.destroy(N)
#    S = qt.squeeze(N, z)
    
    X = (a + a.dag())
    Y = -1j*(a - a.dag())
    S = abs(z)*(X*np.sin(np.angle(z)) + Y*np.cos(np.angle(z)))
    
    return S


def var_homodyne(state, phase, amplitude=1):
    Shd = homodyne_operator2(state.dims[0][0], phase, amplitude)
    
    return qt.expect(Shd*Shd, state) - qt.expect(Shd, state)**2
    

def mean_homodyne(state, phase, amplitude=1):
    Shd = homodyne_operator2(state.dims[0][0], phase, amplitude)
    
    return qt.expect(Shd, state)


def purify(rho):
    eigenvals, eigenstates = rho.eigenstates()
    
    for i in range(len(eigenvals)):
        eigenstates[i] = np.sqrt(eigenvals[i]) * qt.tensor(eigenstates[i], eigenstates[i])
        
    return sum(eigenstates)


def photon_on_projector(N):
    P = 0
    for i in range(1, N):
        P += qt.basis(N, i).dag()
    return P 


#def photon_number_projector(n, N):
#    P = qt.basis(N, n).dag()
#    return P


def p_detect_photon_number_dm(N, rho, n, pos, Nmodes):
    P = qt.basis(N, n) * qt.basis(N, n).dag()
    P = tools.tensor(N, P, pos, Nmodes)
    return (P * rho).tr()


def p_detect_photon_number_ket(N, rho, n, pos, Nmodes):
    P = qt.basis(N, n).dag()
    P = tools.tensor(N, P, pos, Nmodes)
    return (P * rho).norm()


def collapse_photon_number(N, rho, n, pos, Nmodes):
    if rho.isket:
        return collapse_photon_number_ket(N, rho, n, pos, Nmodes)


def  collapse_photon_number_ket(N, rho, n, pos, Nmodes):
    P = qt.basis(N, n).dag()
    P = tools.tensor(N, P, pos, Nmodes)
    rho = (P * rho)/p_detect_photon_number_ket(N, rho, n, pos, Nmodes)
    return rho

def  collapse_photon_number_dm(N, rho, n, pos, Nmodes):
    P = qt.basis(N, n).dag()
    P = tools.tensor(N, P, pos, Nmodes)
    rho = (P * rho)/p_detect_photon_number_dm(N, rho, n, pos, Nmodes)
    return rho

def RCI(rho, pos_keep):
    rho_a = rho.ptrace(pos_keep)
    rci = qt.entropy_vn(rho_a) - qt.entropy_vn(rho)
    return rci
    



