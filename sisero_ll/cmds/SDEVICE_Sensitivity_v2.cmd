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
	*Current	= "../currents/sens_SiSeRO"
	*Plot	= "../plts/sens_SiSeRO"
	*Output	= "../logs/sens_SiSeRO"
	Current	= "../currents/gb_sens_SiSeRO"
	Plot	= "../plts/gb_sens_SiSeRO"
	Output	= "../logs/gb_sens_SiSeRO"
}

Electrode {
	{Name="source"		Voltage=1.5} * charge=0. indicates floating
	{Name="drain"		Voltage=0.0}
	* {Name="gate"		Voltage=1.5} * for PreDrain
	* {Name="gate"		Voltage=3.0} * for Vgs_1.5
	* {Name="gate"		Voltage=1.55} * for Vgs_0.05
	{Name="gate"		Voltage=2.15} * for Vgs_0.65
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

Math {
	* Parallelization
	Number_Of_Threads=8

	* Numeric Controls
	Extrapolate	* switches on solution extrapolation along a bias ramp
	Derivatives	* considers mobility derivatives in Jacobian
	Iterations=200	* Maximum allowed number of Newton iterations (3D)
	RelErrControl	* Enables the relative error control for solution variables
	Digits=5	* relative error control value. Iterations stop if dx/x <10^-n
	Method=ILS	* Use the iterative linear solver
	NotDamped=100	* number of Newton iterations over which the RHS norm can increase
	Transient=BE	* Switches on BE transient method
}

Solve {
       *Load ( FilePrefix="../savs/PreDrain")
       *Quasistationary(
       *        InitialStep=1e-5 MinStep=1e-7 MaxStep=1.0
       *        Goal {DopingWell(0.25 12.4) eQuasiFermi=1.0}
       *){Coupled{ Poisson Hole}
       *CurrentPlot}
       *Plot(-Loadable FilePrefix="../plts/PreDrain_qf1.0")
       *Save (FilePrefix="../savs/PreDrain_qf1.0")
  	
       Load ( FilePrefix="../savs/Vgs_0.65")
       Quasistationary(
               InitialStep=1e-5 MinStep=1e-7 MaxStep=1.0
               Goal {DopingWell(0.25 12.4) eQuasiFermi=1.3}
       ){Coupled{ Poisson Hole}
       CurrentPlot}
       Plot(-Loadable FilePrefix="../plts/Vgs_0.65_qf1.3")
       Save (FilePrefix="../savs/Vgs_0.65_qf1.3")

       *Coupled{ Poisson Electron Hole }
       *CurrentPlot
       *Plot(-Loadable FilePrefix="../plts/qf2.0")
       *Save ( FilePrefix="../savs/qf2.0")
}


