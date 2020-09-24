9/4/2020
Attached are 5 *.cmd files, a mock directory structure, and a directory 'as_text' containing the *.cmd files saved directly as *.txt [all files should be human readable unix endline]
	*.txt can be changed to *.cmd to run with sprocess and sdevice;  They are sent as many email clients automatically block *.cmds.
	Files leading with SPROCESS are to be run with Synopsys Sentaurus Process.
		command line running with "sprocess FNAME.cmd" will initiate process simulation.
		PMOS simulates 2d-process for SiSeRO along the readout MOSFET axis.
		CCD Channel simulates 2d-process for SiSeRO along the CCD axis [from channel into internal gate named 'chargeflow' out to reset]
			If run as attached each simulation will perform analytic implants and save two output files:
				Loadable_fps.tdr
				Full_remesh_fps.tdr
					Loadable is the output of the simulation and if resources allow, the best candidate structure for the electrostatic simulations.
					Full_remesh is the output after a remesh that subsamples.  Adjust preceding grid parameters to refine this geometry as you see fit.
			Files are moderately commented noting changes for more complete implant simulations unsing MC cascade models and mask/implant adjustments or omissions to toggle between buried and surface channel SiSeRO varients.
	Files leading with SDEVICE are to be run with Synopsys Sentaurus Device.  They are a framework for exploring the output PMOS simulated structure.
		They assume an undelying directory structure as illustrated in the attached and as drawn here:
			./
			./cmds/
			./cmds/FNAME.cmd
			./cmds/currents/
			./logs/
			./plts/
			./savs/
			./structure/
			./structure/SiSeRO_msh.tdr
		The output *.tdr to be used should be named SiSeRO_msh.tdr and placed in the ./structure' directory.  This is the structure file that the command file will operate on.
		./savs/ will contain intermediate output files (*.sav and *.tdr) that can be loaded by subsequent simulations, examined wish svisual, or processed by tdx.
		./plts/ will contain final output files (*.tdr).  These are analysis points at the end of a simulation run.
		./logs/ will contain *.log output and error logging.
		./currents/ will contain *.plt files containing electrostatic registered I,V ramps produces during simulations for all contatcs.
		./cmds/ will contain *.cmd files which initialize a simulation using "sdevice FNAME.cmd".

		Three simulation files are attached;  Init_DC, Gate_bias, and TC_des.
			All use similar Physics and Math statements, adjust as you see apropriate.  As written they use 8 thread parallel assuming at least 2 sparallel lincences available.
			Init_DC is to be run first
				Represents device power on as gate and source voltage are brought to 1.5V above drain
				This outputs a file ./savs/PreDrain which is loaded by the following cmd files.
				It includes commented subsections illustrating syntac for well draining if desired.
			GateBias
				increments Vgs in 0.05V increments to 1.50V illustrating channel burying behavior of BC_SiSeRO device
				Outputs in ./savs/Vgs_*_des.tdr are output geometries to be examined.
			TC_des
				adjusts Vgs in very fine increments to build transconductance curves at particular SD voltage as established by Init_DC
		Adjustments to these three files tuning potential between source, gate, drain, and internal 'chargeflow' contact should serve as a framework to explore properties of SiSeRO at whatever operating conditions you're interested in.
Feel free to contact Kevan.Donlon@ll.mit.edu with any questions you might have.
