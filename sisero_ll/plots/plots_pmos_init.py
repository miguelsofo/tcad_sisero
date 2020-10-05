import matplotlib.pyplot as plt
import numpy as np
import matplotlib.backends.backend_pdf
import pandas as pd

figs=[]
folder='out_svisual/'

# Implants
fig=plt.figure()
boron1 , x1 = np.genfromtxt(folder+'Boron1.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x1,boron1,color='blue',label='B @ Y=12.5 (channel)')

boron2 , x2 = np.genfromtxt(folder+'Boron2.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x2,boron2,color='green',label='B @ Y=17.5 (diffusions)')

phos1 , x3 = np.genfromtxt(folder+'Phosphorus1.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x3,phos1,color='red',label='P @ Y=12.5 (channel)')

phos4 , x4 = np.genfromtxt(folder+'Phosphorus2.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x4,phos4,'--',color='red',label='P @ Y=1.0 (stops)')

plt.xlabel(r'x ($\mu$m)')
plt.ylabel(r'($cm^{-3}$)')
plt.title('Dopings')
plt.legend()
plt.yscale('log')
plt.xlim([-0.06,1.0])
plt.show()
figs.append(fig)
plt.close(fig)

#fig=plt.figure()
#plt.plot(xa,ND-NA,label='ND-NA')
#plt.xlabel(r'y ($\mu$m)')
#plt.ylabel(r'($cm^{-3}$)')
#plt.title('Expected space charge in fully depletion (ND-NA)')
#plt.legend()
##plt.yscale('log')
#plt.show()
#figs.append(fig)
##plt.close(fig)

fig=plt.figure()
efield , x = np.genfromtxt(folder+'ElectricField.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x,efield, label='Electric field')
plt.xlabel(r'x ($\mu$m)')
plt.ylabel('Electric field (V/cm)')
plt.title('Electric field')
plt.legend()
plt.show()
figs.append(fig)
#plt.close(fig)

fig=plt.figure()
potential , x = np.genfromtxt(folder+'ElectrostaticPotential.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x,potential, label='Sentaurus')
plt.xlabel(r'x ($\mu$m)')
plt.ylabel('Potential (V)')
plt.title('Potential')
plt.legend()
plt.grid()
plt.show()
figs.append(fig)
#plt.close(fig)

# Space charge
fig=plt.figure()
charge , x = np.genfromtxt(folder+'SpaceCharge.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x,charge, label='SpaceCharge')
plt.xlabel(r'x ($\mu$m)')
plt.ylabel('SpaceCharge')
plt.title('SpaceCharge')
plt.legend()
plt.grid()
plt.show()
figs.append(fig)
#plt.close(fig)

## ---------------------------------------------------------
## Check if the device is in deep depletion. 
## The resuting space charge should be equal to (ND-NA). This means that the concentration of holes and electrons is zero.
## The Poisson equations integrates this SpaceCharge to obtain the ElectrostaticPotential. 
#fig=plt.figure()
#plt.plot(x,charge-(ND-NA), label='SpaceCharge')
#plt.xlabel(r'y ($\mu$m)')
#plt.ylabel('SpaceCharge-(ND-NA)')
#plt.title('SpaceCharge-(ND-NA)')
#plt.legend()
#plt.grid()
#plt.show()
#figs.append(fig)

# ---------------------------------------------------------
# Electrons and holes density
fig=plt.figure()
eDensity , x = np.genfromtxt(folder+'eDensity.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x,eDensity, label='eDensity')
hDensity , x = np.genfromtxt(folder+'hDensity.csv', delimiter=',',skip_header=2,unpack=True)
plt.plot(x,hDensity, label='hDensity')
plt.xlabel(r'x ($\mu$m)')
plt.ylabel(r'Concentration (cm$^3$)')
plt.yscale('log')
plt.legend()
plt.grid()
plt.show()
figs.append(fig)
#plt.close(fig)

#fig=plt.figure()
#potential , x = np.genfromtxt(folder+'ElectrostaticPotential.csv', delimiter=',',skip_header=2,unpack=True)
#plt.plot(x,potential, label='ElectrostaticPotential')
#condBand , x = np.genfromtxt(folder+'ConductionBandEnergy.csv', delimiter=',',skip_header=2,unpack=True)
#plt.plot(x,condBand,label='ConductionBandEnergy')
#valeBand , x = np.genfromtxt(folder+'ValenceBandEnergy.csv', delimiter=',',skip_header=2,unpack=True)
#plt.plot(x,valeBand,label='ValenceBandEnergy')
##qfp , x = np.genfromtxt(folder+'QuasiFermiPotential.csv', delimiter=',',skip_header=2,unpack=True)
##plt.plot(x,qfp,label='QuasiFermiPotential')
#eqfp , x = np.genfromtxt(folder+'eQuasiFermiPotential.csv', delimiter=',',skip_header=2,unpack=True)
#plt.plot(x,eqfp,'--',label='eQuasiFermiPotential')
#hqfp , x = np.genfromtxt(folder+'hQuasiFermiPotential.csv', delimiter=',',skip_header=2,unpack=True)
#plt.plot(x,hqfp,'--',label='hQuasiFermiPotential')
#plt.xlabel(r'y ($\mu$m)')
#plt.ylabel('Energy (eV)')
#plt.legend()
#plt.grid()
#plt.show()
#figs.append(fig)
##plt.close(fig)

#pdf = matplotlib.backends.backend_pdf.PdfPages("ccd_phase200um.pdf")
#for i in range(0,len(figs)): 
#    pdf.savefig( figs[i] )
#pdf.close()


# ----------------------------------------
# Time evolution of contact variables
iv=pd.read_csv(folder+'pmos_init_iv.csv',skiprows=[1])
for col in iv.columns: 
    print(col) 

def gralplot(df,x,y):
	fig=plt.figure()
	plt.plot(df[x],df[y],'.-')
	plt.xlabel(x)
	plt.ylabel(y)
	plt.title(y)
	plt.show()
	figs.append(fig)
	plt.close(fig)

gralplot(iv,'time','source OuterVoltage')
gralplot(iv,'time','source TotalCurrent')
gralplot(iv,'time','gate OuterVoltage')
gralplot(iv,'time','gate TotalCurrent')
gralplot(iv,'time','drain OuterVoltage')
gralplot(iv,'time','drain TotalCurrent')
figs.append(fig)
plt.close(fig)

# Input transistor curve ID-vs-VGS
fig=plt.figure()
idrain=iv['drain TotalCurrent']
vg=iv['gate OuterVoltage']
vs=iv['source OuterVoltage']
plt.plot(vg,idrain,'.-')
plt.ylabel('drain TotalCurrent')
plt.xlabel('gate OuterVoltage')
plt.legend()
plt.show()
figs.append(fig)
plt.close(fig)

exit()

