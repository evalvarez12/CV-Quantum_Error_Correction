# -*- coding: utf-8 -*-
"""
Files to normalize name on data files

Created on Thu Jun  6 11:38:47 2019

@author: Eduardo Villasenor
"""

from os.path import dirname, realpath


def measurements(N, eta, k, mu, measurement, protocol):
    """Name generator for measurement data files."""
    param_names = ["N=" + str(N), "eta=" + str(eta), "k=" + str(k),
                   "mu=" + str(mu)]

    param_names = "_".join(param_names)
    file_name = ["measurement", measurement, protocol]
    file_name = "_".join(file_name)
    # The address of the parent parent directory
    script_path = dirname(dirname(realpath(__file__)))
    file_name = (script_path + "/data/" + file_name
                 + "_" + param_names)
    return file_name


def indeces(N, eta, k, mu, measurement, protocol):
    """Name generator for measurement data files."""
    param_names = ["N=" + str(N), "eta=" + str(eta), "k=" + str(k),
                   "mu=" + str(mu)]

    param_names = "_".join(param_names)
    file_name = ["indeces", measurement, protocol]
    file_name = "_".join(file_name)
    # The address of the parent parent directory
    script_path = dirname(dirname(realpath(__file__)))
    file_name = (script_path + "/data/" + file_name
                 + "_" + param_names)
    return file_name

