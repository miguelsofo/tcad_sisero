File {
	* Input Files
	Grid	= "../structure/SiSeRO_msh.tdr"
	* Output Files
	Current	= "../currents/init_SiSeRO"
	Plot	= "../plts/init_SiSeRO"
	Output	= "../logs/init_SiSeRO"
}
 
Electrode {
	{Name="source"		Voltage=0.0} * charge=0. indicates floating
	{Name="drain"		Voltage=0.0}
	{Name="gate"		Voltage=0.0}
	* {Name="chargeflow"	Voltage=0.0}
}

Physics {
	Fermi
	eQuantumPotential hQuantumPotential
	Mobility(
		DopingDep
		eHighFieldSat( GradQuasiFermi)
		hHighFieldSat( GradQuasiFermi)
		Enormal )
	Temperature=300.0
	Thermodynamic
	EffectiveIntrinsicDensity( OldSlotboom)
	Recombination( SRH( DopingDep TempDependence)  Auger)
}

Plot {
	DopingWells
	eDensity hDensity eCurrent hCurrent
	eQuasiFermi hQuasiFermi
	Current
	Potential SpaceCharge ElectricField ElectricField/Vector
	eMobility hMobility eVelocity hVelocity
	Doping DonorConcentration AcceptorConcentration
}

Math {
	* Parallelization
	Number_Of_Threads=8

	* Numeric Controls
	Extrapolate	* switches on solution extrapolation along a bias ramp
	Derivatives	* considers mobility derivatives in Jacobian
	Iterations=200	* Maximum allowed number of Newton iterations (3D)
	RelErrControl	* Enables the relative error control for solution variables
	Digits=7	* relative error control value. Iterations stop if dx/x <10^-n
	Method=ILS	* Use the iterative linear solver
	NotDamped=100	* number of Newton iterations over which the RHS norm can increase
	Transient=BE	* Switches on BE transient method
	RHSFactor=1e25
	RHSMax=1e55
}

Solve {
	* buildup of initial solution:
	Coupled(Iterations=500){ Poisson}
	Coupled{ Poisson Hole}
	Coupled{ Poisson Electron}
	Coupled{ Poisson Electron Hole}
	Quasistationary(
		InitialStep=1e-5 MinStep=1e-8 MaxStep=1.0
		Goal {Name="gate" Voltage=1.5}
		* Goal {Name="chargeflow"  Voltage=0.0}
		Goal {Name="drain" Voltage=0.0}
		Goal {Name="source" Voltage=1.5}
	){Coupled{ Poisson Electron Hole} CurrentPlot}
	Plot(-Loadable FilePrefix="../plts/PreDrain")
	Save (FilePrefix="../savs/PreDrain")

*	Quasistationary(
*		InitialStep=1e-5 MinStep=1e-7 MaxStep=1.0
*		Goal {DopingWell(0.25 12.2) eQuasiFermi=100.0}
*	){Coupled{ Poisson Hole}
*	CurrentPlot}
*		Plot(-Loadable FilePrefix="../plts/Drained")
*	Save (FilePrefix="../savs/Drained")
*	Coupled{ Poisson Electron Hole}
*	CurrentPlot
*		Plot(-Loadable FilePrefix="../plts/Initialized_DC")	
*	Save ( FilePrefix="../savs/Initialized_DC")
}


