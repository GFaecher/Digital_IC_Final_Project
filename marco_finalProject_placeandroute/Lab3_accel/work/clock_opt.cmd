#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon May  4 13:58:53 2026                
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
setMultiCpuUsage -localCpu 16 -verbose
restoreDesign top.place_opt.enc.dat top
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
globalNetConnect VSS -type pgpin -pin VSS* -all -override
globalNetConnect VDD -type pgpin -pin VDD* -all -override
globalNetConnect VSS -type pgpin -pin VBB* -all -override
globalNetConnect VDD -type pgpin -pin VPP* -all -override
setDesignMode -flowEffort standard
set_ccopt_property -update_io_latency true
set_ccopt_property -force_update_io_latency true
set_ccopt_property -enable_all_views_for_io_latency_update true
set_ccopt_property -max_fanout 16
set_ccopt_property -effort high
set_ccopt_property target_skew 0
set_ccopt_property target_max_trans -net_type leaf 0.5
set_ccopt_property target_max_trans -net_type top 0.5
set_ccopt_property target_max_trans -net_type trunk 0.5
create_ccopt_clock_tree_spec -file ../data/top-ccopt_cts.spec
create_ccopt_clock_tree_spec
clock_opt_design -check_prerequisites
clock_opt_design -outDir ../reports/layout/INNOVUS_RPT -prefix clock_opt
report_ccopt_clock_trees -filename ../reports/layout/top-clockopt_ccopt.clock_trees
report_ccopt_skew_groups -filename ../reports/layout/top-clockopt_ccopt.skew_groups
report_ccopt_clock_tree_structure -file ../reports/layout/top-clockopt_ccopt.clock_tree_structure
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
optDesign -postCTS -drv
optDesign -postCTS -incr
optDesign -postCTS -hold
optDesign -postCTS -hold -setup -holdVioData ../reports/layout/top-clockopt.holdVio
globalNetConnect VSS -type pgpin -pin VSS* -all -override
globalNetConnect VDD -type pgpin -pin VDD* -all -override
globalNetConnect VSS -type pgpin -pin VBB* -all -override
globalNetConnect VDD -type pgpin -pin VPP* -all -override
timeDesign -postCTS -outDir ../reports/layout/INNOVUS_RPT
timeDesign -postCTS -hold -outDir ../reports/layout/INNOVUS_RPT
saveDesign top.clock_opt.enc
report_ccopt_clock_trees -filename ../reports/layout/top-clockopt.clock_trees
report_ccopt_skew_groups -filename ../reports/layout/top-clockopt.skew_groups
report_ccopt_clock_tree_structure -file ../reports/layout/top-clockopt.clock_tree_structure
report_constraint -all_violators > ../reports/layout/top-clockopt.constraint
report_inactive_arcs -delay_arcs_only > ../reports/layout/${rm_core_top}-clockopt.disable_timing
reportIgnoredNets -outfile ../reports/layout/top-clockopt.ignored_nets
