
AdvancedCalibration
SetTDRList "DopingConcentration"

#left is drain side
set	lef	0.0
set	rig	23.4

#implants
# naming begins with implant
#	next if applicable sets location of implant (L for Left, R for Right, C for centered, numbered if >3, absent if =1)
#	next indicates whether location is Left or Right boundry
#		(e.g.) SCP_L_R is the right boundry of the left most instance of the scupper mask
#		(e.g.) BCIM_L is the left boundry of the only instance of the buried channel mask

set	SCP_L_L		0.0
set	SCP_L_R		2.5
set	SCP_R_L		22.9
set	SCP_R_R		23.4
set	SUBIM_L_L	3.5
set	SUBIM_L_R	10.1
set	SUBIM_R_L	14.5
set	SUBIM_R_R	19.4
set	DEP_L		11.3
set	DEP_R		13.3
set	TRGH_L		11.9
set	TRGH_R		12.7
set	BCIM_L		11.1
set	BCIM_R		13.5

#metal and poly deps
# same convention as above but defines edges for conductor deposition
#	Note that this simulation doesn't build oxide prior to metal dep leaving the metal and poly co-planer
set	Dra_L		2.95
set	Dra_R		7.80
set	Sou_L		15.1
set	Sou_R		23.4
set	Gat_L		8.95
set	Gat_R		15.0

#contacts
# defines line regions for mask etches for Source and Drain
# BCIM establishes an internal contact that can be used for biasing the internal gate

set	CON_BCIM_L	$TRGH_L
set	CON_BCIM_R	$TRGH_R
set	CON_SOU_L	15.6
set	CON_SOU_R	18.9
set	CON_DRA_L	4.0
set	CON_DRA_R	7.8

set	CON_BCIM_DEP	0.15

#VMesh
line x	location= 0.00	spacing= 15<nm>		tag=SiTop
line x	location= 0.05	spacing= 25<nm>
line x	location= 0.25	spacing= 50<nm>
line x	location= 0.50	spacing= 100<nm>
line x	location= 1.00	spacing= 250<nm>
line x	location= 20.00	spacing= 250<nm>	tag=SiBot


#HMesh
line y	location=$lef	spacing= 200<nm>	tag=SiLef
line y	location=$rig	spacing= 200<nm>	tag=SiRig

#set Simulation domain
region Silicon	xlo=SiTop	xhi=SiBot	ylo=SiLef	yhi=SiRig

#initialize the region
init	resistivity=20000	field=Phosphorus wafer.orient=100

#setup remeshing strategy
grid	set.min.normal.size= 3<nm>	set.normal.growth.ratio.2d= 1.4
pdbSet	grid	adaptive	1
pdbSet	grid	AdaptiveField	Refine.Rel.Error	0.50

#Convert block for internal gate contact to alt-material named Silicon2 with all properties identical to silicon
#	Simulator requires a material boundry to define contacts; Si to Si2 forces a continious edge line at the defined rectangle
#		allowing for definition of contact
#		location is approximate and may not correspond exactly to the charge collection region;  adjust CON_BCIM pararmeters if needed
polygon name=BCIM_contact	min= {$CON_BCIM_DEP-0.01 $CON_BCIM_L}	max= {$CON_BCIM_DEP+0.01  $CON_BCIM_R}	rectangle xy
mater	add	name=Silicon2	new.like=Silicon	alt.matername=Silicon
insert polygon=BCIM_contact	new.region=BCIM_region		new.material=Silicon2


#build masks.  *NOTE* masked region isn't processed
#	So here, the region that is INSIDE of the mask it the region that DOES NOT get etched is the region that DOES NOT get doped
mask clear
#masks for doping degined here
#for photo, mask where implant will be
mask	name=SCP	left=$SCP_L_L	right=$SCP_L_R
mask	name=SCP	left=$SCP_R_L	right=$SCP_R_R
mask	name=SUBIM	left=$SUBIM_L_L	right=$SUBIM_L_R
mask	name=SUBIM	left=$SUBIM_R_L	right=$SUBIM_R_R
mask	name=BCIM	left=$BCIM_L	right=$BCIM_R
mask	name=TRGH	left=$TRGH_L	right=$TRGH_R
mask	name=DEP	left=$DEP_L	right=$DEP_R
mask	name=BUR	left=$SUBIM_L_R	right=$SUBIM_R_L

#mask for poly contact deposit	GATE
mask	name=GATE_POLY		left=$Gat_L	right=$Gat_R
mask	name=SOURCE_METAL	left=$Sou_L	right=$Sou_R
mask	name=DRAIN_METAL	left=$Dra_L	right=$Dra_R

#mask for SD contact etch
mask	name=CON_ETCH	left=$CON_SOU_L	right=$CON_SOU_R
mask	name=CON_ETCH	left=$CON_DRA_L	right=$CON_DRA_R

#deposit EGO stack
deposit	oxide	type=isotropic	thickness=0.05
deposit nitride	type=isotropic	thickness=0.05

#begin implants
#	7 tilt is our anti-tunneling condition
#	if beam.dose is not specified then dose is assumed to measured at surfaces (therefore beam dose is effectively scaled by 1/cos(tilt))
#	As written these implants are functional rather than simulated (fast but inaccurate)
#		Suggest appending one of the following to each line
#		sentaurus.mc	particles=N			#simple monte-carlo simulation; ideal N depends on meshing parameters, 10000 or greater is recommended
#		sentaurus.mc	particles=N	cascades	#more full fledged MC, takes longer to run but more accurate.  Examines cascading eventt
#		sentaurus.mc	particles=N	iBCA		#more complex cascade model, even longer to run but gives most accurate results.

#############
#implant SCP#
#############
photo	mask=SCP		thickness=1.0
#implant	energy= 150<keV>	dose= 1.0e14	tilt=7.00<degree>	rotation=0.00<degree>		Phosphorus	beam.dose
implant	energy= 150<keV>	dose= 1.0e14	tilt=7.00<degree>	rotation=0.00<degree>		Boron	beam.dose
strip	photoresist

###############
#implant SUBIM#
###############
photo	mask=SUBIM	thickness=1.0
#implant	energy= 40<keV>		dose=4.5e15	tilt=7.00<degree>	rotation=0.00<degree>		Boron		beam.dose
implant	energy= 40<keV>		dose=4.5e15	tilt=7.00<degree>	rotation=0.00<degree>		Phosphorus		beam.dose
strip	photoresist

##############
#implant BCIM#
##############
photo	mask=BCIM	thickness=1.0
#implant	energy= 100<keV>	dose=1.3e12	tilt=7.00<degree>	rotation=0.00<degree>		Phosphorus	beam.dose
implant	energy= 100<keV>	dose=1.3e12	tilt=7.00<degree>	rotation=0.00<degree>		Boron	beam.dose
strip	photoresist

##############
#implant TRGH#
##############
photo	mask=TRGH	thickness=1.0
#implant	energy= 150<keV>	dose=4.0e11	tilt=7.00<degree>	rotation=0.00<degree>		Phosphorus		beam.dose
implant	energy= 150<keV>	dose=4.0e11	tilt=7.00<degree>	rotation=0.00<degree>		Boron		beam.dose
strip	photoresist

struct tdr=beforeDEP

#############
#implant DEP#
#############
photo	mask=DEP	thickness=1.0
#implant	energy= 180<keV>	dose=2.4e12	tilt=7.00<degree>	rotation=0.00<degree>		Phosphorus		beam.dose
implant	energy= 180<keV>	dose=2.4e12	tilt=7.00<degree>	rotation=0.00<degree>		Boron		beam.dose
strip	photoresist

struct tdr=afterDEP

######
#implant extra shallow BCIM reinforcement to bury the emerging p channel: now called BCIM2
######
#photo	mask=BUR	thickness=1.0
#implant	energy=	25<keV>	dose=5.0e12	tilt=7.0<degree>	rotation=0.00<degree>	Boron	beam.dose
#strip	photoresist


#If desired, flips and thins the device to shrink electrical simualtion domain
#transform	flip
#etch 	silicon	type=isotropic	thickness=15
#transform	flip

################
#Initial anneal#
################
diffuse	temperature= 900<C>	time=20<min>


##############
#GATE Deposit#
##############
deposit	poly	type=isotropic	thickness=0.50
implant energy= 40<keV>		dose=5.0e15	tilt=7.00<degree>	rotation=0.00<degree>		Arsenic		beam.dose

#RTA for poly dope activation: not finalized conditions

#diffuse temperature= 1000<C>	time=30<sec>	N2

etch poly	type=anisotropic	thickness=0.51	mask=GATE_POLY

###############
#Metal Deposit#
###############
mask	name=CON_ETCH		negative
mask	name=SOURCE_METAL	negative
mask	name=DRAIN_METAL	negative

etch	nitride		type=anisotropic	thickness=0.05	mask=CON_ETCH
etch	oxide		type=anisotropic	thickness=0.05	mask=CON_ETCH
deposit	aluminum	type=anisotropic	thickness=0.50	mask=SOURCE_METAL
deposit aluminum	type=anisotropic	thickness=0.50	mask=DRAIN_METAL

##################
#Deposit/label Contacts#
#bu is an edge buffer
set	bu		0.1

contact name=source	aluminum	xlo=-0.5-$bu	xhi=-0.6+$bu	ylo=$Sou_L+$bu		yhi=$Sou_R-$bu		box	add
contact name=drain	aluminum	xlo=-0.5-$bu	xhi=-0.6+$bu	ylo=$Dra_L+$bu		yhi=$Dra_R-$bu		box	add
contact name=gate	poly		xlo=-0.5-$bu	xhi=-0.6+$bu	ylo=$Gat_L+$bu		yhi=$Gat_R-$bu		box	add
contact	name=chargeflow	silicon		xlo=$CON_BCIM_DEP-$bu	xhi=$CON_BCIM_DEP+$bu	ylo=$CON_BCIM_L-$bu	yhi=$CON_BCIM_R+$bu	box	add
#contact	name=substrate	silicon		xlo=5.0-$bu	xhi=5.0+$bu	ylo=$lef+$bu	yhi=$rig+$bu	box	add
contact	name=substrate	silicon		xlo=5.0-$bu	xhi=5.0+$bu	ylo=$lef+$bu	yhi=$rig+$bu	box	add

#set loadable save after process simultion incase meshing strategy below performs poorly.
struct tdr=Loadable

#Refine mesh, save again to compare mesh evolution

grid remesh

refinebox clear
line clear
grid set.Delaunay.type= boxmethod
refinebox Adaptive refine.fields= NetActive max.asinhdiff= {NetActive= 0.50}	refine.max.edge=50<nm>	Silicon
refinebox Adaptive refine.fields= NetActive max.asinhdiff= {NetActive= 0.50}	refine.max.edge=50<nm>	Silicon2
refinebox min= {0.0 10.1}	max= {0.3 14.5}	xrefine= {0.010 0.010 0.010} 	yrefine= {0.010 0.010 0.010}	Silicon
refinebox min= {0.0 10.1}	max= {0.3 14.5}	xrefine= {0.010 0.010 0.010} 	yrefine= {0.010 0.010 0.010}	Silicon2
grid remesh
#save remeshed output for electrical simulation
struct tdr=Full_remesh !Gas
