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
Current = "../currents/Vgs_0.15"
	Plot	= "../plts/SiSeRO"
Output  = "../logs/Vgs_0.15"
}

Electrode {
	{Name="source"		Voltage=-7.0} * charge=0. indicates floating
{Name="gate" Voltage=-6.8500000000000005}
	{Name="drain"		Voltage=0.0}
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
* Load Previous
Load ( FilePrefix="../savs/Vgs_0.10")
* Change Gate
Quasistationary(
InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
Goal {Name="gate" Voltage=-6.700000000000001}
){Coupled{ Poisson Electron Hole}}
Plot (-Loadable FilePrefix="../plts/Vgs_0.15")
Save (FilePrefix="../savs/Vgs_0.15")
}


