import matplotlib.pyplot as plt
import numpy as np
import matplotlib.backends.backend_pdf
import pandas as pd
import scipy.constants as cnst

figs=[]
#data='../out_svisual/PreDrain_des.tdr.csv'
#data='../out_svisual/PreDrain_qf1.0_des.tdr.csv'
data='../out_svisual/Vgs_0.65_iv.csv'

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

# Input transistor curve ID-vs-VGS
fig=plt.figure()
idrain=(iv['source TotalCurrent'].to_numpy())
q=(iv['chargeflow Charge'].to_numpy())/cnst.elementary_charge
plt.plot(q,idrain,'.-')
plt.grid()
plt.ylabel('source TotalCurrent')
plt.xlabel('chargeflow Charge')
plt.show()

print(idrain)
di=(idrain[-1]-idrain[0])
dq=q[-1]-q[0]

print("Gain ",di/dq)
print("Gain ",di/(21366-7607))

exit()

