set infile ../plts/PreDrain_des.tdr
set ycut 10.3

set mydata2D [load_file ../plts/Initialized_DC_des.tdr]
set myplot2D [create_plot -dataset $mydata2D]
set mydata1D [create_cutline -plot $myplot2D -type y -at $ycut]
export_variables {ElectrostaticPotential xMoleFraction X} -dataset $mydata1D -filename "tmp.csv" -overwrite
export_variables {ElectrostaticPotential xMoleFraction X} -dataset $mydata1D -filename "tmp.csv" -overwrite

