## Load TDR file.
#set mydata2D [load_file plts/init_SiSeRO_des.tdr]
#
#set myplot2D [create_plot -dataset $mydata2D]
#
#set mydata1D [create_cutline -plot $myplot2D -type y -at 12.4]
#list_variables -dataset $mydata1D
#
#export_variables {ElectrostaticPotential xMoleFraction X} -dataset $mydata1D -filename "out_svisual/ElectrostaticPotential.csv" -overwrite
#export_variables {ElectricField xMoleFraction X} -dataset $mydata1D -filename "out_svisual/ElectricField.csv" -overwrite
#export_variables {AcceptorConcentration xMoleFraction X} -dataset $mydata1D -filename "out_svisual/AcceptorConcentration.csv" -overwrite
#export_variables {DonorConcentration xMoleFraction X} -dataset $mydata1D -filename "out_svisual/DonorConcentration.csv" -overwrite
#export_variables {DopingConcentration xMoleFraction X} -dataset $mydata1D -filename "out_svisual/DopingConcentration.csv" -overwrite
##export_variables {DopingWells xMoleFraction X} -dataset $mydata1D -filename "out_svisual/DopingWells.csv" -overwrite
#export_variables {eDensity xMoleFraction X} -dataset $mydata1D -filename "out_svisual/eDensity.csv" -overwrite
#export_variables {hDensity xMoleFraction X} -dataset $mydata1D -filename "out_svisual/hDensity.csv" -overwrite
#export_variables {SpaceCharge xMoleFraction X} -dataset $mydata1D -filename "out_svisual/SpaceCharge.csv" -overwrite
##export_variables {QuasiFermiPotential xMoleFraction X} -dataset $mydata1D -filename "out_svisual/QuasiFermiPotential.csv" -overwrite
##export_variables {ConductionBandEnergy xMoleFraction X} -dataset $mydata1D -filename "out_svisual/ConductionBandEnergy.csv" -overwrite
##export_variables {ValenceBandEnergy xMoleFraction X} -dataset $mydata1D -filename "out_svisual/ValenceBandEnergy.csv" -overwrite
#export_variables {eQuasiFermiPotential xMoleFraction X} -dataset $mydata1D -filename "out_svisual/eQuasiFermiPotential.csv" -overwrite
#export_variables {hQuasiFermiPotential xMoleFraction X} -dataset $mydata1D -filename "out_svisual/hQuasiFermiPotential.csv" -overwrite
#
# Curves
set mydata [load_file ../currents/SiSeRO_TC_des.plt]
export_variables -dataset $mydata -filename "../out_svisual/pmos_TC_iv.csv" -overwrite
