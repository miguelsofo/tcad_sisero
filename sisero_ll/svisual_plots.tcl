# Load TDR file.
set mydata2D [load_file structure/SiSeRO_msh.tdr]

# Create new plot.
set myplot2D [create_plot -dataset $mydata2D]
export_view out_svisual/sisero_pmos.png -plots $myplot2D -format png -overwrite 

# Front-side detail
list_fields -plot $myplot2D
set_field_prop -plot $myplot2D -geom $mydata2D Boron -show_bands
set_axis_prop -axis x -min -1.0 -max 1.5 y
export_view out_svisual/sisero_pmos.png -plots $myplot2D -format png -overwrite

## Display the mesh
##list_materials -plot $myplot2D
##set_material_prop {Contact DepletionRegion JunctionLine SiO2 Silicon} -show_mesh
#set_material_prop [list_materials -plot $myplot2D] -show_mesh
#
## oxide detail
#set_axis_prop -axis y -min -0.1 -max 0.1
#export_view out_svisual/ccd_phase_oxide.png -plots $myplot2D -format png -overwrite
#
## Channel detail
#set_axis_prop -axis y -min -0.1 -max 0.8
#export_view out_svisual/ccd_channel.png -plots $myplot2D -format png -overwrite
#
## Back-side detail
#set_axis_prop -axis y -min 198 -max 202
#export_view out_svisual/ccd_phase_back.png -plots $myplot2D -format png -overwrite
#
## Create 1D cutline normal to x-axis at point 25.
#set mydata1D [create_cutline -plot $myplot2D -type x -at 7.5]
#list_variables -dataset $mydata1D
#export_variables {ElectricField-Y xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/ElectricField.csv" -overwrite
#export_variables {ElectrostaticPotential xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/ElectrostaticPotential.csv" -overwrite
#export_variables {AcceptorConcentration xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/AcceptorConcentration.csv" -overwrite
#export_variables {DonorConcentration xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/DonorConcentration.csv" -overwrite
#export_variables {DopingConcentration xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/DopingConcentration.csv" -overwrite
#export_variables {DopingWells xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/DopingWells.csv" -overwrite
#export_variables {eDensity xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/eDensity.csv" -overwrite
#export_variables {hDensity xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/hDensity.csv" -overwrite
#export_variables {SpaceCharge xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/SpaceCharge.csv" -overwrite
#export_variables {QuasiFermiPotential xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/QuasiFermiPotential.csv" -overwrite
#export_variables {ConductionBandEnergy xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/ConductionBandEnergy.csv" -overwrite
#export_variables {ValenceBandEnergy xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/ValenceBandEnergy.csv" -overwrite
#export_variables {eQuasiFermiPotential xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/eQuasiFermiPotential.csv" -overwrite
#export_variables {hQuasiFermiPotential xMoleFraction Y} -dataset $mydata1D -filename "out_svisual/hQuasiFermiPotential.csv" -overwrite
#
