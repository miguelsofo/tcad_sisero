import matplotlib.pyplot as plt
import numpy as np
import matplotlib.backends.backend_pdf
import pandas as pd
import scipy.constants as cnst

figs=[]
data='../out_svisual/sens_Vgs_0.65_qf1.3.csv'

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

#gralplot(iv,'time','source OuterVoltage')
#gralplot(iv,'time','source TotalCurrent')
#gralplot(iv,'time','gate OuterVoltage')
#gralplot(iv,'time','gate TotalCurrent')
#gralplot(iv,'time','drain OuterVoltage')
#gralplot(iv,'time','drain TotalCurrent')
#gralplot(iv,'time','chargeflow Charge')
#gralplot(iv,'time','IntegrWell(0.25:12.4) eDensity')
#gralplot(iv,'time','IntegrWell(0.25:12.4) X_eDensity')
#gralplot(iv,'time','IntegrWell(0.25:12.4) Y_eDensity')
gralplot(iv,'time','MaxWell(0.25:12.4) ElectrostaticPotential')
gralplot(iv,'time','MaxWell(0.25:12.4) eQuasiFermiPotential')
gralplot(iv,'time','AveWell(0.25:12.4) eQuasiFermiPotential')

thk=2.4 #SiSero thickness in um
# Input transistor curve ID-vs-VGS
fig=plt.figure()
idrain=(iv['source TotalCurrent'].to_numpy())*thk

# See page 118 of sdevice_ug.pdf
# The default is IntegrationUnit=um. In a 2D simulation, the unit of the integral is either μm2cm–3 (IntegrationUnit=um) or cm–1 (IntegrationUnit=cm).
q=(iv['IntegrWell(0.25:12.4) eDensity'].to_numpy())*thk*1e-12 # After multiplying by thk, q is in μm3cm–3, and 1e-12is used to obtein the final value in number of electrons. 

coeff= np.polyfit(q,idrain, 1)
p = np.poly1d(coeff)

gain=coeff[0]
dc=coeff[1]
print("Idc = %lf uA" % (dc*1e6))
print("Gain = %lf nA/e-" % (gain*1e9))

plt.plot(q,idrain,'.-')
plt.plot(q,p(q),'-')
plt.grid()
plt.ylabel('source TotalCurrent (A)')
plt.xlabel('IntegrWell(0.25:12.4) eDensity (e-)')
plt.show()

R=20000
print("DC voltage in a %d ohm resistor: %lf V" % (R,dc*R))
print("Signal voltage in a %d ohm resistor: %lf V/e-" % (R,R*gain))

eqf=(iv['AveWell(0.25:12.4) eQuasiFermiPotential'].to_numpy())
plt.figure()
plt.plot(eqf,q,'.-')
plt.grid()
plt.ylabel('IntegrWell(0.25:12.4) eDensity (e-)')
plt.xlabel('MaxWell(0.25:12.4) eQuasiFermiPotential (V)')
plt.show()

exit()

