import os
import csv
import numpy as np

def replace_line(file_name, line_num, text):
    lines = open(file_name, 'r').readlines()
    lines[line_num] = text
    out = open(file_name, 'w')
    out.writelines(lines)
    out.close()

def field2csv(inTDR,myfield,outCSV,ymin,ymax,dy):
	os.system('rm tmp.csv')	
	replace_line("svisual_2DtoCSV.tcl",0,'set infile '+inTDR+'\n')
	replace_line("svisual_2DtoCSV.tcl",7,'export_variables {'+myfield+' xMoleFraction X} -dataset $mydata1D -filename "tmp.csv" -overwrite\n')
	yv=np.arange(ymin,ymax,dy)
	for y in yv:
		replace_line("svisual_2DtoCSV.tcl",1,'set ycut '+str("{:.1f}".format(y))+'\n')
		while os.path.exists('tmp.csv') == False:
			os.system('svisual -bx svisual_2DtoCSV.tcl')
		# read tmp.csv
		field , x = np.genfromtxt('tmp.csv', delimiter=',',skip_header=2,unpack=True)	
		data=np.column_stack((np.column_stack((np.ones(x.shape)*y,x)),field))
		# append new data to output csv
		with open(outCSV, 'a') as f:
			csvwriter = csv.writer(f)
    			csvwriter.writerows(data)
		# Remove tmp file
		os.system('rm tmp.csv')	
	os.system('rm *.log')	
	os.system('rm *.BAK')	

# ------------------------------
# Inputs
inTDR='../plts/PreDrain_des.tdr'
outCSV='../out_svisual/test.csv'
myfield='ElectrostaticPotential'
ymin=10
ymax=10.3
dy=0.1
# ------------------------------------------------
field2csv(inTDR,myfield,outCSV,ymin,ymax,dy)
