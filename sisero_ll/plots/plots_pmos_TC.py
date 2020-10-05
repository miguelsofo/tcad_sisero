import matplotlib.pyplot as plt
import numpy as np
import matplotlib.backends.backend_pdf
import pandas as pd

figs=[]
folder='../out_svisual/'

# ----------------------------------------
# Time evolution of contact variables
iv=pd.read_csv(folder+'pmos_TC_iv.csv',skiprows=[1])
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
    return 0

gralplot(iv,'time','source OuterVoltage')
gralplot(iv,'time','source TotalCurrent')
gralplot(iv,'time','gate OuterVoltage')
gralplot(iv,'time','gate TotalCurrent')
gralplot(iv,'time','drain OuterVoltage')
gralplot(iv,'time','drain TotalCurrent')

# Input transistor curve ID-vs-VGS
fig=plt.figure()
idrain=iv['drain TotalCurrent']
vg=iv['gate OuterVoltage']
vs=iv['source OuterVoltage']
plt.plot(vg-vs,idrain*1e3,'.-')
plt.ylabel('drain TotalCurrent (mA)')
plt.xlabel('(gate-source) OuterVoltage (V)')
plt.grid()
plt.show()
figs.append(fig)
plt.close(fig)

exit()
