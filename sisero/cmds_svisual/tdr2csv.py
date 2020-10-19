import os
import csv
import numpy as np

def replace_line(file_name, line_num, text):
    lines = open(file_name, 'r').readlines()
    lines[line_num] = text
    out = open(file_name, 'w')
    out.writelines(lines)
    out.close()

def field2csv(inTDR,outCSV,ymin,ymax,dy):
	replace_line("svisual_tdr2csv.tcl",0,'set infile '+inTDR+'\n')
	yv=np.arange(ymin,ymax+dy,dy)
	field2d=np.empty((0,15))
	# ---------------------------
	for y in yv:
		os.system('rm tmp.csv')	
		replace_line("svisual_tdr2csv.tcl",1,'set ycut '+str("{:.1f}".format(y))+'\n')
		while os.path.exists('tmp.csv') == False: # check if svisual was able to produce the file, if not, it continues trying
			os.system('svisual -bx svisual_tdr2csv.tcl')
		# read tmp.csv
		data = np.genfromtxt('tmp.csv', delimiter=',',skip_header=2,unpack=True)	
		data = np.transpose(data)
		data = np.column_stack((data,np.ones(data[:,-1].size)*y))
		field2d=np.row_stack((field2d,data))

	np.savetxt(outCSV,field2d,delimiter=',')
	os.system('rm *.log')	
	os.system('rm *.BAK')	
	os.system('rm tmp.csv')	

# ------------------------------
# Inputs
ymin=9.8
ymax=14.8
#
#ymin=12.0
#ymax=12.6
#
dy=0.1
# ------------------------------------------------
# Init:
field2csv('../plts/PreDrain_des.tdr','../out_svisual/PreDrain_des.csv',ymin,ymax,dy)

#field2csv('../plts/pre_eqf_1.0_des.tdr','../out_svisual/pre_eqf_1.0_des.csv',ymin,ymax,dy)
#field2csv('../plts/eqf_1.0_des.tdr','../out_svisual/eqf_1.0_des.csv',ymin,ymax,dy)

#field2csv('../plts/pre_eqf_1.5_des.tdr','../out_svisual/pre_eqf_1.5_des.csv',ymin,ymax,dy)
#
#field2csv('../plts/pre_eqf_2.0_des.tdr','../out_svisual/pre_eqf_2.0_des.csv',ymin,ymax,dy)
#field2csv('../plts/eqf_2.0_des.tdr','../out_svisual/eqf_2.0_des.csv',ymin,ymax,dy)
#
#field2csv('../plts/pre_eqf_5.0_des.tdr','../out_svisual/pre_eqf_5.0_des.csv',ymin,ymax,dy)
#field2csv('../plts/eqf_5.0_des.tdr','../out_svisual/eqf_5.0_des.csv',ymin,ymax,dy)
#
#field2csv('../plts/pre_eqf_10.0_des.tdr','../out_svisual/pre_eqf_10.0_des.csv',ymin,ymax,dy)
#field2csv('../plts/eqf_10.0_des.tdr','../out_svisual/eqf_10.0_des.csv',ymin,ymax,dy)

#field2csv('../plts/pre_eqf_50.0_des.tdr','../out_svisual/pre_eqf_50.0_des.csv',ymin,ymax,dy)
#field2csv('../plts/eqf_50.0_des.tdr','../out_svisual/eqf_50.0_des.csv',ymin,ymax,dy)

#field2csv('../plts/Drained_des.tdr','../out_svisual/Drained_des.csv',ymin,ymax,dy)
#field2csv('../plts/Initialized_DC_des.tdr','../out_svisual/Initialized_DC_des.csv',ymin,ymax,dy)

# ------------------------------------------------
# Filled:
#field2csv('../plts/Filled_des.tdr','../out_svisual/filled.csv',ymin,ymax,dy)
