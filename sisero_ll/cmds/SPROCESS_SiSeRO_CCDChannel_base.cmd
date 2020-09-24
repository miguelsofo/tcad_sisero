#Please see SiSeRO_PMOSFET channel for more complete notes

AdvancedCalibration
SetTDRList "DopingConcentration"

#left is drain side
set	lef	0.0
set	rig	26.0

#implants
set	SCP_L		23.95
set	SCP_R		26.00
set	SDI_L		15.65
set	SDI_R		19.95
set	DEP_L		 9.85
set	DEP_R		11.95
set	TRGH_L		 0.00
set	TRGH_R		16.45
set	BCIM_L		 0.00
set	BCIM_R		16.45
set	CSTP_L		20.95
set	CSTP_R		22.95

#metal and poly deps
set	S2_L		 0.00
set	S2_R		 3.50
set	SW_L		 3.65
set	SW_R		 6.65
set	OG_L		 6.80
set	OG_R		 9.75
set	G_L		 9.90
set	G_R		11.90
set	RG_L		12.05
set	RG_R		15.55
set	RD_L		15.65
set	RD_R		20.45

#contacts
#set	CON_BCIM_L	
#set	CON_BCIM_R	
set	CON_RD_L_L	16.15
set	CON_RD_L_R	17.05
set	CON_RD_R_L	18.55
set	CON_RD_R_R	19.45

#set	CON_BCIM_DEP	0.25

#VMesh
line x	location= 0.00	spacing= 15<nm>		tag=SiTop
line x	location= 0.05	spacing= 25<nm>
line x	location= 0.25	spacing= 50<nm>
line x	location= 0.50	spacing= 100<nm>
line x	location= 1.00	spacing= 250<nm>
line x	location= 20.00	spacing= 250<nm>	tag=SiBot
#line x	location= 12.50	spacing= 0.25
#line x	location= 13.00	spacing= 0.50
#line x	location= 20.00	spacing= 1.00
#line x  location= 25.00	spacing= 1.00	tag=SiBot


#HMesh
line y	location=$lef	spacing= 200<nm>	tag=SiLef
line y	location=$rig	spacing= 200<nm>	tag=SiRig

#set Simulation domain
region Silicon	xlo=SiTop	xhi=SiBot	ylo=SiLef	yhi=SiRig

#initialize the region
init	resistivity=5000	field=Boron	wafer.orient=100

#setup remeshing strategy
grid	set.min.normal.size= 3<nm>	set.normal.growth.ratio.2d= 1.4

pdbSet	grid	adaptive	1
pdbSet	grid	AdaptiveField	Refine.Rel.Error	0.50


#polygon name=BCIM_contact	min= {$CON_BCIM_DEP-0.01 $CON_BCIM_L}	max= {$CON_BCIM_DEP+0.01  $CON_BCIM_R}	rectangle xy
#mater	add	name=Silicon2	new.like=Silicon	alt.matername=Silicon
#insert polygon=BCIM_contact	new.region=BCIM_region		new.material=Silicon2


#build masks.  *NOTE* masked region isn't processed
#	So here, the region that is INSIDE of the mask it the region that DOESNOT get etched is the region that DOES NOT get doped


#masks for doping degined here
#deposit a 4um oxide screen, then dope 
#for photo, mask where implant will be
mask clear
mask	name=CSTP	left=$CSTP_L	right=$CSTP_R
mask	name=SCP	left=$SCP_L	right=$SCP_R
mask	name=SDI	left=$SDI_L	right=$SDI_R
mask	name=BCIM	left=$BCIM_L	right=$BCIM_R
mask	name=TRGH	left=$TRGH_L	right=$TRGH_R
mask	name=DEP	left=$DEP_L	right=$DEP_R
mask	name=BUR	left=$DEP_L	right=$DEP_R

#mask for poly contact deposit	GATE
mask	name=GATE_POLY		left=$S2_L	right=$S2_R
mask	name=GATE_POLY		left=$SW_L	right=$SW_R
mask	name=GATE_POLY		left=$OG_L	right=$OG_R
mask	name=GATE_POLY		left=$G_L	right=$G_R
mask	name=GATE_POLY		left=$RG_L	right=$RG_R
mask	name=RESET_METAL	left=$RD_L	right=$RD_R
#mask	name=S2_POLY		left=$S2_L	right=$S2_R
#mask	name=SW_POLY		left=$SW_L	right=$SW_R
#mask	name=OG_POLY		left=$OG_L	right=$OG_R
#mask	name=GATE_POLY		left=$G_L	right=$G_R
#mask	name=RESET_POLY		left=$RG_L	right=$RG_R
#mask	name=RESET_METAL	left=$RD_L	right=$RD_R

#mask for SD contact etch
mask	name=CON_ETCH	left=$CON_RD_L_L	right=$CON_RD_L_R
mask	name=CON_ETCH	left=$CON_RD_R_L	right=$CON_RD_R_R

#deposit EGO stack
deposit	oxide	type=isotropic	thickness=0.030
deposit nitride	type=isotropic	thickness=0.014
deposit oxide	type=isotropic	thickness=0.006

#############
#implant SCP#
#############
photo	mask=SCP		thickness=1.0
implant	energy= 150<keV>	dose= 1.0e14	tilt=7.00<degree>	rotation=27.00<degree>		Phosphorus	beam.dose
strip	photoresist

###############
#implant CSTP#
###############
photo	mask=CSTP	thickness=1.0
implant	energy= 100<keV>	dose=7.0e12	tilt=7.00<degree>	rotation=27.00<degree>		Boron		beam.dose
strip	photoresist

###############
#implant SUBIM#
###############
photo	mask=SDI	thickness=1.0
implant	energy= 70<keV>		dose=5.0e15	tilt=7.00<degree>	rotation=27.00<degree>		Phosphorus		beam.dose
strip	photoresist

##############
#implant BCIM#
##############
photo	mask=BCIM	thickness=1.0
implant	energy= 100<keV>	dose=1.3e12	tilt=7.00<degree>	rotation=27.00<degree>		Phosphorus	beam.dose
strip	photoresist

##############
#implant TRGH#
##############
photo	mask=TRGH	thickness=1.0
implant	energy= 150<keV>	dose=4.0e11	tilt=7.00<degree>	rotation=27.00<degree>		Phosphorus		beam.dose
strip	photoresist

#############
#implant DEP#
#############
photo	mask=DEP	thickness=1.0
implant	energy= 180<keV>	dose=2.4e12	tilt=7.00<degree>	rotation=27.00<degree>		Phosphorus		beam.dose
strip	photoresist


######
#implant extra shallow BCIM reinforcement to bury the emerging p channel
######
photo	mask=BUR	thickness=1.0
implant	energy=	25<keV>	dose=5.0e12	tilt=7.0<degree>	rotation=27.00<degree>	Boron	beam.dose
strip	photoresist

struct tdr=POST_IMP_mesh

transform	flip
etch	silicon	type=isotropic	thickness=15
transform	flip

struct tdr=POST_THIN_mesh

###########################################
#GATE Deposit and implant for conductivity#
###########################################
deposit	poly	type=isotropic	thickness=0.50
implant energy= 40<keV>		dose=5.0e15	tilt=7.00<degree>	rotation=27.00<degree>		Arsenic		beam.dose
etch poly	type=anisotropic	thickness=0.51	mask=GATE_POLY

######################################
#Poly1Gap implant to suppress pockets#
######################################
implant energy=35<keV> dose=8.0e11	tilt=7.0<degree>	rotation=27.00<degree>	Boron	beam.dose




################
#Initial anneal#
################
diffuse	temperature= 900<C>	time=20<min>

###############
#Metal Deposit#
###############
mask	name=CON_ETCH		negative
mask	name=RESET_METAL	negative

etch	oxide		type=anisotropic	thickness=0.05	mask=CON_ETCH
etch	nitride		type=anisotropic	thickness=0.05	mask=CON_ETCH
etch	oxide		type=anisotropic	thickness=0.05	mask=CON_ETCH
deposit aluminum	type=anisotropic	thickness=0.50	mask=RESET_METAL

##################
#Deposit/label Contacts#
set	bu		0.1

contact name=reset_drain	aluminum	xlo=-0.5-$bu	xhi=-0.6+$bu	ylo=$RD_L+$bu	yhi=$RD_R-$bu	box	add
contact	name=reset_gate		poly		xlo=-0.5-$bu	xhi=-0.6+$bu	ylo=$RG_L+$bu	yhi=$RG_R-$bu	box	add
contact name=gate		poly		xlo=-0.5-$bu	xhi=-0.6+$bu	ylo=$G_L+$bu	yhi=$G_R-$bu	box	add
contact name=output_gate	poly		xlo=-0.5-$bu	xhi=-0.6+$bu	ylo=$OG_L+$bu	yhi=$OG_R-$bu	box	add
contact name=summing_well	poly		xlo=-0.5-$bu	xhi=-0.6+$bu	ylo=$SW_L+$bu	yhi=$SW_R-$bu	box	add
contact	name=serial_2		poly		xlo=-0.5-$bu	xhi=-0.6+$bu	ylo=$S2_L+$bu	yhi=$S2_R-$bu	box	add
contact name=substrate		silicon		xlo=5-$bu	xhi=5+$bu	ylo=$lef+$bu	yhi=$rig-$bu	box	add

#contact	name=chargeflow	silicon		xlo=$CON_BCIM_DEP-$bu	xhi=$CON_BCIM_DEP+$bu	ylo=$CON_BCIM_L-$bu	yhi=$CON_BCIM_R+$bu	box	add
#Refine mesh, save again to compare mesh evolution

#maximum change in doping concentration of 0.01 orders of magnitude (e.g 100 allows from 

struct tdr=Loadable

grid remesh

refinebox clear
line clear
grid set.Delaunay.type= boxmethod
refinebox Adaptive refine.fields= NetActive max.asinhdiff= {NetActive= 0.45}	refine.min.edge=1.0<nm>	refine.max.edge=50<nm>	Silicon
#refinebox Adaptive refine.fields= NetActive max.asinhdiff= {NetActive= 0.50}	refine.max.edge=50<nm>	Silicon2
refinebox min= {5.0 0.0}	max= {20.0 26.0}	xrefine= {0.100 0.100 0.100} 	yrefine= {0.100 0.100 0.100}	Silicon
#refinebox min= {0.0 10.1}	max= {0.3 14.5}		xrefine= {0.010 0.010 0.010} 	yrefine= {0.010 0.010 0.010}	Silicon2

grid remesh

struct tdr=Full_remesh !Gas
