File {
	* The convention has been to run this file from within a directory structure that looks as follows:
	*	./CC/			indicating simulations to examine characteristic curves
	*	./CC/cmds/		containing all *.cmd files [this included] to run electrical simulations		
	*	./CC/currents/		to save all *.plt files containing circuit IV information
	*	./CC/logs/		to save all *.log files from simulation output
	*	./CC/plts/		to save all *.tdr files output at the end of simulation for generation of 2d figures and full data processing
	*	./CC/savs/		to save all *.sav files and *.tdr files at intermediate stages
	*	./CC/structure/		to store process file output structures on which this simulation operates.
	* Input Files
	Grid	= "../structure/SiSeRO_msh.tdr"
	
	* Output Files
	Current	= "../currents/sens_Vgs_0.65"
	Plot	= "../plts/sens_Vgs_0.65"
	Output	= "../logs/sens_Vgs_0.65"
	
}

Electrode {
	{Name="source"		Voltage=-3.0} * charge=0. indicates floating
	{Name="drain"		Voltage=0.0}
	* {Name="gate"		Voltage=1.50} * for PreDrain
	{Name="gate"		Voltage=-2.35} * for Vgs_0.65
	* {Name="gate"		Voltage=2.30} * for Vgs_0.80
	* {Name="gate"		Voltage=2.50} * for Vgs_1.00
	* {Name="gate"		Voltage=2.70} * for Vgs_1.20
	* {Name="gate"		Voltage=2.90} * for Vgs_1.40
	{Name="chargeflow"	Voltage=0.0}
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
	EffectiveIntrinsicDensity( OldSlotboom)
	Recombination( SRH( DopingDep TempDependence)  Auger Avalanche( ElectricField))
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

CurrentPlot {   
        eDensity(
                Integrate(DopingWell (0.25 12.4))
        )
	ElectrostaticPotential(
                Maximum(DopingWell (0.25 12.4))
	)
	eQuasiFermi(
                Maximum(DopingWell (0.25 12.4))
                Average(DopingWell (0.25 12.4))
	)
}

Math {
	* Parallelization
	Number_Of_Threads=8

	* Numeric Controls
	Extrapolate	* switches on solution extrapolation along a bias ramp
	Derivatives	* considers mobility derivatives in Jacobian
	Iterations=100	* Maximum allowed number of Newton iterations (3D)
	RelErrControl	* Enables the relative error control for solution variables
	Digits=5	* relative error control value. Iterations stop if dx/x <10^-n
	Method=ILS	* Use the iterative linear solver
	NotDamped=100	* number of Newton iterations over which the RHS norm can increase
	Transient=BE	* Switches on BE transient method
}

Solve {
	
	* Vgs=0.65V
	* Vg=2.15V 
       Load ( FilePrefix="../savs/Vgs_0.65")
       Quasistationary(
               InitialStep=1e-8 MinStep=1e-12 MaxStep=1e-3
              Goal {DopingWell(0.25 12.4) eQuasiFermi=1.3}
       ){Coupled{ Poisson Hole}
       CurrentPlot(-Loadable Time(Range=(0 1) Intervals=200))}
       Plot(-Loadable FilePrefix="../plts/sens_Vgs_0.65")
       Save (FilePrefix="../savs/sens_Vgs_0.65")
	
}


