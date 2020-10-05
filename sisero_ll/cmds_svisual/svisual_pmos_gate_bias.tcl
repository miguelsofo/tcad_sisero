set infile Vgs_1.50_des.tdr
set outimg ../out_svisual/Vgs_1.50.png
set outh "../out_svisual/Vgs_1.50_hDensity.csv"
set oute "../out_svisual/Vgs_1.50_eDensity.csv"

# Load TDR file.
set mydata2D [load_file $infile]

set myplot2D [create_plot -dataset $mydata2D]
list_fields -plot $myplot2D

set_field_prop -plot $myplot2D -geom $mydata2D hDensity -show_bands
set_axis_prop -axis y -min 11.1 -max 13.5
set_axis_prop -axis x -min -0.1 -max 0.5
export_view $outimg -plots $myplot2D -format png -overwrite

set mydata1D [create_cutline -plot $myplot2D -type y -at 12.3]
export_variables {hDensity xMoleFraction X} -dataset $mydata1D -filename $outh -overwrite
export_variables {eDensity xMoleFraction X} -dataset $mydata1D -filename $oute -overwrite