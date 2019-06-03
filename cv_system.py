# -*- coding: utf-8 -*-
"""
Class to simulate a CV quantum system

Created on Wed Apr  3 09:29:55 2019

@author: Eduardo Villasenor
"""

import operations as ops
import symplectic as sym
import beam_splitter as bs
import tools
import theory
import qutip as qt
import numpy as np



class System:
    def __init__(self, N, Nmodes=0, cm=False, cm_only=False):
        self.N = N
        if Nmodes != 0 and not cm_only:
            self.state = qt.tensor([qt.basis(self.N, 0)]*Nmodes)
            self.Nmodes = Nmodes
        elif Nmodes == 0:
            self.state = None
            self.Nmodes = 0

        if cm:
            eye = np.eye(2)
            self.cm = tools.direct_sum([eye]*Nmodes)
        else:
            self.cm = None

        self.quad_basis = None

    def add_vacuum(self, Nadd=1):
        state_add = qt.tensor([qt.basis(self.N, 0)]*Nadd)
        self.Nmodes = self.Nmodes + Nadd

        if self.state == None:
            self.state = state_add
        else:
            if not self.state.isket:
                state_add = state_add * state_add.dag()

            self.state = qt.tensor(state_add, self.state)


    def add_state(self, state):
        N_add = len(state.dims[0])
        self.Nmodes += N_add
        if self.state is None:
            self.state = state
        else:
            self.state = qt.tensor(state, self.state)


    def set_state(self, state):
        N_add = len(state.dims[0])
        self.Nmodes = N_add
        self.state = state


    def apply_BS(self, z, pos=[0,1]):
#        theta = np.arccos(np.sqrt(t))
#        U = bs.beam_splitter_U(self.N, theta, pos, self.Nmodes)
        U = ops.beam_splitter(self.N, z, pos, self.Nmodes)

        if self.state.isket:
            self.state = U * self.state
        else:
            self.state = U * self.state * U.dag()

        if self.cm is not None:
            S = sym.beam_splitter(z, pos, self.Nmodes)
            self.cm = tools.matrix_sandwich(S, self.cm)


    def apply_TMS(self, r, pos=[0,1]):
        U = ops.tmsqueeze(self.N, r, pos, self.Nmodes)

        if self.state.isket:
            self.state = U * self.state
        else:
            self.state = U * self.state * U.dag()

        if self.cm is not None:
            S = sym.two_mode_squeeze(r, pos, self.Nmodes)
            self.cm = tools.matrix_sandwich(S, self.cm)


    def apply_SMD(self, alpha, pos=0):
        U = qt.displace(self.N, alpha)
        U = tools.tensor(self.N, U, pos, self.Nmodes)

        if self.state.isket:
            self.state = U * self.state
        else:
            self.state = U * self.state * U.dag()


    def apply_SMS(self, r, pos=0):
        U = ops.squeeze(self.N, r, pos, self.Nmodes)

        if self.state.isket:
            self.state = U * self.state
        else:
            self.state = U * self.state * U.dag()

        if self.cm is not None:
            S = sym.single_mode_squeeze(r, pos, self.Nmodes)
            self.cm = tools.matrix_sandwich(S, self.cm)


    def apply_loss_channel(self, eta, pos):
        eta_theta = np.arccos(np.sqrt(eta))
        self.add_vacuum()
        self.apply_BS(eta_theta, [pos, self.Nmodes-1])

        # Trace out loss channel mode - NOTE in qutip the last one is index 0
        self.state = self.state.ptrace(range(1, self.Nmodes))
        self.Nmodes = self.Nmodes - 1


    def add_TMSV(self, r):
        state_aux = qt.tensor(qt.basis(self.N), qt.basis(self.N))
        S = ops.tmsqueeze(self.N, r)

        state_aux = S * state_aux
        self.Nmodes = self.Nmodes + 2

        if self.state == None:
            self.state = state_aux
        else:
            if not self.state.isket:
                state_aux = state_aux * state_aux.dag()

            self.state = qt.tensor(state_aux, self.state)

        if self.cm is not None:
            S = sym.two_mode_squeeze(r)
            cm_add = np.dot(S.transpose(), S)
            self.cm = tools.direct_sum([self.cm, cm_add])


    def collapse_fock_state(self, fock, pos):
        P = qt.basis(self.N, fock).dag()
        P = tools.tensor(self.N, P, pos, self.Nmodes)

        # Compute the probability of this collapse when measured
        self.Nmodes = self.Nmodes - 1
        return self.collapse_project(P)


    def collapse_project(self, P):
        if self.state.isket:
            self.state = P * self.state
            p = self.state.norm()
            if p != 0:
                self.state = self.state/p
            p = p**2
        else:
            self.state = P * self.state * P.dag()
            p = self.state.tr()
            if p != 0:
                self.state = self.state/p
        return p


    def collapse_ON_OFF(self, measurement, pos):
        if measurement == 0:
            return self.collapse_fock_state(0, pos)

        P = ops.photon_on_projector(self.N)
        P = tools.tensor(self.N, P, pos, self.Nmodes)

        p = self.collapse_project(P)

        if self.Nmodes != 1:
            self.ptrace([pos])
        return p


    def collapse_ON_OFF_multiple(self, measurements, positions):
        P_ON = ops.photon_on_projector(self.N)
        P_OFF = qt.basis(self.N) * qt.basis(self.N).dag()

        operators = [P_OFF if i==0 else P_ON for i in measurements]
        P = tools.tensor_singles(self.N, operators, positions, self.Nmodes)
        p = self.collapse_project(P)
        self.ptrace(positions)

        return p


    def collapse_prob(self, P):
        if self.state.isket:
            p = (P * self.state).norm()
            p = p**2
        else:
            p = (P * self.state * P.dag()).tr()
        return p


    def apply_photon_subtraction(self, t, pos=0):
        ps_theta = np.arccos(np.sqrt(t))
        self.add_vacuum()
        self.apply_BS(ps_theta, [self.Nmodes-1, pos])
        p_success = self.collapse_fock_state(1, self.Nmodes-1)
        return p_success


    def apply_scissors_exact(self, t, pos=0):
        # Tritter parameters
        theta1 = np.arccos(np.sqrt(t))
        theta2 = np.pi/4

        # Add extra state |10>
        extra_psi = qt.tensor(qt.basis(self.N, 1), qt.basis(self.N, 0))
        if not self.state.isket:
            extra_psi = extra_psi * extra_psi.dag()
        self.state = qt.tensor(extra_psi, self.state)
        Nmodes = self.Nmodes + 2

        # Apply tritter operator
        tritter_pos=[Nmodes-1, Nmodes-2, pos]

        ######
#        tritter_pos.reverse()

        U = ops.tritter(self.N, theta1, theta2, tritter_pos, Nmodes)
        # print(Nmodes, theta1, theta2, U)
        if self.state.isket:
            self.state = U * self.state
        else:
            self.state = U * self.state * U.dag()

        # Define the proyectors, in this case to |10>
        projector0 = qt.basis(self.N, 0).dag()
        projector1 = qt.basis(self.N, 1).dag()
        collapse_pos = [pos, Nmodes-1]
        projectorA = tools.tensor_singles(self.N, [projector0, projector1], collapse_pos, Nmodes)
        projectorB = tools.tensor_singles(self.N, [projector1, projector0], collapse_pos, Nmodes)

        p_success = self.collapse_prob(projectorB)
        p_success += self.collapse_project(projectorA)

        # Permute the state to return it to its original ordering
        p_list = np.arange(self.Nmodes)
        p_list[pos] = self.Nmodes - 1
        p_list[-1] = pos
        self.state = self.state.permute(p_list)
        return p_success


    def apply_scissors(self, k, r_aux, pos=0):
        # Tritter parameters
        theta1 = np.arccos(np.sqrt(k))
        theta2 = np.pi/4

        # Add extra vacuum and TMSV states
        self.add_vacuum()
        self.add_TMSV(r_aux)

        # Apply tritter operator
        tritter_pos=[self.Nmodes-1, self.Nmodes-3, pos]
        U = ops.tritter(self.N, theta1, theta2, tritter_pos, self.Nmodes)
        # print(Nmodes, theta1, theta2, U)
        if self.state.isket:
            self.state = U * self.state
        else:
            self.state = U * self.state * U.dag()

        # Define the proyectors, in this case to |10>
        projectorOFF = qt.basis(self.N,0) * qt.basis(self.N, 0).dag()
        projectorON = ops.photon_on_projector(self.N)
        collapse_pos = [pos, self.Nmodes-1, self.Nmodes-2]
        projectorA = tools.tensor_singles(self.N, [projectorOFF, projectorON, projectorON], collapse_pos, self.Nmodes)
#        projectorB = tools.tensor_singles(self.N, [projectorON, projectorOFF, projectorON], collapse_pos, self.Nmodes)

        # Compute the probability of the alternate click in the detectors
        p_success = self.collapse_prob(projectorA)
#        p_success += self.collapse_prob(projectorB)
#        print("p:", p_success)

        # Collapse the state
#        p_aux = self.collapse_ON_OFF(0, self.Nmodes-1)
#        p_aux = p_aux * self.collapse_ON_OFF(1, pos)
#        p_aux = p_aux * self.collapse_ON_OFF(1, self.Nmodes-2)
        p_aux = self.collapse_ON_OFF_multiple([1,0,1], collapse_pos)

#        p_success += self.collapse_project(projectorB)
        p_success += p_aux
#        print("p_aux:", p_aux)

        # Nmodes returns to original value by the funcs

        # Permute the state to return it to its original ordering
        p_list = np.arange(self.Nmodes)
        p_list[pos] = self.Nmodes - 1
        p_list[-1] = pos
        self.state = self.state.permute(p_list)
        return p_success


    def apply_scissors_options(self, k, r_aux, pos=0, option='a'):
        # Tritter parameters
        theta1 = np.arccos(np.sqrt(k))
        theta2 = np.pi/4

        # Add extra vacuum and TMSV states
        self.add_vacuum()
        self.add_TMSV(r_aux)

        # Apply tritter operator
        tritter_pos=[self.Nmodes-1, self.Nmodes-3, pos]
#        U = ops.tritter_options(self.N, theta1, theta2, tritter_pos, self.Nmodes, option)
        U = ops.tritter(self.N, theta1, theta2, tritter_pos, self.Nmodes)
        # print(Nmodes, theta1, theta2, U)
        if self.state.isket:
            self.state = U * self.state
        else:
            self.state = U * self.state * U.dag()

        # Define the proyectors, in this case to |10>
        projectorOFF = qt.basis(self.N, 0).dag()
        projectorON = ops.photon_on_projector(self.N)
        collapse_pos = [pos, self.Nmodes-1, self.Nmodes-2]
        projectorA = tools.tensor_singles(self.N, [projectorOFF, projectorON, projectorON], collapse_pos, self.Nmodes)
#        projectorB = tools.tensor_singles(self.N, [projectorON, projectorOFF, projectorON], collapse_pos, self.Nmodes)

        # Compute the probability of the alternate click in the detectors
        p_success = self.collapse_prob(projectorA)

        # Collapse the state
        if option == 'a':
            p_aux = self.collapse_ON_OFF(0, self.Nmodes-1)
            p_aux = p_aux * self.collapse_ON_OFF_multiple([1, 1], [pos, self.Nmodes-2])
        elif option == 'b':
            p_aux = self.collapse_ON_OFF_multiple([1, 1], [pos, self.Nmodes-2])
            p_aux = p_aux * self.collapse_ON_OFF(0, self.Nmodes-1)
        elif option == 'c':
            p_aux = self.collapse_ON_OFF(1, self.Nmodes-2)
            p_aux = p_aux * self.collapse_ON_OFF(1, pos)
            p_aux = p_aux * self.collapse_ON_OFF(0, self.Nmodes-1)

        p_success += p_aux

        # Permute the state to return it to its original ordering
        p_list = np.arange(self.Nmodes)
        p_list[pos] = self.Nmodes - 1
        p_list[-1] = pos
        self.state = self.state.permute(p_list)
        return p_success


    def apply_scissors2(self, k, r_aux, pos=0):
        # Tritter parameters
        theta1 = np.arccos(np.sqrt(k))
        theta2 = np.pi/4

        # Add extra vacuum and TMSV states
        self.add_vacuum()
        self.add_TMSV(r_aux)

        # Apply tritter operator
        tritter_pos=[self.Nmodes-1, self.Nmodes-3, pos]
        U = ops.tritter(self.N, theta1, theta2, tritter_pos, self.Nmodes)
        # print(Nmodes, theta1, theta2, U)
        if self.state.isket:
            self.state = U * self.state
        else:
            self.state = U * self.state * U.dag()

        # Define the proyectors, in this case to |10>
        projectorOFF = qt.basis(self.N, 0).dag()
        projectorON = ops.photon_on_projector2(self.N)
        collapse_pos = [pos, self.Nmodes-1, self.Nmodes-2]
        projectorA = tools.tensor_singles(self.N, [projectorOFF, projectorON, projectorON], collapse_pos, self.Nmodes)
        projectorB = tools.tensor_singles(self.N, [projectorON, projectorOFF, projectorON], collapse_pos, self.Nmodes)

        # Compute the probability of the alternate click in the detectors
        p_success = self.collapse_prob(projectorA)

        # Collapse the state
        p_success += self.collapse_project(projectorB)

        # Return Nmodes to original value
        self.Nmodes = self.Nmodes - 3

        # Permute the state to return it to its original ordering
        p_list = np.arange(self.Nmodes)
        p_list[pos] = self.Nmodes - 1
        p_list[-1] = pos
        self.state = self.state.permute(p_list)
        return p_success


    def apply_scissors2_options(self, k, r_aux, pos=0, option='a'):
        # Tritter parameters
        theta1 = np.arccos(np.sqrt(k))
        theta2 = np.pi/4

        # Add extra vacuum and TMSV states
        self.add_vacuum()
        self.add_TMSV(r_aux)

        # Apply tritter operator
        tritter_pos=[self.Nmodes-1, self.Nmodes-3, pos]
        U = ops.tritter_options(self.N, theta1, theta2, tritter_pos, self.Nmodes, option)
        # print(Nmodes, theta1, theta2, U)
        if self.state.isket:
            self.state = U * self.state
        else:
            self.state = U * self.state * U.dag()

        # Define the proyectors, in this case to |10>
        projectorOFF = qt.basis(self.N, 0).dag()
        projectorON = ops.photon_on_projector2(self.N)
        collapse_pos = [pos, self.Nmodes-1, self.Nmodes-2]
        projectorA = tools.tensor_singles(self.N, [projectorOFF, projectorON, projectorON], collapse_pos, self.Nmodes)
        projectorB = tools.tensor_singles(self.N, [projectorON, projectorOFF, projectorON], collapse_pos, self.Nmodes)

        # Compute the probability of the alternate click in the detectors
        p_success = self.collapse_prob(projectorA)

        # Collapse the state
        p_success += self.collapse_project(projectorB)

        # Return Nmodes to original value
        self.Nmodes = self.Nmodes - 3

        # Permute the state to return it to its original ordering
        p_list = np.arange(self.Nmodes)
        p_list[pos] = self.Nmodes - 1
        p_list[-1] = pos
        self.state = self.state.permute(p_list)
        return p_success


    def ptrace(self, pos):
        # Argument is positions to partially trace out

        # List to perform parcial trace
        pos_keep = list(range(self.Nmodes))
        pos_keep.reverse()

        for i in pos:
            pos_keep.remove(i)

        # Invert pos_keep to match qutip inverted modes
        pos_keep = self.Nmodes - 1 - np.array(pos_keep)

        self.state = self.state.ptrace(pos_keep)
        self.Nmodes = len(pos_keep)


    def get_simple_CM_V(self, mode):
        a = qt.destroy(self.N)
        a = tools.tensor(self.N, a, mode, self.Nmodes)

        v = 1 + 2 * self.state.dag() * a.dag() * a * self.state
        return v.norm()


    def get_simple_CM_C(self, modes):
        a = qt.destroy(self.N)
        a1 = tools.tensor(self.N, a, modes[0], self.Nmodes)
        a2 = tools.tensor(self.N, a, modes[1], self.Nmodes)

        c = self.state.dag() * (a1*a2 + a1.dag()*a2.dag()) * self.state
        return c.norm()


    def set_quadratures_basis(self):
        # basis = {x1, p1, x2, p2, ....., xn, pn}
        a = qt.destroy(self.N)
        x = (a + a.dag())/np.sqrt(2)
        p = 1j*(a - a.dag())/np.sqrt(2)

        basis = []
        # TODO: check the order of the basis
        for i in range(self.Nmodes):
            basis += [tools.tensor(self.N, x, i, self.Nmodes),
                      tools.tensor(self.N, p, i, self.Nmodes)]

        self.quad_basis = basis


    def get_CM_entry(self, indeces):
        am = self.quad_basis[indeces[0]]
        an = self.quad_basis[indeces[1]]
        a = qt.expect(am * an +  an * am, self.state)/2
        b = qt.expect(am, self.state) * qt.expect(an, self.state)
        Vmn = a - b
        return 2 * Vmn


    def get_full_CM(self):
        if self.quad_basis is None:
            self.set_quadratures_basis()

        # TODO: check this factor of 2
        cm = 2 * qt.covariance_matrix(self.quad_basis, self.state)
        return cm.astype(complex).real


    def check_CM(self):
        cm = self.get_full_CM()
        return np.array_equal(cm, self.cm)


    def replace_current_state_w_bad_TMSV(self, mean_photon_number):
        self.state = tools.tmsv_bad_method(self.N, mean_photon_number)
        self.Nmodes = 2


    def add_bad_TMSV(self, mean_photon_number):
        # NOTE: just for comparisson - shuold delete
        self.state = qt.tensor(self.state, theory.tmsv_state(self.N, mean_photon_number))
        self.Nmodes += 2


    def save_state(self):
        self.saved = [self.state, self.Nmodes, self.cm]


    def load_state(self):
        if self.saved is None:
            raise AttributeError("There is not a saved state")
        self.state = self.saved[0]
        self.Nmodes = self.saved[1]

        if self.cm is not None:
            self.cm = self.saved[2]


    def load_state_del(self):
        self.load_state()
        del self.saved
<<<<<<< HEAD
        
        
    def reset_state(self, Nmodes=None):
        if Nmodes == None:
            self.state = qt.tensor([qt.basis(self.N, 0)]*self.Nmodes)
        else:
            self.state = qt.tensor([qt.basis(self.N, 0)]*Nmodes)
            self.Nmodes = Nmodes
            
=======


    def reset_state(self):
        self.state = qt.tensor([qt.basis(self.N, 0)]*self.Nmodes)

>>>>>>> 405477e83ac8696f65edb8120dedd5030fe931d5
        if self.cm is not None:
            eye = np.eye(2)
            self.cm = tools.direct_sum([eye]*self.Nmodes)
