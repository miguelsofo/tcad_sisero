import os
os.system('python clean.py')

# -------------------------------------------
# SiSeRO transistor
os.system('sprocess -b SPROCESS_SiSeRO_PMOS_base.cmd')
os.system('sdevice SDEVICE_Init_DC.cmd')
os.system('sdevice SDEVICE_Gate_bias.cmd')
os.system('sdevice SDEVICE_Sensitivity.cmd')

# -------------------------------------------
# CCD
#os.system('sprocess -b SPROCESS_SiSeRO_CCDChannel_base.cmd')
