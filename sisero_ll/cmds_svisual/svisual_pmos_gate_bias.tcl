set infile ../savs/Vgs_1.50_des.tdr
set eD_png ../out_svisual/Vgs_1.50_eDensity.png
set hD_png ../out_svisual/Vgs_1.50_hDensity.png
set EP_png ../out_svisual/Vgs_1.50_EP.png
set outh "../out_svisual/Vgs_1.50_hDensity.csv"
set oute "../out_svisual/Vgs_1.50_eDensity.csv"
set toti "../out_svisual/Vgs_1.50_TotalCurrentDensity.csv"
set ycut 12.3

# Load TDR file.
set mydata2D [load_file $infile]

set myplot2D [create_plot -dataset $mydata2D]
list_fields -plot $myplot2D

set_field_prop -plot $myplot2D -geom $mydata2D eDensity -show_bands
zoom_plot -plot $myplot2D -window {-1 10 0.1 15}
export_view $eD_png -plots $myplot2D -format png -overwrite

set_field_prop -plot $myplot2D -geom $mydata2D hDensity -show_bands
zoom_plot -plot $myplot2D -window {-1 10 0.1 15}
export_view $hD_png -plots $myplot2D -format png -overwrite

set_field_prop -plot $myplot2D -geom $mydata2D ElectrostaticPotential -show_bands
zoom_plot -plot $myplot2D -window {-1 10 0.1 15}
export_view $EP_png -plots $myplot2D -format png -overwrite

set mydata1D [create_cutline -plot $myplot2D -type y -at $ycut]
export_variables {hDensity xMoleFraction X} -dataset $mydata1D -filename $outh -overwrite
export_variables {eDensity xMoleFraction X} -dataset $mydata1D -filename $oute -overwrite
export_variables {TotalCurrentDensity xMoleFraction X} -dataset $mydata1D -filename $toti -overwrite
