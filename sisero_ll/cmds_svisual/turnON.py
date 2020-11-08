import matplotlib.pyplot as plt
import numpy as np
import matplotlib.backends.backend_pdf
import pandas as pd
import scipy.constants as cnst

figs=[]
data='../out_svisual/SiSeRO_des.csv'

# ----------------------------------------
# Time evolution of contact variables
iv=pd.read_csv(data,skiprows=[1])
for col in iv.columns: 
    print(col) 

def gralplot(df,x,y):
	fig=plt.figure()
	plt.plot(df[x],df[y],'.-')
	plt.xlabel(x)
	plt.ylabel(y)
	plt.title(y)
	plt.grid()
	plt.show()
	figs.append(fig)
	plt.close(fig)

def gralplot2v(df,x,y,z):
	fig=plt.figure()
	plt.plot(df[x],df[y],'.-')
	plt.plot(df[x],df[z],'.-')
	plt.xlabel(x)
	plt.ylabel(y)
	plt.title(y)
	plt.grid()
	plt.show()
	figs.append(fig)
	plt.close(fig)

#gralplot(iv,'time','source OuterVoltage')
#gralplot(iv,'time','source TotalCurrent')
#gralplot(iv,'time','gate OuterVoltage')
#gralplot(iv,'time','gate TotalCurrent')
#gralplot(iv,'time','drain OuterVoltage')
#gralplot(iv,'time','drain TotalCurrent')
#gralplot(iv,'time','chargeflow Charge')
gralplot(iv,'time','IntegrWell(0.25:12.4) eDensity')
#gralplot(iv,'time','MaxWell(0.25:12.4) ElectrostaticPotential')
#gralplot(iv,'time','MaxWell(0.25:12.4) eQuasiFermiPotential')
#gralplot(iv,'time','AveWell(0.25:12.4) eQuasiFermiPotential')

gralplot(iv,'time','drain TotalCurrent','source TotalCurrent')

# Variable values at t=0
t=iv['time'].to_numpy()
for col in iv.columns: 
    print(col) 
    var=iv[col].to_numpy()
    print(var[t==0])

thk=2.4 #SiSero thickness in um

# Input transistor curve ID-vs-VGS
fig=plt.figure()
idrain=(iv['drain TotalCurrent'].to_numpy())*thk
vg=iv['gate OuterVoltage'].to_numpy()
vs=iv['source OuterVoltage'].to_numpy()
vgs=vg-vs
coeff= np.polyfit(vg-vs,idrain, 1)
p = np.poly1d(coeff)
plt.plot(vgs,idrain*1e6,'.-')
plt.plot(vgs,p(vgs)*1e6,'-')
plt.ylabel('drain TotalCurrent (uA)')
plt.xlabel('(gate-source) OuterVoltage (V)')
plt.grid()

print("Transconductace = %lf A/V" % coeff[0])
print("Transconductace = %lf nA/uV" % (coeff[0]*1e9/1e6))

exit()

