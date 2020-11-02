# Load TDR file.
#set mydata2D [load_file ../structure/SiSeRO_msh.tdr]
#set mydata2D [load_file ../cmds/Full_remesh_fps.tdr]
#set mydata2D [load_file ../cmds/Loadable_fps.tdr]
#set mydata2D [load_file ../cmds/beforeDEP_fps.tdr]
set mydata2D [load_file ../cmds/afterDEP_fps.tdr]


# Create new plot:
set myplot2D [create_plot -dataset $mydata2D]
export_view ../out_svisual/sisero_nmos.png -plots $myplot2D -format png -overwrite 

list_regions -plot $myplot2D
list_materials -plot $myplot2D
list_fields -plot $myplot2D

# Boron implants:
set_field_prop -plot $myplot2D -geom $mydata2D Boron -show_bands
export_view ../out_svisual/sisero_nmos_boron.png -plots $myplot2D -format png -overwrite

# Phosphorus implants:
set_field_prop -plot $myplot2D -geom $mydata2D Phosphorus -show_bands
export_view ../out_svisual/sisero_nmos_phos.png -plots $myplot2D -format png -overwrite

#zoom 
zoom_plot -plot $myplot2D -window {-1 10 2.0 15}

# Boron implants:
set_field_prop -plot $myplot2D -geom $mydata2D Boron -show_bands
export_view ../out_svisual/sisero_nmos_boron_zoom.png -plots $myplot2D -format png -overwrite

# Phosphorus implants:
set_field_prop -plot $myplot2D -geom $mydata2D Phosphorus -show_bands
export_view ../out_svisual/sisero_nmos_phos_zoom.png -plots $myplot2D -format png -overwrite

# Mesh details
set_material_prop [list_materials -plot $myplot2D] -show_mesh
set_field_prop -plot $myplot2D -geom $mydata2D Boron -show_bands
export_view ../out_svisual/sisero_nmos_boron_mesh.png -plots $myplot2D -format png -overwrite
zoom_plot -plot $myplot2D -window {-1 0 2.0 23}
export_view ../out_svisual/sisero_nmos_boron_mesh_2.png -plots $myplot2D -format png -overwrite

# Phosphorus implant:
set mydata1D [create_cutline -plot $myplot2D -type y -at 12.5]
list_variables -dataset $mydata1D
export_variables {Phosphorus xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/Phosphorus_afterDEP.csv" -overwrite

#set mydata1D [create_cutline -plot $myplot2D -type y -at 17.5]
#list_variables -dataset $mydata1D
#export_variables {Boron xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/Boron2.csv" -overwrite
#
## Phosphorus implant:
#set mydata1D [create_cutline -plot $myplot2D -type y -at 12.5]
#list_variables -dataset $mydata1D
#export_variables {Phosphorus xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/Phosphorus1.csv" -overwrite
#
#set mydata1D [create_cutline -plot $myplot2D -type y -at 1.0]
#list_variables -dataset $mydata1D
#export_variables {Phosphorus xMoleFraction X} -dataset $mydata1D -filename "../out_svisual/Phosphorus2.csv" -overwrite
#
