#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  9 09:18:31 2021

Example 0:
 * Compute a collisionless guiding-center orbit with GORILLA for a trapped Deuterium particle. (Manually execute ''test_gorilla_main.x'')
 * Use a field-aligned grid for a non-axisymmetric VMEC MHD equilibrium.
 * Load the results of GORILLA with polynominal order 4.
 * Create a figure with the Poincaré sections (v_\parallel = 0) in cylindrical and symmetry flux coordinates.

@author: Michael Eder, Georg Graßler
"""

import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
mpl.rcdefaults()


# Load Poincaré cut data from example_1 in symmetry flux coordinates (s,\vartheta,\varphi)
poincare_sthetaphi = np.genfromtxt("../EXAMPLES/example_1/poincare_plot_vpar_0_sthetaphi.dat")

# Load Poincaré cut data from example_1 in cylindrical coordinates (R,\varphi,Z)
poincare_rphiz = np.genfromtxt("../EXAMPLES/example_1/poincare_plot_vpar_0_rphiz.dat")

# Plot Poincaré sections and evolution of the normalized parallel adiabatic invariant as a function of banana bounces
fig, (ax1, ax2) = plt.subplots(1, 2)
fig.suptitle('Stellarator: Poincaré sections of trapped particle')


ax1.plot(poincare_rphiz[:,0],poincare_rphiz[:,2],'.')
ax1.set_xlabel('R [cm]')
ax1.set_ylabel('Z [cm]')
ax1.set_title('Poincaré v_par = 0')


ax2.plot(poincare_sthetaphi[:,1],poincare_sthetaphi[:,0],'.')
ax2.set_xlabel('theta')
ax2.set_ylabel('s')
ax2.set_title('Poincaré v_par = 0')

plt.tight_layout()

plt.show()
