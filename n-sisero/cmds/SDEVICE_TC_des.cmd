File {
	* Input Files
	Grid	= "../structure/SiSeRO_msh.tdr"
	* Output Files
	Current	= "../currents/SiSeRO_TC"
	Plot	= "../plts/SiSeRO_TC"
	Output	= "../logs/SiSeRO_TC"
}
 
Electrode {
	{Name="source"		Voltage=-3.0} * charge=0. indicates floating
	{Name="drain"		Voltage=0.0}
	{Name="gate"		Voltage=-2.40}
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
	* Thermodynamic
	EffectiveIntrinsicDensity( OldSlotboom)
	Recombination( SRH( DopingDep TempDependence)  Auger Avalanche( ElectricField))
}

Plot {
	eDensity hDensity eCurrent hCurrent
	Current
	Potential SpaceCharge ElectricField
	eMobility hMobility eVelocity hVelocity
	Doping DonorConcentration AcceptorConcentration
}

Math {
	* Parallelization
	Number_Of_Threads=8

	* Numeric Controls
	*Extrapolate	* switches on solution extrapolation along a bias ramp
	Derivatives	* considers mobility derivatives in Jacobian
	Iterations=200	* Maximum allowed number of Newton iterations (3D)
	RelErrControl	* Enables the relative error control for solution variables
	Digits=5	* relative error control value. Iterations stop if dx/x <10^-n
	Method=ILS	* Use the iterative linear solver
	NotDamped=100	* number of Newton iterations over which the RHS norm can increase
	Transient=BE	* Switches on BE transient method
}

Solve {
	* Load Previous
	Load ( FilePrefix="../savs/Vgs_0.60")
	* Change Gate
	* If the simulation does not converge make MinStep smaller.
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.30}
	){Coupled{ Poisson Electron Hole}
		CurrentPlot(-Loadable Time(Range=(0 1) Intervals=200))
	}
}


