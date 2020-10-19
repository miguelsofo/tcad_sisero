set infile "../currents/gb_sens_SiSeRO_des.plt"
set outfile "../out_svisual/Vgs_0.65_iv.csv"

set mydata [load_file $infile]
export_variables -dataset $mydata -filename $outfile -overwrite
