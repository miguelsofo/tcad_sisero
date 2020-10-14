from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
from scipy.interpolate import griddata
from matplotlib.colors import LogNorm
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.backends.backend_pdf
import pandas as pd

figs=[]
folder='../out_svisual/'

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

# ------------------------------------------------------
# Electrostatic Potential
# Read data 
x, y, z = np.genfromtxt(folder+'init_2D_ElectrostaticPotential.csv', delimiter=',',skip_header=2,unpack=True)
ydep=1.5 # Maximum plot substrate depth
x=x[y<ydep]
z=z[y<ydep]
y=y[y<ydep]
# Look for collection well
xw=x[(x>11.9) & (x<12.7) & (y>0.0)]
yw=y[(x>11.9) & (x<12.7) & (y>0.0)]
zw=z[(x>11.9) & (x<12.7) & (y>0.0)]
xcw=xw[np.argmax(zw)]
ycw=yw[np.argmax(zw)]
print("Collection well @ x=%0.2lf y=%0.2lf" % (xcw,ycw))
# Prepare data for surface ploting
xi=np.arange(np.amin(x),np.amax(x),0.01)
yi=np.arange(np.amin(y),np.amax(y),0.01)
zi = griddata((x, y), z, (xi[None,:], yi[:,None]), method='cubic')
# Plot
fig=plt.figure()
cs=plt.contourf(xi,yi,zi,100,cmap=plt.cm.jet)
cbar=plt.colorbar(cs)
plt.plot(xcw,ycw,'x',color='k') # Plot the position of the collection well
plt.gca().invert_yaxis()
plt.axvline(11.9,color='k',linestyle='--') # TROUGH
plt.axvline(12.7,color='k',linestyle='--') # TROUGH
plt.axvline(11.3,color='k',linestyle='-') # DEP
plt.axvline(13.3,color='k',linestyle='-') # DEP
plt.xlabel(r'y ($\mu$m)')
plt.ylabel(r'x ($\mu$m)')
plt.title('ElectrostaticPotential')
plt.grid()
plt.show()
figs.append(fig)

xcut=12.3
xcut=x[np.argmin(np.abs(x-xcut))]
yc=y[x==xcut]
zc=z[x==xcut]
fig=plt.figure()
plt.plot(yc,zc, label='Potential @ %0.1f' % xcut)
plt.xlabel(r'x ($\mu$m)')
plt.ylabel('Potential (V)')
plt.title('ElectrostaticPotential')
plt.legend()
plt.show()
figs.append(fig)
plt.close(fig)

# ---------------------------------------------------------
# Electrons density
# Surface plot 
x, y, z = np.genfromtxt(folder+'init_2D_eDensity.csv', delimiter=',',skip_header=2,unpack=True)
x=x[y<ydep]
z=z[y<ydep]
y=y[y<ydep]
xi=np.arange(np.amin(x),np.amax(x),0.01)
yi=np.arange(np.amin(y),np.amax(y),0.01)
zi = griddata((x, y), z, (xi[None,:], yi[:,None]), method='cubic')
fig=plt.figure()
cs=plt.contourf(xi,yi,zi,15,cmap=plt.cm.jet,norm = LogNorm())
cbar=plt.colorbar(cs)
plt.ylim([0,np.max(yi)])
plt.gca().invert_yaxis()
plt.axvline(11.9,color='k',linestyle='--') # TROUGH
plt.axvline(12.7,color='k',linestyle='--') # TROUGH
plt.xlabel(r'y ($\mu$m)')
plt.ylabel(r'x ($\mu$m)')
plt.title('eDensity')
plt.grid()
plt.show()
figs.append(fig)

xcut=12.3
xcut=x[np.argmin(np.abs(x-xcut))]
yc=y[x==xcut]
zc=z[x==xcut]
fig=plt.figure()
plt.plot(yc,zc, label='eDensity @ %0.1f' % xcut)
plt.xlabel(r'x ($\mu$m)')
plt.ylabel(r'Concentration (cm$^3$)')
plt.yscale('log')
plt.title('eDensity')
plt.legend()
plt.show()
figs.append(fig)
plt.close(fig)

# ---------------------------------------------------------
# Holes density
# Surface plot 
x, y, z = np.genfromtxt(folder+'init_2D_hDensity.csv', delimiter=',',skip_header=2,unpack=True)
x=x[y<ydep]
z=z[y<ydep]
y=y[y<ydep]
xi=np.arange(np.amin(x),np.amax(x),0.01)
yi=np.arange(np.amin(y),np.amax(y),0.01)
zi = griddata((x, y), z, (xi[None,:], yi[:,None]), method='cubic')
fig=plt.figure()
cs=plt.contourf(xi,yi,zi,15,cmap=plt.cm.jet,norm = LogNorm())
cbar=plt.colorbar(cs)
plt.ylim([0,np.max(yi)])
plt.gca().invert_yaxis()
plt.axvline(11.9,color='k',linestyle='--') # TROUGH
plt.axvline(12.7,color='k',linestyle='--') # TROUGH
plt.xlabel(r'y ($\mu$m)')
plt.ylabel(r'x ($\mu$m)')
plt.title('hDensity')
plt.grid()
plt.show()
figs.append(fig)

xcut=12.3
xcut=x[np.argmin(np.abs(x-xcut))]
yc=y[x==xcut]
zc=z[x==xcut]
fig=plt.figure()
plt.plot(yc,zc, label='hDensity @ %0.1f' % xcut)
plt.xlabel(r'x ($\mu$m)')
plt.ylabel(r'Concentration (cm$^3$)')
plt.yscale('log')
plt.title('hDensity')
plt.legend()
plt.show()
figs.append(fig)
plt.close(fig)

## ----------------------------------------
## Time evolution of contact variables
#iv=pd.read_csv(folder+'pmos_init_iv.csv',skiprows=[1])
#for col in iv.columns: 
#    print(col) 
#
#def gralplot(df,x,y):
#	fig=plt.figure()
#	plt.plot(df[x],df[y],'.-')
#	plt.xlabel(x)
#	plt.ylabel(y)
#	plt.title(y)
#	plt.show()
#	figs.append(fig)
#	plt.close(fig)
#
#gralplot(iv,'time','source OuterVoltage')
#gralplot(iv,'time','source TotalCurrent')
#gralplot(iv,'time','gate OuterVoltage')
#gralplot(iv,'time','gate TotalCurrent')
#gralplot(iv,'time','drain OuterVoltage')
#gralplot(iv,'time','drain TotalCurrent')
#figs.append(fig)
#plt.close(fig)
#
## Input transistor curve ID-vs-VGS
#fig=plt.figure()
#idrain=iv['drain TotalCurrent']
#vg=iv['gate OuterVoltage']
#vs=iv['source OuterVoltage']
#plt.plot(vg,idrain,'.-')
#plt.ylabel('drain TotalCurrent')
#plt.xlabel('gate OuterVoltage')
#plt.legend()
#plt.show()
#figs.append(fig)
#plt.close(fig)

exit()

