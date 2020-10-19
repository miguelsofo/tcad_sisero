# Load TDR file.
#set mydata2D [load_file ../plts/PreDrain_des.tdr]
set mydata2D [load_file ../sisero_biased/Vgs_1.50_des.tdr]

set myplot2D [create_plot -dataset $mydata2D]
list_fields -plot $myplot2D

# -------------------
# 2D plots
set_field_prop -plot $myplot2D -geom $mydata2D eDensity -show_bands
zoom_plot -plot $myplot2D -window {-1 10 0.1 15}
export_view ../out_svisual/init_eDensity.png -plots $myplot2D -format png -overwrite

set_field_prop -plot $myplot2D -geom $mydata2D hDensity -show_bands
zoom_plot -plot $myplot2D -window {-1 10 0.1 15}
export_view ../out_svisual/init_hDensity.png -plots $myplot2D -format png -overwrite

set_field_prop -plot $myplot2D -geom $mydata2D ElectrostaticPotential -show_bands
zoom_plot -plot $myplot2D -window {-1 10 0.1 15}
export_view ../out_svisual/init_ElectrostaticPotential.png -plots $myplot2D -format png -overwrite

set mydata1D [create_cutline -plot $myplot2D -type y -at 12.4]
list_variables -dataset $mydata1D

export_variables {ElectrostaticPotential xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/init_ElectrostaticPotential.csv" -overwrite
export_variables {ElectricField xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/init_ElectricField.csv" -overwrite
export_variables {AcceptorConcentration xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/init_AcceptorConcentration.csv" -overwrite
export_variables {DonorConcentration xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/init_DonorConcentration.csv" -overwrite
export_variables {DopingConcentration xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/init_DopingConcentration.csv" -overwrite
export_variables {DopingWells xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/DopingWells.csv" -overwrite
export_variables {eDensity xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/init_eDensity.csv" -overwrite
export_variables {hDensity xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/init_hDensity.csv" -overwrite
export_variables {SpaceCharge xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/init_SpaceCharge.csv" -overwrite
#export_variables {QuasiFermiPotential xMoleFraction X} -dataset $mydata1D -filename "out_svisual/QuasiFermiPotential.csv" -overwrite
#export_variables {ConductionBandEnergy xMoleFraction X} -dataset $mydata1D -filename "out_svisual/ConductionBandEnergy.csv" -overwrite
#export_variables {ValenceBandEnergy xMoleFraction X} -dataset $mydata1D -filename "out_svisual/ValenceBandEnergy.csv" -overwrite
export_variables {eQuasiFermiPotential xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/init_eQuasiFermiPotential.csv" -overwrite
export_variables {hQuasiFermiPotential xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/init_hQuasiFermiPotential.csv" -overwrite
#
# Curves
set mydata [load_file ../currents/init_SiSeRO_des.plt]
export_variables -dataset $mydata -filename "../out_svisual/pmos_init_iv.csv" -overwrite
