import matplotlib.pyplot as plt
import numpy as np
import matplotlib.backends.backend_pdf
import pandas as pd

figs=[]
folder='../out_svisual/'

# ---------------------------------------------------------
# Holes density
fig=plt.figure()
Vgs=np.arange(0.00,1.55,0.05) 
peak=[]
for vgs in Vgs:
	myfile=folder+'Vgs_'+str("{:.2f}".format(vgs))+'_hDensity.csv' 
	hDensity , x = np.genfromtxt(myfile, delimiter=',',skip_header=2,unpack=True)
	plt.plot(x,hDensity, label='Vgs='+str("{:.2f}".format(vgs))+'V')
	xc=x[(x>0) & (x<0.1)]
	hc=hDensity[(x>0) & (x<0.1)]
	peak.append(xc[np.argmax(hc)])	
plt.xlabel(r'x ($\mu$m)')
plt.ylabel(r'Concentration (cm$^3$)')
plt.title('hDensity')
#plt.yscale('log')
plt.xlim([0,0.1])
#plt.legend()
plt.grid()
plt.show()

fig=plt.figure()
plt.plot(Vgs,peak,'.-')
plt.ylabel(r'$x_{max}$ ($\mu$m)')
plt.xlabel('Vgs (V)')
plt.grid()
plt.show()

# ---------------------------------------------------------
# TotalCurrentDensity
fig=plt.figure()

peak=[]
for vgs in Vgs:
	myfile=folder+'Vgs_'+str("{:.2f}".format(vgs))+'_TotalCurrentDensity.csv' 
	iDensity , x = np.genfromtxt(myfile, delimiter=',', skip_header=2, unpack=True)
	plt.plot(x,iDensity,label='TotalCurrentDensity')
	xc=x[(x>0) & (x<0.1)]
	ic=iDensity[(x>0) & (x<0.1)]
	peak.append(xc[np.argmax(ic)])	

plt.xlabel(r'x ($\mu$m)')
plt.ylabel(r'Concentration (cm$^3$)')
plt.title('TotalCurrentDensity')
#plt.yscale('log')
plt.xlim([0,0.1])
#plt.legend()
plt.grid()
plt.show()

fig=plt.figure()
plt.plot(Vgs,peak,'.-')
plt.ylabel(r'$x_{max}$ ($\mu$m)')
plt.xlabel('Vgs (V)')
plt.title('TotalCurrentDensity')
plt.grid()
plt.show()

# ---------------------------------------------------------
# Electron density
fig=plt.figure()

for vgs in Vgs:
	myfile=folder+'Vgs_'+str("{:.2f}".format(vgs))+'_eDensity.csv' 
	eDensity , x = np.genfromtxt(myfile, delimiter=',', skip_header=2, unpack=True)
	plt.plot(x,eDensity,label='eDensity')

plt.xlabel(r'x ($\mu$m)')
plt.ylabel(r'Concentration (cm$^3$)')
plt.yscale('log')
plt.xlim([0,0.5])
#plt.legend()
plt.grid()
plt.show()

exit()
