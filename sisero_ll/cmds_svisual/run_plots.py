import os
import csv
import numpy as np

def replace_line(file_name, line_num, text):
    lines = open(file_name, 'r').readlines()
    lines[line_num] = text
    out = open(file_name, 'w')
    out.writelines(lines)
    out.close()

def field2csv(inTDR):
	basename=inTDR.rsplit('/',1)[1]
	replace_line("plots.tcl",0,'set infile '+inTDR+'\n')
	replace_line("plots.tcl",1,'set eD_png ../out_svisual/'+basename+'_eDensity.png\n')
	replace_line("plots.tcl",2,'set eQF_png ../out_svisual/'+basename+'_eQF.png\n')
	replace_line("plots.tcl",3,'set hD_png ../out_svisual/'+basename+'_hDensity.png\n')
	replace_line("plots.tcl",4,'set EP_png ../out_svisual/'+basename+'_EP.png\n')
	replace_line("plots.tcl",5,'set out_csv "../out_svisual/'+basename+'.csv"\n')
	os.system('svisual -bx plots.tcl')
	os.system('rm *.log')	
	os.system('rm *.BAK')	

# ------------------------------
#field2csv('../plts/PreDrain_des.tdr')
#field2csv('../plts/PreDrain_qf1.0_des.tdr')
#field2csv('../plts/Vgs_0.65_des.tdr')
#field2csv('../plts/Vgs_0.65_qf1.3_des.tdr')
#field2csv('../plts/Vgs_1.00_des.tdr')
#field2csv('../plts/Vgs_1.00_qf3.9_des.tdr')
field2csv('../plts/Vgs_1.00_qf3.7_des.tdr')

