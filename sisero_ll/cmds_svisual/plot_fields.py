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
#data='../out_svisual/Vgs_0.65_qf1.3_des.tdr.csv'
#data='../out_svisual/Vgs_1.00_des.tdr.csv'
#data='../out_svisual/Vgs_1.00_qf3.7_des.tdr.csv'

data='../out_svisual/Vgs_0.65_des.tdr.csv'
#data='../out_svisual/Vgs_0.80_des.tdr.csv'
#data='../out_svisual/Vgs_1.00_des.tdr.csv'
#data='../out_svisual/Vgs_1.20_des.tdr.csv'
#data='../out_svisual/Vgs_1.40_des.tdr.csv'

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

