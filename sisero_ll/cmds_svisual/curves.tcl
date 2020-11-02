#set infile "../currents/SiSeRO_TC_des.plt"
#set outfile "../out_svisual/SiSeRO_TC_des.csv"

set infile "../currents/sens_Vgs_0.65.plt"
set outfile "../out_svisual/sens_Vgs_0.65.csv"

set mydata [load_file $infile]
export_variables -dataset $mydata -filename $outfile -overwrite
