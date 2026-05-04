#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon May  4 14:04:30 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v23.30-p003_1 (64bit) 02/01/2024 14:17 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 23.30-p003_1 NR240109-1512/23_10-UB (database version 18.20.618_1) {superthreading v2.20}
#@(#)CDS: AAE 23.10-p002 (64bit) 02/01/2024 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 23.10-p003_1 () Dec  5 2023 19:42:23 ( )
#@(#)CDS: SYNTECH 23.10-p002_1 () Nov 29 2023 02:17:21 ( )
#@(#)CDS: CPE v23.10-p004
#@(#)CDS: IQuantus/TQuantus 22.1.1-s215 (64bit) Mon Nov 20 10:05:08 PST 2023 (Linux 3.10.0-693.el7.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
setMultiCpuUsage -localCpu 16 -cpuAutoAdjust true -verbose
restoreDesign top.clock_opt.enc.dat top
setDesignMode -process 16 -flowEffort standard -powerEffort low
setAnalysisMode -analysisType onChipVariation -aocv false -cppr both -usefulSkew true
setDelayCalMode -equivalent_waveform_model_propagation true -equivalent_waveform_model_type none -SIAware true
setOptMode -allEndPoints true -fixFanoutLoad true -fixHoldOnExcludedClockNets true -fixSISlew true -holdFixingCells {BUFFD2BWP16P90 BUFFD4BWP16P90 BUFFD8BWP16P90 BUFFD16BWP16P90} -honorFence true -maxDensity 0.75 -postRouteAreaReclaim holdAndSetupAware -timeDesignNumPaths 200 -usefulSkew true -usefulSkewCCOpt extreme -usefulSkewPostRoute true -usefulSkewPreCTS true -verbose true
setPlaceMode -place_detail_preroute_as_obs {} -place_detail_check_cut_spacing true -place_detail_color_aware_legal true -place_detail_use_check_drc true -place_global_clock_power_driven true -place_global_fast_cts false -place_global_place_io_pins true -place_global_cong_effort high -place_global_max_density 0.75
setUsefulSkewMode -maxAllowedDelay 0.3 -useCells {BUFFD2BWP16P90 BUFFD4BWP16P90 BUFFD8BWP16P90 BUFFD16BWP16P90}
setSIMode -enable_logical_correlation true -enable_glitch_propagation true -enable_double_clocking_check true -individual_attacker_simulation_filtering true
set_global timing_aocv_analysis_mode combine_launch_capture
get_message -id GLOBAL-100 -suppress
get_message -id GLOBAL-100 -suppress
set timing_aocv_use_cell_depth_for_net false
set_global timing_derate_aocv_dynamic_delays true
set_global timing_enable_si_cppr true
set_global timing_disable_library_data_to_data_checks false
set_global timing_disable_library_tiehi_tielo false
get_message -id GLOBAL-100 -suppress
get_message -id GLOBAL-100 -suppress
set timing_disable_lib_pulsewidth_checks false
set_global timing_set_clock_source_to_output_as_data true
all_constraint_modes -active
set_interactive_constraint_modes [all_constraint_modes -active]
set_propagated_clock [get_clocks CLK]
reset_clock_uncertainty -from [all_clocks] -to [all_clocks]
set_clock_uncertainty -setup [expr ${rm_post_cts_clock_uncertainty} + ${rm_setup_margin} + ${rm_period_jitter}] [get_clocks CLK]
set_clock_uncertainty -hold [expr  ${rm_hold_margin}] [get_clocks CLK]
set_clock_uncertainty -setup [expr ${rm_post_cts_clock_uncertainty} + ${rm_setup_margin} + ${rm_period_jitter}] [get_clocks VCLK]
set_clock_uncertainty -hold [expr ${rm_hold_margin}] [get_clocks VCLK]
group_path -name Inputs -from $inputs
group_path -name Outputs -to [all_outputs]
group_path -name Feedthrough  -from $inputs -to [all_outputs]
group_path -name FromRegs -from $regs
group_path -name ToRegs   -to   $regs
group_path -name FromMems -from $memories
group_path -name ToMems   -to   $memories
setPathGroupOptions FromRegs -effortLevel high
setPathGroupOptions ToRegs -effortLevel high
setPathGroupOptions FromMems -effortLevel high
setPathGroupOptions ToMems -effortLevel high
set_interactive_constraint_modes {}
setViaGenMode -parameterized_via_only true
globalNetConnect VSS -type pgpin -pin VSS* -all -override
globalNetConnect VDD -type pgpin -pin VDD* -all -override
globalNetConnect VSS -type pgpin -pin VBB* -all -override
globalNetConnect VDD -type pgpin -pin VPP* -all -override
setAttribute -net VDD -skip_routing false
setAttribute -net VDD -avoid_detour true -weight 20 -non_default_rule TrunkNDR -pattern trunk
setNanoRouteMode -routeAllowPowerGroundPin true
setPGPinUseSignalRoute PTBUFF*:TVDD PTINV*:TVDD TAPCELL*:VPP ISO*:VDDS BOUNDARY_*TAP*:VPP
routePGPinUseSignalRoute -maxFanout 1 -nonDefaultRule TrunkNDR
setDesignMode -flowEffort standard
setNanoRouteMode -drouteOnGridOnly {wire 4:7 via 3:6}
setNanoRouteMode -routeWithViaInPin 1:1
setNanoRouteMode -routeTopRoutingLayer 9
setNanoRouteMode -routeBottomRoutingLayer 2
setNanoRouteMode -droutePostRouteSpreadWire false
setNanoRouteMode -dbViaWeight {*_P* -1}
setNanoRouteMode -routeReserveSpaceForMultiCut false
setNanoRouteMode -routeAutoPinAccessForBlockPin true
setNanoRouteMode -routeConcurrentMinimizeViaCountEffort high
setNanoRouteMode -droutePostRouteSwapVia false
setTieHiLoMode -cell {TIEHBWP16P90 TIELBWP16P90} -maxFanout 1
setExtractRCMode -engine postRoute -effortLevel high
setNanoRouteMode -routeWithTimingDriven true -routeWithSiDriven true -routeWithLithoDriven false -routeDesignRouteClockNetsFirst true -drouteUseMultiCutViaEffort low
routeDesign
saveDesign top.route_opt_init.enc
setExtractRCMode -engine postRoute -effortLevel medium
setOptMode -holdFixingCells {BUFFD2BWP16P90 BUFFD4BWP16P90 BUFFD8BWP16P90 BUFFD16BWP16P90}
setOptMode -holdTargetSlack 0.07
optDesign -postRoute -drv
optDesign -postRoute -incr
optDesign -postRoute -setup
optDesign -postRoute -hold
optDesign -postRoute -setup -hold
setExtractRCMode -engine postRoute -effortLevel high
setOptMode -highEffortOptCells {BUFFD2BWP16P90 BUFFD4BWP16P90 BUFFD8BWP16P90 BUFFD16BWP16P90}
setOptMode -holdFixingCells {BUFFD2BWP16P90 BUFFD4BWP16P90 BUFFD8BWP16P90 BUFFD16BWP16P90}
setOptMode -verbose true -holdTargetSlack 0.07
optDesign -postRoute -hold
setAnalysisMode -analysisType onChipVariation -cppr both
setDelayCalMode -engine default -SIAware true
setSIMode -enable_glitch_report true
setOptMode -fixGlitch true
optDesign -postRoute -drv
setOptMode -highEffortOptCells {BUFFD2BWP16P90 BUFFD4BWP16P90 BUFFD8BWP16P90 BUFFD16BWP16P90}
setOptMode -holdFixingCells {BUFFD2BWP16P90 BUFFD4BWP16P90 BUFFD8BWP16P90 BUFFD16BWP16P90}
setOptMode -verbose true -holdTargetSlack 0.07
optDesign -postRoute -hold
timeDesign -postRoute -outDir ../reports/layout/INNOVUS_RPT
timeDesign -postRoute -hold -outDir ../reports/layout/INNOVUS_RPT
globalNetConnect VSS -type pgpin -pin VSS* -all -override
globalNetConnect VDD -type pgpin -pin VDD* -all -override
saveDesign top.route_opt.enc
reportRoute
reportWire
verifyConnectivity -noAntenna
verify_drc
verifyMetalDensity
report_constraint -all_violators > ../reports/layout/top-routeopt.constraint
report_inactive_arcs -delay_arcs_only > ../reports/layout/${rm_core_top}-routeopt.disable_timing
reportIgnoredNets -outfile ../reports/layout/top-routeopt.ignored_nets
