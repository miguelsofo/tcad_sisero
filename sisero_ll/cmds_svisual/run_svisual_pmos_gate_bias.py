import os
import numpy as np

def replace_line(file_name, line_num, text):
    lines = open(file_name, 'r').readlines()
    lines[line_num] = text
    out = open(file_name, 'w')
    out.writelines(lines)
    out.close()

Vgs=np.arange(0.00,1.55,0.05) 
#Vgs=np.arange(0.00,0.15,0.05) 
#y=11.7
y=12.3
#y=13.5
for vgs in Vgs: 
	infile='set infile ../savs/Vgs_'+str("{:.2f}".format(vgs))+'_des.tdr\n'
	eD_png='set eD_png ../out_svisual/Vgs_'+str("{:.2f}".format(vgs))+'_eDensity.png\n'
	hD_png='set hD_png ../out_svisual/Vgs_'+str("{:.2f}".format(vgs))+'_hDensity.png\n'
	EP_png='set EP_png ../out_svisual/Vgs_'+str("{:.2f}".format(vgs))+'_EP.png\n'
	outh='set outh "../out_svisual/Vgs_'+str("{:.2f}".format(vgs))+'_hDensity.csv"\n'
	oute='set oute "../out_svisual/Vgs_'+str("{:.2f}".format(vgs))+'_eDensity.csv"\n'
	toti='set toti "../out_svisual/Vgs_'+str("{:.2f}".format(vgs))+'_TotalCurrentDensity.csv"\n'
   	ycut='set ycut '+str("{:.1f}".format(y))+'\n'	
	print(infile)
	print(eD_png)
	print(hD_png)
	print(EP_png)
	print(outh)
	print(oute)
	print(toti)
	print(ycut)
	replace_line("svisual_pmos_gate_bias.tcl",0,infile)
	replace_line("svisual_pmos_gate_bias.tcl",1,eD_png)
	replace_line("svisual_pmos_gate_bias.tcl",2,hD_png)
	replace_line("svisual_pmos_gate_bias.tcl",3,EP_png)
	replace_line("svisual_pmos_gate_bias.tcl",4,outh)
	replace_line("svisual_pmos_gate_bias.tcl",5,oute)
	replace_line("svisual_pmos_gate_bias.tcl",6,toti)
	replace_line("svisual_pmos_gate_bias.tcl",7,ycut)
	os.system('svisual -bx svisual_pmos_gate_bias.tcl')
