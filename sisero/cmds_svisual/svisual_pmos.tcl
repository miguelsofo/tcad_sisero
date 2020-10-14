# Load TDR file.
set mydata2D [load_file ../structure/SiSeRO_msh.tdr]

# Create new plot:
set myplot2D [create_plot -dataset $mydata2D]
export_view ../out_svisual/sisero_pmos.png -plots $myplot2D -format png -overwrite 

list_regions -plot $myplot2D
list_materials -plot $myplot2D
list_rectangles -plot $myplot2D

# Boron implants:
list_fields -plot $myplot2D
set_field_prop -plot $myplot2D -geom $mydata2D Boron -show_bands
export_view ../out_svisual/sisero_pmos_boron.png -plots $myplot2D -format png -overwrite

# Phosphorus implants:
list_fields -plot $myplot2D
set_field_prop -plot $myplot2D -geom $mydata2D Phosphorus -show_bands
export_view ../out_svisual/sisero_pmos_phos.png -plots $myplot2D -format png -overwrite

# Boron implant:
set mydata1D [create_cutline -plot $myplot2D -type y -at 12.5]
list_variables -dataset $mydata1D
export_variables {Boron xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/Boron1.csv" -overwrite

set mydata1D [create_cutline -plot $myplot2D -type y -at 17.5]
list_variables -dataset $mydata1D
export_variables {Boron xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/Boron2.csv" -overwrite

# Phosphorus implant:
set mydata1D [create_cutline -plot $myplot2D -type y -at 12.5]
list_variables -dataset $mydata1D
export_variables {Phosphorus xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/Phosphorus1.csv" -overwrite

set mydata1D [create_cutline -plot $myplot2D -type y -at 1.0]
list_variables -dataset $mydata1D
export_variables {Phosphorus xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/Phosphorus2.csv" -overwrite

