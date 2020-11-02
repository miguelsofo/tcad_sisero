# Reference
set mydata2D [load_file ../plts/PreDrain_des.tdr]
set myplot2D [create_plot -dataset $mydata2D]
integrate_field -plot $myplot2D -field eDensity -geom $mydata2D -window {0.1 11.9 0.7 12.7}
integrate_field -plot $myplot2D -field eDensity -geom $mydata2D -window {0.1 11.3 0.7 13.3}

set mydata2D [load_file ../plts/PreDrain_qf1.0_des.tdr]
set myplot2D [create_plot -dataset $mydata2D]
integrate_field -plot $myplot2D -field eDensity -geom $mydata2D -window {0.1 11.9 0.7 12.7}
integrate_field -plot $myplot2D -field eDensity -geom $mydata2D -window {0.1 11.3 0.7 13.3}

set mydata2D [load_file ../plts/PreDrain_qf1.0_des.tdr]
set myplot2D [create_plot -dataset $mydata2D]
integrate_field -plot $myplot2D -field eDensity -geom $mydata2D -window {0.1 11.9 0.7 12.7}
integrate_field -plot $myplot2D -field eDensity -geom $mydata2D -window {0.1 11.3 0.7 13.3}

set mydata2D [load_file ../sisero_biased/Vgs_1.50_des.tdr]
set myplot2D [create_plot -dataset $mydata2D]
integrate_field -plot $myplot2D -field eDensity -geom $mydata2D -window {0.1 11.9 0.7 12.7}
integrate_field -plot $myplot2D -field eDensity -geom $mydata2D -window {0.1 11.3 0.7 13.3}
