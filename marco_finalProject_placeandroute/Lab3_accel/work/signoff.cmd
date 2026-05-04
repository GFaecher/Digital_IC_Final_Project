#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon May  4 14:24:17 2026                
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
setMultiCpuUsage -localCpu 16 -cpuAutoAdjust true -verbose -remoteHost 1
restoreDesign top.route_opt.enc.dat top
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
globalNetConnect VSS -type pgpin -pin VSS* -all -override
globalNetConnect VDD -type pgpin -pin VDD* -all -override
globalNetConnect VSS -type pgpin -pin VBB* -all -override
globalNetConnect VDD -type pgpin -pin VPP* -all -override
setTieHiLoMode -cell {TIEHBWP16P90 TIELBWP16P90} -maxFanout 1
deleteShield -nets *
setSignoffOptMode -fixGlitch true
setDistributeHost -local
signoffOptDesign -drv
setNanoRouteMode -routeWithEco true
globalDetailRoute
addTieHiLo -cell {TIEHBWP16P90 TIELBWP16P90}
ecoPlace
ecoRoute -fix_drc
verify_drc
deleteShield -nets *
verify_drc -limit 1000000000
addFiller -cell {FILL1BWP16P90 FILL2BWP16P90 FILL4BWP16P90 FILL8BWP16P90 FILL16BWP16P90 FILL32BWP16P90 FILL64BWP16P90} -prefix FILLER_
deleteHaloFromBlock -allMacro
ecoRoute -target
verify_drc -limit 1000000000
saveDesign top.signoff_pre_timing.enc
set_analysis_view -setup [list normBC typical normWC] \
                  -hold [list normBC typical normWC]
setExtractRCMode -engine postRoute -effortLevel signoff
extractRC
rcOut -spef ../models/parasitic/top_rc_worst_m40c.spef.gz -rc_corner rc_worst_m40c
spefIn -rc_corner rc_worst_m40c ../models/parasitic/top_rc_worst_m40c.spef.gz
write_sdf -version 3.0  -target_application verilog  -precision 4  -condelse  -collapse_internal_pins  -view $view  ../models/sdf/${rm_core_top}_${corner}.sdf
do_extract_model -pg -view $view  -cell_name ${rm_core_top}  -lib_name ${rm_core_top}_${corner}  ../models/lib/${rm_core_top}_${corner}.lib
setExtractRCMode -engine postRoute -effortLevel signoff
extractRC
rcOut -spef ../models/parasitic/top_rc_typ_25c.spef.gz -rc_corner rc_typ_25c
spefIn -rc_corner rc_typ_25c ../models/parasitic/top_rc_typ_25c.spef.gz
write_sdf -version 3.0  -target_application verilog  -precision 4  -condelse  -collapse_internal_pins  -view $view  ../models/sdf/${rm_core_top}_${corner}.sdf
do_extract_model -pg -view $view  -cell_name ${rm_core_top}  -lib_name ${rm_core_top}_${corner}  ../models/lib/${rm_core_top}_${corner}.lib
setExtractRCMode -engine postRoute -effortLevel signoff
extractRC
rcOut -spef ../models/parasitic/top_rc_best_125c.spef.gz -rc_corner rc_best_125c
spefIn -rc_corner rc_best_125c ../models/parasitic/top_rc_best_125c.spef.gz
write_sdf -version 3.0  -target_application verilog  -precision 4  -condelse  -collapse_internal_pins  -view $view  ../models/sdf/${rm_core_top}_${corner}.sdf
do_extract_model -pg -view $view  -cell_name ${rm_core_top}  -lib_name ${rm_core_top}_${corner}  ../models/lib/${rm_core_top}_${corner}.lib
write_lef_abstract -5.8 -specifyTopLayer M11 -PGpinLayers M8 -stripePin -cutObsMinSpacing ../models/lef/top.lef
setStreamOutMode -virtualConnection false -snapToMGrid true
streamOut -mapFile /usr/cots/pdk/N16ADFP/APR/N16ADFP_APR_Innovus/N16ADFP_APR_Innovus_Gdsout_11M.10a.map -stripes 1 ../data/top.gds2 -mode ALL
saveNetlist ../models/verilog/top.v -excludeLeafCell
saveNetlist ../data/top.pg.flat.v -flat -excludeLeafCell -includePowerGround -includePhysicalCell {DCAP8BWP20P90LVT DCAP8BWP20P90 DCAP8BWP16P90LVT DCAP8BWP16P90 DCAP64BWP20P90LVT DCAP64BWP20P90 DCAP64BWP16P90LVT DCAP64BWP16P90 DCAP4BWP20P90LVT DCAP4BWP20P90 DCAP4BWP16P90LVT DCAP4BWP16P90 DCAP32BWP20P90LVT DCAP32BWP20P90 DCAP32BWP16P90LVT DCAP32BWP16P90 DCAP16BWP20P90LVT DCAP16BWP20P90 DCAP16BWP16P90LVT DCAP16BWP16P90} -excludeCellInst {FILL8BWP20P90LVT FILL8BWP20P90 FILL8BWP16P90LVT FILL8BWP16P90 FILL64BWP20P90LVT FILL64BWP20P90 FILL64BWP16P90LVT FILL64BWP16P90 FILL4BWP20P90LVT FILL4BWP20P90 FILL4BWP16P90LVT FILL4BWP16P90 FILL3BWP20P90LVT FILL3BWP20P90 FILL3BWP16P90LVT FILL3BWP16P90 FILL32BWP20P90LVT FILL32BWP20P90 FILL32BWP16P90LVT FILL32BWP16P90 FILL2BWP20P90LVT FILL2BWP20P90 FILL2BWP16P90LVT FILL2BWP16P90 FILL1BWP20P90LVT FILL1BWP20P90 FILL1BWP16P90LVT FILL1BWP16P90 FILL16BWP20P90LVT FILL16BWP20P90 FILL16BWP16P90LVT FILL16BWP16P90}
saveDesign top.signoff.enc
summaryReport -noHtml -outfile ../reports/layout/top-signoff.summary
timeDesign -signoff -hold -pathReports -slackReports -numPaths 50 -outDir ../reports/layout/ -prefix top-signoff
timeDesign -signoff -pathReports -slackReports -numPaths 20 -outDir ../reports/layout/ -prefix top-signoff
report_area > ../reports/layout/top-signoff.area
report_power > ../reports/layout/top-signoff.power
reportGateCount -stdCellOnly -outfile ../reports/layout/top-signoff.gatecount
