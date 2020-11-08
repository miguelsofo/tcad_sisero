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
	replace_line("curves.tcl",0,'set infile '+inTDR+'\n')
	replace_line("curves.tcl",1,'set outfile  ../out_svisual/'+basename+'.csv\n')
	os.system('svisual -bx curves.tcl')
	os.system('rm *.log')	
	os.system('rm *.BAK')	

# ------------------------------
field2csv('../currents/SiSeRO_des.plt')

