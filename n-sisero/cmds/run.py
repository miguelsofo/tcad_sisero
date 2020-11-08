import os
#os.system('python clean.py')

# -------------------------------------------
# SiSeRO Amplifier

os.system('sprocess -b SPROCESS_SiSeRO_NMOS_base.cmd')
os.system('cp Loadable_fps.tdr ../structure/SiSeRO_msh.tdr')
os.system('sdevice SDEVICE_Init_DC.cmd') 		# Init the device
os.system('python run_SDEVICE_gate_bias.py') 		# Gate bias 
#os.system('sdevice SDEVICE_Gate_bias.cmd') 		# Gate bias 
#os.system('sdevice SDEVICE_TC_des.cmd') 		 
#os.system('sdevice SDEVICE_Sensitivity.cmd') 		 

# -------------------------------------------
# CCD
#os.system('sprocess -b SPROCESS_SiSeRO_CCDChannel_base.cmd')
