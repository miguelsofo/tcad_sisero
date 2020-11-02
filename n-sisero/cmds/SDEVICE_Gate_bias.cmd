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
	Current	= "../currents/SiSeRO"
	Plot	= "../plts/SiSeRO"
	Output	= "../logs/SiSeRO"
}

Electrode {
	{Name="source"		Voltage=-3.0} * charge=0. indicates floating
	{Name="drain"		Voltage=0.0}
	{Name="gate"		Voltage=-3.0}
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

* This simulation loads the result of initialized simulation and then steps gate voltage recording full 2d electrostatics every 0.05V for gate change
Solve {
	* Load Previous
	Load ( FilePrefix="../savs/PreDrain")
	* Change Gate

	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-3.0}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.00")
	Save (FilePrefix="../savs/Vgs_0.00")

	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.95}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.05")
	Save (FilePrefix="../savs/Vgs_0.05")

	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.90}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.10")
	Save (FilePrefix="../savs/Vgs_0.10")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.85}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.15")
	Save (FilePrefix="../savs/Vgs_0.15")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.80}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.20")
	Save (FilePrefix="../savs/Vgs_0.20")

	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.75}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.25")
	Save (FilePrefix="../savs/Vgs_0.25")

	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.70}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.30")
	Save (FilePrefix="../savs/Vgs_0.30")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.65}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.35")
	Save (FilePrefix="../savs/Vgs_0.35")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.60}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.40")
	Save (FilePrefix="../savs/Vgs_0.40")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.55}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.45")
	Save ( FilePrefix="../savs/Vgs_0.45")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.50}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.50")
	Save ( FilePrefix="../savs/Vgs_0.50")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.45}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.55")
	Save ( FilePrefix="../savs/Vgs_0.55")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.40}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.60")
	Save ( FilePrefix="../savs/Vgs_0.60")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.35}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.65")
	Save ( FilePrefix="../savs/Vgs_0.65")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.30}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.70")
	Save ( FilePrefix="../savs/Vgs_0.70")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.25}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.75")
	Save ( FilePrefix="../savs/Vgs_0.75")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.20}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.80")
	Save ( FilePrefix="../savs/Vgs_0.80")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.15}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.85")
	Save ( FilePrefix="../savs/Vgs_0.85")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.10}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.90")
	Save ( FilePrefix="../savs/Vgs_0.90")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.05}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_0.95")
	Save ( FilePrefix="../savs/Vgs_0.95")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-2.00}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_1.00")
	Save ( FilePrefix="../savs/Vgs_1.00")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-1.95}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_1.05")
	Save ( FilePrefix="../savs/Vgs_1.05")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-1.90}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_1.10")
	Save ( FilePrefix="../savs/Vgs_1.10")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-1.85}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_1.15")
	Save ( FilePrefix="../savs/Vgs_1.15")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-1.80}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_1.20")
	Save ( FilePrefix="../savs/Vgs_1.20")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-1.75}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_1.25")
	Save ( FilePrefix="../savs/Vgs_1.25")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-1.70}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_1.30")
	Save ( FilePrefix="../savs/Vgs_1.30")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-1.65}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_1.35")
	Save ( FilePrefix="../savs/Vgs_1.35")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-1.60}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_1.40")
	Save ( FilePrefix="../savs/Vgs_1.40")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-1.55}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_1.45")
	Save ( FilePrefix="../savs/Vgs_1.45")
	
	Quasistationary(
		InitialStep=1e-3 MinStep=1e-7 MaxStep=1.0
		Goal {Name="gate" Voltage=-1.50}
	){Coupled{ Poisson Electron Hole}}
	Plot (-Loadable FilePrefix="../plts/Vgs_1.50")
	Save ( FilePrefix="../savs/Vgs_1.50")
}


