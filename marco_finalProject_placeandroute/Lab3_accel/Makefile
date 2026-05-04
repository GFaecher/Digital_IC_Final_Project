SYNOPSYS = licenses/synopsys
CADENCE = licenses/cadence

MODULE = . /usr/share/Modules/init/sh; module load $(SYNOPSYS) $(CADENCE)

GENUS   = tools/genus/231
INNOVUS = tools/innovus/231
TEMPUS  = tools/tempus/231
VERISIUM = tools/verisium
XCELIUM   = tools/xcelium/23.03
#####################################
#          INVOKE TOOLS             #
#####################################

#COMPILE = cd work; $(MODULE) $(DC); time dc_shell-xg-t -64bit
COMPILE = cd work; $(MODULE) $(GENUS); time genus
PNR 	= cd work; $(MODULE) $(INNOVUS) $(TEMPUS); time innovus
XRUN    = cd work; $(MODULE) $(XCELIUM) $(VERISIUM); time xrun
#####################################
#              SETUP                #
#####################################
RUNDIR  = $(PWD)
LOGS    = $(RUNDIR)/logs
SCRIPTS = $(RUNDIR)/scripts
DATE    = "`date '+%m_%d_%H_%M'`"

#####################################
#              FRONT                #
#####################################
tell_date:
	echo $(DATE)

sim: dirs
	$(XRUN) -sv -gui -64bit -lwdgen -access rwc -verisium +incdir+../rtl -top tb -f ../rtl/lab1.vc -l ./simulation.log


compile: dirs
	$(COMPILE) -files $(SCRIPTS)/compile.tcl -log compile | tee $(LOGS)/compile.log

#####################################
#              BACK                 #
#####################################

design_planning: dirs
	$(PNR) -files $(SCRIPTS)/design_planning.tcl -log design_planning \
        | tee $(LOGS)/design_planning.log

place_opt:
	$(PNR) -file $(SCRIPTS)/place_opt.tcl -log place_opt | tee $(LOGS)/place_opt.log

clock_opt:
	$(PNR) -file $(SCRIPTS)/clock_opt.tcl -log clock_opt | tee $(LOGS)/clock_opt.log

route_opt:
	$(PNR) -file $(SCRIPTS)/route_opt.tcl -log route_opt | tee $(LOGS)/route_opt.log

signoff:
	$(PNR) -file $(SCRIPTS)/signoff.tcl -log signoff | tee $(LOGS)/signoff.log

fix_hold:
	$(PNR) -file $(SCRIPTS)/fix_hold.tcl -log fix_hold | tee $(LOGS)/fix_hold.log


#####################################
#         CREATE DIRECTORIES        #
#####################################
dirs:
	@mkdir -p work/
	@mkdir -p $(LOGS)
	@mkdir -p data/
	@mkdir -p reports/
	@mkdir -p reports/compile/
	@mkdir -p reports/layout/
	@mkdir -p reports/dft/
	@mkdir -p reports/lec/
	@mkdir -p reports/sta/
	@mkdir -p reports/dmsa/
	@mkdir -p reports/power
	@mkdir -p tapeout_gds
	@mkdir -p models/cdl
	@mkdir -p models/db
	@mkdir -p models/floorplan
	@mkdir -p models/gds
	@mkdir -p models/lef
	@mkdir -p models/lib
	@mkdir -p models/milkyway/11M_2Xa1Xd
	@mkdir -p models/parasitic
	@mkdir -p models/sdc
	@mkdir -p models/sdf
	@mkdir -p models/verilog


clean:
	@echo "Cleaning example directory ..."
	@/bin/rm -rf work/.[a-zA-Z]*
	@/bin/rm -rf work*
	@/bin/rm -rf $(LOGS)
	@/bin/rm -rf data
	@/bin/rm -rf reports
	@/bin/rm -rf tapeout_gds
	@/bin/rm -rf models

genus:
	$(COMPILE)

innovus:
	$(PNR)
