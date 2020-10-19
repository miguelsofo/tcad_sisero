import matplotlib.pyplot as plt
import numpy as np
import matplotlib.backends.backend_pdf
import pandas as pd

def plot1D(df,field,k):
	ydep=2.0 # Maximum plot substrate depth
	y = df['X'].to_numpy()
	z = df[field].to_numpy()
	z=z[(y>0) & (y<ydep)]
	y=y[(y>0) & (y<ydep)]
	fig=plt.figure()
	plt.plot(y,z, )
	plt.xlabel(r'x ($\mu$m)')
	plt.ylabel(field)
	plt.title(field)
	if k==1:
		plt.yscale('log')
	plt.grid()
	plt.show()
	figs.append(fig)
	plt.close(fig)


figs=[]
#data='../out_svisual/PreDrain_des.tdr.csv'
#data='../out_svisual/PreDrain_qf1.0_des.tdr.csv'
#data='../out_svisual/Vgs_0.65_des.tdr.csv'
data='../out_svisual/Vgs_0.65_qf1.3_des.tdr.csv'

# ------------------------------------------------------
# Read data set
df=pd.read_csv(data,skiprows=[1])
df.columns=['DopingWells','hQuasiFermiPotential','eQuasiFermiPotential','AcceptorConcentration','DonorConcentration','DopingConcentration','ElectricField','ElectrostaticPotential','SpaceCharge','TotalCurrentDensity','eCurrentDensity','eDensity','hCurrentDensity','hDensity','X']

# ------------------------------------------------------
# Densities
fields=['eDensity','hDensity']
for field in fields:
	plot1D(df,field,1)

# ------------------------------------------------------
# Potentials
fields=['eQuasiFermiPotential','ElectricField','ElectrostaticPotential']
for field in fields:
	plot1D(df,field,0)

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

