import matplotlib.pyplot as plt
import numpy as np
import matplotlib.backends.backend_pdf

figs=[]
folder='../out_svisual/'

# Implants
fig=plt.figure()

# Before DEP
bDEP , x1 = np.genfromtxt(folder+'Phosphorus_beforeDEP.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x1,bDEP,color='blue',label='P BCIM+TRGH @ Y=12.5')

# After DEP
aDEP , x2 = np.genfromtxt(folder+'Phosphorus_afterDEP.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x2,aDEP,color='red',label='P BCIM+TRGH+DEP @ Y=12.5')

plt.xlabel(r'x ($\mu$m)')
plt.ylabel(r'($cm^{-3}$)')
plt.legend()
plt.grid()
plt.yscale('log')
plt.xlim([-0.06,1.0])
plt.ylim([10e11,10e17])
plt.show()
figs.append(fig)
plt.close(fig)

