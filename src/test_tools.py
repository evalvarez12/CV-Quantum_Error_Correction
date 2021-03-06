# -*- coding: utf-8 -*-
"""
Unit tests for the tools routines

Created on Tue Apr 30 10:59:11 2019

@author: Eduardo Villasenor
"""

import tools
import numpy as np
import qutip as qt
from scipy.linalg import block_diag
import unittest



class TestTools(unittest.TestCase):

    def test_tensor(self):
        N = 5
        U1 = qt.create(N)
        pos = 3

        U = tools.tensor(N, U1, pos, 8)

        U_ref = qt.tensor([qt.qeye(N)]*4 + [U1] + [qt.qeye(N)]*3)

        self.assertTrue(U == U_ref)


    def test_reorder_two_mode_operator(self):
        N = 2
        z = 3 + 1j
        a = qt.destroy(N)
        qid = qt.qeye(N)

        a1 = qt.tensor(a, qid)
        b1 = qt.tensor(qid, a)
        U = qt.squeezing(a1, b1, z)
        U = tools.reorder_two_mode_operator(N, U, pos=[3,1], Nmodes=4)

        a2 = qt.tensor(a, qid, qid, qid)
        b2 = qt.tensor(qid, qid, a, qid)
        U_ref = qt.squeezing(a2, b2, z)

        self.assertTrue(U == U_ref)


    def test_get_permutation_list(self):
        l = tools.get_permutation_list([0,1], 3)
        ref = [2, 1, 0]
        np.testing.assert_array_equal(l, ref)
        
        l = tools.get_permutation_list([1,0], 3)
        ref = [1, 2, 0]
        np.testing.assert_array_equal(l, ref)
        
        l = tools.get_permutation_list([1,2], 3)
        ref = [0, 2, 1]
        np.testing.assert_array_equal(l, ref)
        
        l = tools.get_permutation_list([2,1], 3)
        ref = [0, 1, 2]
        np.testing.assert_array_equal(l, ref)
        
        l = tools.get_permutation_list([0,2], 3)
        ref = [2, 0, 1]
        np.testing.assert_array_equal(l, ref)
        
        l = tools.get_permutation_list([2,0], 3)
        ref = [1, 0, 2]
        np.testing.assert_array_equal(l, ref)
        
        
    def test_get_permutation_list2(self):
        l = tools.get_permutation_list([2, 0], 4)
        ref = [2, 1, 3, 0]
        np.testing.assert_array_equal(l, ref)

        l = tools.get_permutation_list([0, 2], 4)
        ref = [3, 1, 2, 0]
        np.testing.assert_array_equal(l, ref)

        l = tools.get_permutation_list([2, 3], 4)
        ref = [0, 1, 3, 2]
        np.testing.assert_array_equal(l, ref)
        
        l = tools.get_permutation_list([3, 2], 4)
        ref = [0, 1, 2, 3]
        np.testing.assert_array_equal(l, ref)
        
        l = tools.get_permutation_list([3, 1], 4)
        ref = [0, 2, 1, 3]
        np.testing.assert_array_equal(l, ref)

        l = tools.get_permutation_list([0, 3], 4)
        ref = [3, 1, 0, 2]
        np.testing.assert_array_equal(l, ref)


    def test_direct_sum_singles(self):
        a = np.random.rand(2, 2)
        b = np.random.rand(4, 4)

        S = tools.direct_sum_singles([a, b], [2, 4], 6)

        idd = np.eye(2)
        S_ref = block_diag(idd, idd, a, idd, b, idd)

        np.testing.assert_array_equal(S, S_ref)


    def test_reorder_two_mode_symplectic(self):
        S1 = np.random.rand(4,4)

        S = tools.reorder_two_mode_symplectic(S1, pos=[1,3], Nmodes=5)

        A = S1[0:2, 0:2]
        B = S1[0:2, 2:4]
        C = S1[2:4, 0:2]
        D = S1[2:4, 2:4]

        idd = np.eye(2)
        z = np.zeros((2, 2))

        S_ref = np.block([[idd, z, z, z, z], [z, A, z, B, z], [z, z, idd, z, z], [z, C, z, D, z], [z, z, z, z, idd]])

        np.testing.assert_array_equal(S, S_ref)


if __name__ == '__main__':
    unittest.main()
