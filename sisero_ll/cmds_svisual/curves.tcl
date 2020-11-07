set infile ../currents/SiSeRO_des.plt
set outfile  ../out_svisual/SiSeRO_des.plt.csv

set mydata [load_file $infile]
export_variables -dataset $mydata -filename $outfile -overwrite
