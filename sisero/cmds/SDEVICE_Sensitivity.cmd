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
	Current	= "../currents/filled_SiSeRO"
	Plot	= "../plts/filled_SiSeRO"
	Output	= "../logs/filled_SiSeRO"
}

Electrode {
	{Name="source"		Voltage=1.5} * charge=0. indicates floating
	{Name="drain"		Voltage=0.0}
	{Name="gate"		Voltage=1.5}
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
	Iterations=100	* Maximum allowed number of Newton iterations (3D)
	RelErrControl	* Enables the relative error control for solution variables
	Digits=5	* relative error control value. Iterations stop if dx/x <10^-n
	Method=ILS	* Use the iterative linear solver
	NotDamped=100	* number of Newton iterations over which the RHS norm can increase
	Transient=BE	* Switches on BE transient method
}

Solve {
	* Load Previous
	* Load ( FilePrefix="../savs/Vgs_1.50")
	Load ( FilePrefix="../savs/PreDrain")

	Quasistationary(
               InitialStep=1e-5 MinStep=1e-7 MaxStep=1.0
               Goal {WellContactName="chargeflow" eQuasiFermi=1.0}
       ){Coupled ( Iterations=100 ) { Poisson Hole} CurrentPlot}
       Plot(-Loadable FilePrefix="../plts/Filled")
       Save(FilePrefix="../savs/Filled")

* ------------------------------------------------------------
* The following way does not have a good control on the 
* position of the generated charge
*       Quasistationary(
*               InitialStep=1e-5 MinStep=1e-7 MaxStep=1.0
*               Goal {DopingWell(0.31 12.3) eQuasiFermi=-10}
*       ){Coupled{Electron}
*       CurrentPlot}
*               Plot(-Loadable FilePrefix="../plts/Filled")
*       Save (FilePrefix="../savs/Filled")

* ------------------------------------------------------------
* The following way does not work becouse the chargeflow 
* silicon contact is directly connected to the source contact 
* (it is not floating!) 
*	Quasistationary(
*               InitialStep=1e-5 MinStep=1e-7 MaxStep=1.0
*               Goal {Name="chargeflow" charge=1e-13}
*       ){Coupled{ Poisson Electron} CurrentPlot}
*       Plot(-Loadable FilePrefix="../plts/Filled")
*       Save (FilePrefix="../savs/Filled")

}


