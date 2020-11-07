import os
import numpy as np

def replace_line(file_name, line_num, text):
    lines = open(file_name, 'r').readlines()
    lines[line_num] = text
    out = open(file_name, 'w')
    out.writelines(lines)
    out.close()

# ---------------------------------------------
# INPUT PARAMETERS
initFile="PreDrain" # Initial structure
VSi=-7.0
VGi=-7.0
VGf=-6.9
dV=0.05 

# ---------------------------------------------
VG=np.arange(VGi,VGf+dV,dV) # VG sweep
VGS=VG-VSi # VGS sweep
tmplt="tmplt_SDEVICE_gate_bias.cmd" # Template script
inFile=[]
outFile=[]
vgInit=[]
vgGoal=[]
inFile.append(initFile)
outFile.append("Vgs_"+str("%0.2f"%VGS[0]))
vgInit.append(VGi)
vgGoal.append(vgInit[0]+VGS[0])
for vgs in VGS[1:-1]: 
	vgInit.append(vgGoal[-1])
	vgGoal.append(vgInit[-1]+vgs)
	inFile.append(outFile[-1])
	outFile.append("Vgs_"+str("%0.2f"%vgs))

for i in range(inFile):
	replace_line(tmplt,13,'Current = "../currents/'+outFile[i]+'"\n')
	replace_line(tmplt,20,'{Name="gate" Voltage='+str(vgInit[i])+'}\n')
	replace_line(tmplt,78,'Load ( FilePrefix="../savs/'+inFile[i]+'")\n')
	replace_line(tmplt,82,'Goal {Name="gate" Voltage='+str(vgGoal[i])+'}\n')
	replace_line(tmplt,84,'Plot (-Loadable FilePrefix="../plts/'+outFile[i]+'")\n')
	replace_line(tmplt,85,'Save (FilePrefix="../savs/'+outFile[i]+'")\n')
        os.system('sdevice '+tmplt)
        os.system('rm *.log')
        os.system('rm *.BAK')	
