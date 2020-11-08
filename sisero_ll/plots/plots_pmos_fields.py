from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
from scipy.interpolate import griddata
from matplotlib.colors import LogNorm
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.backends.backend_pdf
import pandas as pd

figs=[]

def plotfield(df,field,ycut,k):
	#lcut=11.6
	#rcut=12.7
	lcut=11.3
	rcut=13.3
	ydep=2.0 # Maximum plot substrate depth
	x = df['Y'].to_numpy()
	y = df['X'].to_numpy()
	z = df[field].to_numpy()
	#x=x[y<ydep]
	#z=z[y<ydep]
	#y=y[y<ydep]
	# Vertical cut
	x=x[(y>0) & (y<ydep)]
	z=z[(y>0) & (y<ydep)]
	y=y[(y>0) & (y<ydep)]
	# Horizontal cut
	z=z[(x>lcut) & (x<rcut)]
	y=y[(x>lcut) & (x<rcut)]
	x=x[(x>lcut) & (x<rcut)]
	#
	xi=np.arange(np.amin(x),np.amax(x),0.01)
	yi=np.arange(np.amin(y),np.amax(y),0.01)
	zi = griddata((x, y), z, (xi[None,:], yi[:,None]), method='cubic')
	fig=plt.figure()
	if k==1:
		zi=zi*(2.4*0.01*0.01)*(1e-4**3) ##Cell volume (cm3)
	cs=plt.contourf(xi,yi,zi,100,cmap=plt.cm.jet)
	#plt.subplot(211)
	cbar=plt.colorbar(cs)
	plt.gca().invert_yaxis()
	plt.axvline(11.9,color='k',linestyle='--') # TROUGH
	plt.axvline(12.7,color='k',linestyle='--') # TROUGH
	plt.axvline(11.3,color='k',linestyle='-') # DEP
	plt.axvline(13.3,color='k',linestyle='-') # DEP
	plt.axvline(10.1,color='r',linestyle='-') # DRAIN
	plt.axvline(14.5,color='r',linestyle='-') # SOURCE
	plt.axvline(11.1,color='r',linestyle='--') # BCIM CCD channel
	plt.axvline(13.5,color='r',linestyle='--') # BCIM CCD channel
	plt.xlim([np.amin(xi),np.amax(xi)])
	plt.xlabel(r'y ($\mu$m)')
	plt.ylabel(r'x ($\mu$m)')
	plt.title(field)
	plt.grid()
	#plt.show()
	#figs.append(fig)
	#plt.close(fig)

#def plotycut(df,field,ycut):
#	ydep=2.0 # Maximum plot substrate depth
#	x = df['Y'].to_numpy()
#	y = df['X'].to_numpy()
#	z = df[field].to_numpy()
#	x=x[(y>0) & (y<ydep)]
#	z=z[(y>0) & (y<ydep)]
#	y=y[(y>0) & (y<ydep)]
	xcut=ycut
	xcut=xi[np.argmin(np.abs(xi-xcut))]
	#yc=yi[xi==xcut]
	yc=yi
	zc=zi[:,xi==xcut]
	fig=plt.figure()
	#plt.subplot(212)
	plt.plot(yc,zc, label='@ y=%0.1f' % xcut)
	plt.xlabel(r'x ($\mu$m)')
	plt.ylabel(field)
	plt.title(field)
	if k==1:
		plt.yscale('log')
	plt.grid()
	plt.legend()
	plt.show()
	figs.append(fig)
	plt.close(fig)

figs=[]
#data='../out_svisual/PreDrain_des.csv'
data='../out_svisual/Vgs_1.00_des_2D.csv'


# ------------------------------------------------------
# Read data set
df=pd.read_csv(data,skiprows=[1])
df.columns=['DopingWells','hQuasiFermiPotential','eQuasiFermiPotential','AcceptorConcentration','DonorConcentration','DopingConcentration','ElectricField','ElectrostaticPotential','SpaceCharge','TotalCurrentDensity','eCurrentDensity','eDensity','hCurrentDensity','hDensity','X','Y']

# ------------------------------------------------------
# Densities
fields=['eDensity','hDensity']
for field in fields:
	plotfield(df,field,12.3,0)

# Potentials
fields=['eQuasiFermiPotential','ElectricField','ElectrostaticPotential','DopingWells']
for field in fields:
	plotfield(df,field,12.3,0)

pdf = matplotlib.backends.backend_pdf.PdfPages(data.rsplit('/',1)[1]+".pdf")
for i in range(0,len(figs)): 
    pdf.savefig( figs[i] )
pdf.close()

exit()

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

