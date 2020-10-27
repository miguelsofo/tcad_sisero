set infile ../plts/Vgs_1.00_qf3.7_des.tdr
set eD_png ../out_svisual/Vgs_1.00_qf3.7_des.tdr_eDensity.png
set eQF_png ../out_svisual/Vgs_1.00_qf3.7_des.tdr_eQF.png
set hD_png ../out_svisual/Vgs_1.00_qf3.7_des.tdr_hDensity.png
set EP_png ../out_svisual/Vgs_1.00_qf3.7_des.tdr_EP.png
set out_csv "../out_svisual/Vgs_1.00_qf3.7_des.tdr.csv"

set ycut 12.3
set mydata2D [load_file $infile]
set myplot2D [create_plot -dataset $mydata2D]
list_fields -plot $myplot2D

set_field_prop -plot $myplot2D -geom $mydata2D eDensity -show_bands
zoom_plot -plot $myplot2D -window {-1 10 2.0 15}
export_view $eD_png -plots $myplot2D -format png -overwrite

set_field_prop -plot $myplot2D -geom $mydata2D hDensity -show_bands
zoom_plot -plot $myplot2D -window {-1 10 2.0 15}
export_view $hD_png -plots $myplot2D -format png -overwrite

set_field_prop -plot $myplot2D -geom $mydata2D ElectrostaticPotential -show_bands
zoom_plot -plot $myplot2D -window {-1 10 2.0 15}
export_view $EP_png -plots $myplot2D -format png -overwrite

set_field_prop -plot $myplot2D -geom $mydata2D eQuasiFermiPotential -show_bands
zoom_plot -plot $myplot2D -window {-1 10 2.0 15}
export_view $eQF_png -plots $myplot2D -format png -overwrite

set mydata1D [create_cutline -plot $myplot2D -type y -at $ycut]
export_variables {DopingWells hQuasiFermiPotential eQuasiFermiPotential AcceptorConcentration DonorConcentration DopingConcentration ElectricField ElectrostaticPotential SpaceCharge TotalCurrentDensity eCurrentDensity eDensity hCurrentDensity hDensity xMoleFraction X} -dataset $mydata1D -filename $out_csv -overwrite

#integrate_field -plot $myplot2D -field eDensity -geom $mydata2D -window {0.1 11.9 0.7 12.7}
integrate_field -plot $myplot2D -field eDensity -geom $mydata2D -window {0.1 11.3 0.7 13.3}

