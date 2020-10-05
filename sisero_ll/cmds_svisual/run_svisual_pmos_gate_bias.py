import os
import numpy as np

def replace_line(file_name, line_num, text):
    lines = open(file_name, 'r').readlines()
    lines[line_num] = text
    print(lines)
    out = open(file_name, 'w')
    out.writelines(lines)
    out.close()

Vgs=np.arange(0.00,1.55,0.05) 
for vgs in Vgs: 
	infile='set infile Vgs_'+str("{:.2f}".format(vgs))+'_des.tdr\n'
	outfile='set outimg ../out_svisual/Vgs_'+str("{:.2f}".format(vgs))+'.png\n'
	outh='set outh "../out_svisual/Vgs_'+str("{:.2f}".format(vgs))+'_hDensity.csv"\n'
	oute='set oute "../out_svisual/Vgs_'+str("{:.2f}".format(vgs))+'_eDensity.csv"\n'
	print(infile)
	print(outfile)
	print(outh)
	print(oute)
	replace_line("svisual_pmos_gate_bias.tcl",0,infile)
	replace_line("svisual_pmos_gate_bias.tcl",1,outfile)
	replace_line("svisual_pmos_gate_bias.tcl",2,outh)
	replace_line("svisual_pmos_gate_bias.tcl",3,oute)
	#os.system('svisual -bx svisual_pmos_gate_bias.tcl')
