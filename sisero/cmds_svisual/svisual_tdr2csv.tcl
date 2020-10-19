set infile ../plts/PreDrain_des.tdr
set ycut 14.8

set mydata2D [load_file $infile]
set myplot2D [create_plot -dataset $mydata2D]
set mydata1D [create_cutline -plot $myplot2D -type y -at $ycut]
export_variables {hQuasiFermiPotential eQuasiFermiPotential AcceptorConcentration DonorConcentration DopingConcentration ElectricField ElectrostaticPotential SpaceCharge TotalCurrentDensity eCurrentDensity eDensity hCurrentDensity hDensity xMoleFraction X} -dataset $mydata1D -filename "tmp.csv" -overwrite
