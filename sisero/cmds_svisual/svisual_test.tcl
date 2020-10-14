set infile ../plts/Filled_des.tdr
set ycut 13.9

set mydata2D [load_file $infile]
set myplot2D [create_plot -dataset $mydata2D]
set mydata1D [create_cutline -plot $myplot2D -type y -at $ycut]
#export_variables {AcceptorConcentration DonorConcentration DopingConcentration ElectricField ElectrostaticPotential SpaceCharge TotalCurrentDensity eCurrentDensity eDensity hCurrentDensity hDensity xMoleFraction X} -dataset $mydata1D -filename "tmp2.csv" -overwrite
export_variables {AcceptorConcentration DonorConcentration DopingConcentration ElectricField ElectrostaticPotential SpaceCharge TotalCurrentDensity eCurrentDensity eDensity hCurrentDensity hDensity} -dataset $mydata2D -filename "tmp2.csv" -overwrite
