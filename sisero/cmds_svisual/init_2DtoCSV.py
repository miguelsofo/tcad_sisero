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
	replace_line("svisual_2DtoCSV.tcl",6,'export_variables {'+myfield+' xMoleFraction X} -dataset $mydata1D -filename "tmp.csv" -overwrite\n')
	yv=np.arange(ymin,ymax,dy)
	field2d=np.array([0,0,0])
	for y in yv:
		replace_line("svisual_2DtoCSV.tcl",1,'set ycut '+str("{:.1f}".format(y))+'\n')
		while os.path.exists('tmp.csv') == False:
			os.system('svisual -bx svisual_2DtoCSV.tcl')
		# read tmp.csv
		field , x = np.genfromtxt('tmp.csv', delimiter=',',skip_header=2,unpack=True)	
		data=np.column_stack((np.column_stack((np.ones(x.shape)*y,x)),field))
		field2d=np.row_stack((field2d,data))
		os.system('rm tmp.csv')	
	
	np.savetxt(outCSV,field2d[1:],delimiter=',')
	os.system('rm *.log')	
	os.system('rm *.BAK')	

# ------------------------------
# Inputs
inTDR='../plts/PreDrain_des.tdr'
ymin=9.8
ymax=14.8
dy=0.1
# ------------------------------------------------
outCSV='../out_svisual/init_2D_ElectrostaticPotential.csv'
field2csv(inTDR,'ElectrostaticPotential',outCSV,ymin,ymax,dy)
# ------------------------------------------------
outCSV='../out_svisual/init_2D_eDensity.csv'
field2csv(inTDR,'eDensity',outCSV,ymin,ymax,dy)
# ------------------------------------------------
outCSV='../out_svisual/init_2D_hDensity.csv'
field2csv(inTDR,'hDensity',outCSV,ymin,ymax,dy)

