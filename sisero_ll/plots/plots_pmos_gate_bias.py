import matplotlib.pyplot as plt
import numpy as np
import matplotlib.backends.backend_pdf
import pandas as pd

figs=[]
folder='../out_svisual/'

# ---------------------------------------------------------
# Holes density
fig=plt.figure()
hDensity , x = np.genfromtxt(folder+'Vgs_0.00_hDensity.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x,hDensity, label='hDensity')
plt.xlabel(r'x ($\mu$m)')
plt.ylabel(r'Concentration (cm$^3$)')
plt.yscale('log')
plt.xlim([0,0.5])
plt.legend()
plt.grid()
plt.show()

# ---------------------------------------------------------
# Electron density
fig=plt.figure()
eDensity , x = np.genfromtxt(folder+'Vgs_0.00_eDensity.csv', delimiter=',', skip_header=2, unpack=True)
plt.plot(x,eDensity,label='eDensity')
plt.xlabel(r'x ($\mu$m)')
plt.ylabel(r'Concentration (cm$^3$)')
plt.yscale('log')
plt.xlim([0,0.5])
plt.legend()
plt.grid()
plt.show()

exit()
