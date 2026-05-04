#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon May  4 13:54:08 2026                
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
setMultiCpuUsage -localCpu 4 -cpuAutoAdjust true -verbose
set init_verilog ../data/top-compile.v
set init_lef_file {/usr/cots/pdk/N16ADFP/APR/N16ADFP_APR_Innovus/N16ADFP_APR_Innovus_11M.10a.tlef /usr/cots/ip_libraries/tsmc/N16ADFP/stdcell/N16ADFP_StdCell/LEF/lef/N16ADFP_StdCell.lef /usr/cots/ip_libraries/tsmc/N16ADFP/sram/N16ADFP_SRAM//LEF/N16ADFP_SRAM_100a.lef}
set init_mmmc_file ../scripts/viewDefinitions.tcl
set init_top_cell top
set init_design_uniquify 1
set init_gnd_net VSS
set init_pwr_net VDD
setLibraryUnit -cap 1pf -time 1ns
init_design
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
floorPlan -s 207.0 172.8 4.50 4.608 4.50 4.608 -noSnapToGrid
add_tracks -honor_pitch
clearGlobalNets
globalNetConnect VSS -type pgpin -pin VSS* -all -override
globalNetConnect VDD -type pgpin -pin VDD* -all -override
globalNetConnect VSS -type pgpin -pin VBB -all -override
globalNetConnect VDD -type pgpin -pin VPP -all -override
applyGlobalNets
setEndCapMode -rightEdge BOUNDARY_LEFTBWP20P90 -leftEdge BOUNDARY_RIGHTBWP20P90 -leftTopCorner BOUNDARY_PCORNERBWP20P90 -leftBottomCorner BOUNDARY_NCORNERBWP20P90 -topEdge {BOUNDARY_PROW2BWP20P90 BOUNDARY_PROW3BWP20P90} -bottomEdge {BOUNDARY_NROW2BWP20P90 BOUNDARY_NROW3BWP20P90} -rightTopEdge FILL3BWP20P90 -rightBottomEdge FILL3BWP20P90 -fitGap true -boundary_tap true
set_well_tap_mode -rule 50.76 -bottom_tap_cell BOUNDARY_NTAPBWP20P90_VPP_VSS -top_tap_cell BOUNDARY_PTAPBWP20P90_VPP_VSS -cell TAPCELLBWP20P90_VPP_VSS
addEndCap
set_well_tap_mode -reset
addWellTap -cell TAPCELLBWP20P90_VPP_VSS -cellInterval 50.76 -prefix tap
dbshape {{0.0 0.0 216.0 182.016}} ANDNOT {{4.5 4.608 211.5 177.408}} -output rect
dbshape {{0.0 0.0 216.0 182.016}} ANDNOT {{4.5 4.508 211.5 177.508}} -output rect
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M2 -stacked_via_top_layer M3 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -area_blockage {{0 0 4.5 182.016} {4.5 0 211.5 4.508} {4.5 177.508 211.5 182.016} {211.5 0 216 182.016}} -direction horizontal -layer M2 -nets VSS -start_offset 0.544 -width 0.064 -spacing 0 -set_to_set_distance 1.152 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M1 -stacked_via_top_layer M2 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -area_blockage {{0 0 4.5 182.016} {4.5 0 211.5 4.508} {4.5 177.508 211.5 182.016} {211.5 0 216 182.016}} -direction horizontal -layer M1 -nets VSS -start_offset 0.531 -width 0.090 -spacing 0 -set_to_set_distance 1.152 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M2 -stacked_via_top_layer M3 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -area_blockage {{0 0 4.5 182.016} {4.5 0 211.5 4.508} {4.5 177.508 211.5 182.016} {211.5 0 216 182.016}} -direction horizontal -layer M2 -nets VDD -start_offset -0.032 -width 0.064 -spacing 0 -set_to_set_distance 1.152 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M1 -stacked_via_top_layer M2 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -area_blockage {{0 0 4.5 182.016} {4.5 0 211.5 4.508} {4.5 177.508 211.5 182.016} {211.5 0 216 182.016}} -direction horizontal -layer M1 -nets VDD -start_offset -0.045 -width 0.090 -spacing 0 -set_to_set_distance 1.152 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
editPowerVia -add_vias 1 -orthogonal_only 0
setViaGenMode -reset
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
deselectAll
select_obj {0x7f6793d1a5c0 0x7f6793d1a5f0 0x7f6793d1a620 0x7f6793d1a650 0x7f6793d1a680 0x7f6793d1a6b0 0x7f6793d1a6e0 0x7f6793d1a710 0x7f6793d1a740 0x7f6793d1a770 0x7f6793d1a7a0 0x7f6793d1a7d0 0x7f6793d1a800 0x7f6793d1a830 0x7f6793d1a860 0x7f6793d1a890 0x7f6793d1a8c0 0x7f6793d1a8f0 0x7f6793d1a920 0x7f6793d1a950 0x7f6793d1a980 0x7f6793d1a9b0 0x7f6793d1a9e0 0x7f6793d1aa10 0x7f6793d1aa40 0x7f6793d1aa70 0x7f6793d1aaa0 0x7f6793d1aad0 0x7f6793d1ab00 0x7f6793d1ab30 0x7f6793d1ab60 0x7f6793d1ab90 0x7f6793d1abc0 0x7f6793d1abf0 0x7f6793d1ac20 0x7f6793d1ac50 0x7f6793d1ac80 0x7f6793d1acb0 0x7f6793d1ace0 0x7f6793d1ad10 0x7f6793d1ad40 0x7f6793d1ad70 0x7f6793d1ada0 0x7f6793d1add0 0x7f6793d1ae00 0x7f6793d1ae30 0x7f6793d1ae60 0x7f6793d1ae90 0x7f6793d1aec0 0x7f6793d1aef0 0x7f6793d1af20 0x7f6793d1af50 0x7f6793d1af80 0x7f6793d1afb0 0x7f6793d1afe0 0x7f6793d1b010 0x7f6793d1b040 0x7f6793d1b070 0x7f6793d1b0a0 0x7f6793d1b0d0 0x7f6793d1b100 0x7f6793d1b130 0x7f6793d1b160 0x7f6793d1b190 0x7f6793d1b1c0 0x7f6793d1b1f0 0x7f6793d1b220 0x7f6793d1b250 0x7f6793d1b280 0x7f6793d1b2b0 0x7f6793d1b2e0 0x7f6793d1b310 0x7f6793d1b340 0x7f6793d1b370 0x7f6793d1b3a0 0x7f6793d1b3d0 0x7f6793d1b400 0x7f6793d1b430 0x7f6793d1b460 0x7f6793d1b490 0x7f6793d1b4c0 0x7f6793d1b4f0 0x7f6793d1b520 0x7f6793d1b550 0x7f6793d1b580 0x7f6793d1b5b0 0x7f6793d1b5e0 0x7f6793d1b610 0x7f6793d1b640 0x7f6793d1b670 0x7f6793d1b6a0 0x7f6793d1b6d0 0x7f6793d1b700 0x7f6793d1b730 0x7f6793d1b760 0x7f6793d1b790 0x7f6793d1b7c0 0x7f6793d1b7f0 0x7f6793d1b820 0x7f6793d1b850 0x7f6793d1b880 0x7f6793d1b8b0 0x7f6793d1b8e0 0x7f6793d1b910 0x7f6793d1b940 0x7f6793d1b970 0x7f6793d1b9a0 0x7f6793d1b9d0 0x7f6793d1ba00 0x7f6793d1ba30 0x7f6793d1ba60 0x7f6793d1ba90 0x7f6793d1bac0 0x7f6793d1baf0 0x7f6793d1bb20 0x7f6793d1bb50 0x7f6793d1bb80 0x7f6793d1bbb0 0x7f6793d1bbe0 0x7f6793d1bc10 0x7f6793d1bc40 0x7f6793d1bc70 0x7f6793d1bca0 0x7f6793d1bcd0 0x7f6793d1bd00 0x7f6793d1bd30 0x7f6793d1bd60 0x7f6793d1bd90 0x7f6793d1bdc0 0x7f6793d1bdf0 0x7f6793d1be20 0x7f6793d1be50 0x7f6793d1be80 0x7f6793d1beb0 0x7f6793d1bee0 0x7f6793d1bf10 0x7f6793d1bf40 0x7f6793d1bf70 0x7f6793d1bfa0 0x7f6793a48020 0x7f6793a48050 0x7f6793a48080 0x7f6793a480b0 0x7f6793a480e0 0x7f6793a48110 0x7f6793a48140 0x7f6793a48170 0x7f6793a481a0 0x7f6793a481d0 0x7f6793a48200 0x7f6793a48230 0x7f67a82b2ce0 0x7f67a82b2d10 0x7f67a82b2d40 0x7f67a82b2d70 0x7f67a82b2da0 0x7f67a82b2dd0 0x7f67a82b2e00 0x7f67a82b2e30 0x7f67a82b2e60 0x7f67a82b2e90 0x7f67a82b2ec0 0x7f67a82b2ef0 0x7f67a82b2f20 0x7f67a82b2f50 0x7f67a82b2f80 0x7f67a82b2fb0 0x7f67a82b2fe0 0x7f67a82b3010 0x7f67a82b3040 0x7f67a82b3070 0x7f67a82b30a0 0x7f67a82b30d0 0x7f67a82b3100 0x7f67a82b3130 0x7f67a82b3160 0x7f67a82b3190 0x7f67a82b31c0 0x7f67a82b31f0 0x7f67a82b3220 0x7f67a82b3250 0x7f67a82b3280 0x7f67a82b32b0 0x7f67a82b32e0 0x7f67a82b3310 0x7f67a82b3340 0x7f67a82b3370 0x7f67a82b33a0 0x7f67a82b33d0 0x7f67a82b3400 0x7f67a82b3430 0x7f67a82b3460 0x7f67a82b3490 0x7f67a82b34c0 0x7f67a82b34f0 0x7f67a82b3520 0x7f67a82b3550 0x7f67a82b3580 0x7f67a82b35b0 0x7f67a82b35e0 0x7f67a82b3610 0x7f67a82b3640 0x7f67a82b3670 0x7f67a82b36a0 0x7f67a82b36d0 0x7f67a82b3700 0x7f67a82b3730 0x7f67a82b3760 0x7f67a82b3790 0x7f67a82b37c0 0x7f67a82b37f0 0x7f67a82b3820 0x7f67a82b3850 0x7f67a82b3880 0x7f67a82b38b0 0x7f67a82b38e0 0x7f67a82b3910 0x7f67a82b3940 0x7f67a82b3970 0x7f67a82b39a0 0x7f67a82b39d0 0x7f67a82b3a00 0x7f67a82b3a30 0x7f67a82b3a60 0x7f67a82b3a90 0x7f67a82b3ac0 0x7f67a82b3af0 0x7f67a82b3b20 0x7f67a82b3b50 0x7f67a82b3b80 0x7f67a82b3bb0 0x7f67a82b3be0 0x7f67a82b3c10 0x7f67a82b3c40 0x7f67a82b3c70 0x7f67a82b3ca0 0x7f67a82b3cd0 0x7f67a82b3d00 0x7f67a82b3d30 0x7f67a82b3d60 0x7f67a82b3d90 0x7f67a82b3dc0 0x7f67a82b3df0 0x7f67a82b3e20 0x7f67a82b3e50 0x7f67a82b3e80 0x7f67a82b3eb0 0x7f67a82b3ee0 0x7f67a82b3f10 0x7f67a82b3f40 0x7f67a82b3f70 0x7f67a82b3fa0 0x7f6793baa020 0x7f6793baa050 0x7f6793baa080 0x7f6793baa0b0 0x7f6793baa0e0 0x7f6793baa110 0x7f6793baa140 0x7f6793baa170 0x7f6793baa1a0 0x7f6793baa1d0 0x7f6793baa200 0x7f6793baa230 0x7f6793baa260 0x7f6793baa290 0x7f6793baa2c0 0x7f6793baa2f0 0x7f6793baa320 0x7f6793baa350 0x7f6793baa380 0x7f6793baa3b0 0x7f6793baa3e0 0x7f6793baa410 0x7f6793baa440 0x7f6793baa470 0x7f6793baa4a0 0x7f6793baa4d0 0x7f6793baa500 0x7f6793baa530 0x7f6793baa560 0x7f6793baa590 0x7f6793baa5c0 0x7f6793baa5f0 0x7f6793baa620 0x7f6793baa650 0x7f6793baa680 0x7f6793baa6b0 0x7f6793baa6e0 0x7f6793baa710 0x7f6793baa740 0x7f6793baa770 0x7f6793baa7a0 0x7f6793baa7d0 0x7f6793baa800 0x7f6793baa830 0x7f6793baa860 0x7f6793baa890 0x7f6793baa8c0 0x7f6793baa8f0 0x7f6793baa920}
editPowerVia -bottom_layer M1 -top_layer M2 -selected_wires 1 -exclude_stack_vias 0 -add_vias 1 -orthogonal_only 0 -via_using_exact_crossover_size 1 -uda VIA12_Manual -skip_via_on_pin {pad cover} -skip_via_on_wire_shape {Blockring Corewire Blockwire Iowire Padring Ring Fillwire Noshape}
deselectAll
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M10 -stacked_via_top_layer M11 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction horizontal -layer M10 -nets VDD -start_offset 0.000 -width 2.700 -spacing 0 -set_to_set_distance 9.216 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M10 -stacked_via_top_layer M11 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction horizontal -layer M10 -nets VSS -start_offset 4.608 -width 2.700 -spacing 0 -set_to_set_distance 9.216 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M9 -stacked_via_top_layer M10 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction vertical -layer M9 -nets VDD -start_offset 0.000 -width 0.450 -spacing 0 -set_to_set_distance 2.520 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M9 -stacked_via_top_layer M10 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction vertical -layer M9 -nets VSS -start_offset 1.260 -width 0.450 -spacing 0 -set_to_set_distance 2.520 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M8 -stacked_via_top_layer M9 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction horizontal -layer M8 -nets VDD -start_offset 0.000 -width 0.062 -spacing 0 -set_to_set_distance 2.304 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M8 -stacked_via_top_layer M9 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction horizontal -layer M8 -nets VSS -start_offset 1.152 -width 0.062 -spacing 0 -set_to_set_distance 2.304 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M7 -stacked_via_top_layer M8 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction vertical -layer M7 -nets VDD -start_offset 0.000 -width 0.120 -spacing 0 -set_to_set_distance 2.520 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M7 -stacked_via_top_layer M8 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction vertical -layer M7 -nets VSS -start_offset 1.260 -width 0.120 -spacing 0 -set_to_set_distance 2.520 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M6 -stacked_via_top_layer M7 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction horizontal -layer M6 -nets VDD -start_offset 0.000 -width 0.040 -spacing 0 -set_to_set_distance 2.304 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M6 -stacked_via_top_layer M7 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction horizontal -layer M6 -nets VSS -start_offset 1.152 -width 0.040 -spacing 0 -set_to_set_distance 2.304 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M5 -stacked_via_top_layer M6 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction vertical -layer M5 -nets VDD -start_offset 0.000 -width 0.040 -spacing 0 -set_to_set_distance 2.520 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M5 -stacked_via_top_layer M6 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction vertical -layer M5 -nets VSS -start_offset 1.260 -width 0.040 -spacing 0 -set_to_set_distance 2.520 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M4 -stacked_via_top_layer M5 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction horizontal -layer M4 -nets VDD -start_offset 0.000 -width 0.040 -spacing 0 -set_to_set_distance 2.304 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M4 -stacked_via_top_layer M5 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction horizontal -layer M4 -nets VSS -start_offset 1.152 -width 0.040 -spacing 0 -set_to_set_distance 2.304 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M2 -stacked_via_top_layer M4 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction vertical -layer M3 -nets VDD -start_offset 0.000 -width 0.038 -spacing 0 -set_to_set_distance 2.520 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setAddStripeMode -reset
setAddStripeMode -use_fgc 1 -remove_floating_stripe_over_block false -stacked_via_bottom_layer M2 -stacked_via_top_layer M4 -keep_pitch_after_snap false -via_using_exact_crossover_size false -ignore_nondefault_domains true -skip_via_on_pin {Pad Block Cover Standardcell Physicalpin} -stapling_nets_style end_to_end -remove_floating_stapling true -break_at selected_block
setAddStripeMode -ignore_DRC 0
addStripe -area {{0.0 0.0 216.0 182.016}} -direction vertical -layer M3 -nets VSS -start_offset 1.260 -width 0.038 -spacing 0 -set_to_set_distance 2.520 -skip_via_on_wire_shape {} -snap_wire_center_to_grid Grid -uda PG_STR
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
setViaGenMode -reset
setViaGenMode -ignore_DRC 0 -allow_via_expansion 0 -extend_out_wire_end 1 -inherit_wire_status 1 -keep_existing_via 2 -partial_overlap_threshold 1 -allow_wire_shape_change 0 -keep_fixed_via 1 -optimize_cross_via 1 -disable_via_merging 1 -use_cce 1 -use_fgc 1
deselectAll
select_obj {0x7f6793d1a5c0 0x7f6793d1a5f0 0x7f6793d1a620 0x7f6793d1a650 0x7f6793d1a680 0x7f6793d1a6b0 0x7f6793d1a6e0 0x7f6793d1a710 0x7f6793d1a740 0x7f6793d1a770 0x7f6793d1a7a0 0x7f6793d1a7d0 0x7f6793d1a800 0x7f6793d1a830 0x7f6793d1a860 0x7f6793d1a890 0x7f6793d1a8c0 0x7f6793d1a8f0 0x7f6793d1a920 0x7f6793d1a950 0x7f6793d1a980 0x7f6793d1a9b0 0x7f6793d1a9e0 0x7f6793d1aa10 0x7f6793d1aa40 0x7f6793d1aa70 0x7f6793d1aaa0 0x7f6793d1aad0 0x7f6793d1ab00 0x7f6793d1ab30 0x7f6793d1ab60 0x7f6793d1ab90 0x7f6793d1abc0 0x7f6793d1abf0 0x7f6793d1ac20 0x7f6793d1ac50 0x7f6793d1ac80 0x7f6793d1acb0 0x7f6793d1ace0 0x7f6793d1ad10 0x7f6793d1ad40 0x7f6793d1ad70 0x7f6793d1ada0 0x7f6793d1add0 0x7f6793d1ae00 0x7f6793d1ae30 0x7f6793d1ae60 0x7f6793d1ae90 0x7f6793d1aec0 0x7f6793d1aef0 0x7f6793d1af20 0x7f6793d1af50 0x7f6793d1af80 0x7f6793d1afb0 0x7f6793d1afe0 0x7f6793d1b010 0x7f6793d1b040 0x7f6793d1b070 0x7f6793d1b0a0 0x7f6793d1b0d0 0x7f6793d1b100 0x7f6793d1b130 0x7f6793d1b160 0x7f6793d1b190 0x7f6793d1b1c0 0x7f6793d1b1f0 0x7f6793d1b220 0x7f6793d1b250 0x7f6793d1b280 0x7f6793d1b2b0 0x7f6793d1b2e0 0x7f6793d1b310 0x7f6793d1b340 0x7f6793d1b370 0x7f6793d1b3a0 0x7f6793d1b3d0 0x7f6793d1b400 0x7f6793d1b430 0x7f6793d1b460 0x7f6793d1b490 0x7f6793d1b4c0 0x7f6793d1b4f0 0x7f6793d1b520 0x7f6793d1b550 0x7f6793d1b580 0x7f6793d1b5b0 0x7f6793d1b5e0 0x7f6793d1b610 0x7f6793d1b640 0x7f6793d1b670 0x7f6793d1b6a0 0x7f6793d1b6d0 0x7f6793d1b700 0x7f6793d1b730 0x7f6793d1b760 0x7f6793d1b790 0x7f6793d1b7c0 0x7f6793d1b7f0 0x7f6793d1b820 0x7f6793d1b850 0x7f6793d1b880 0x7f6793d1b8b0 0x7f6793d1b8e0 0x7f6793d1b910 0x7f6793d1b940 0x7f6793d1b970 0x7f6793d1b9a0 0x7f6793d1b9d0 0x7f6793d1ba00 0x7f6793d1ba30 0x7f6793d1ba60 0x7f6793d1ba90 0x7f6793d1bac0 0x7f6793d1baf0 0x7f6793d1bb20 0x7f6793d1bb50 0x7f6793d1bb80 0x7f6793d1bbb0 0x7f6793d1bbe0 0x7f6793d1bc10 0x7f6793d1bc40 0x7f6793d1bc70 0x7f6793d1bca0 0x7f6793d1bcd0 0x7f6793d1bd00 0x7f6793d1bd30 0x7f6793d1bd60 0x7f6793d1bd90 0x7f6793d1bdc0 0x7f6793d1bdf0 0x7f6793d1be20 0x7f6793d1be50 0x7f6793d1be80 0x7f6793d1beb0 0x7f6793d1bee0 0x7f6793d1bf10 0x7f6793d1bf40 0x7f6793d1bf70 0x7f6793d1bfa0 0x7f6793a48020 0x7f6793a48050 0x7f6793a48080 0x7f6793a480b0 0x7f6793a480e0 0x7f6793a48110 0x7f6793a48140 0x7f6793a48170 0x7f6793a481a0 0x7f6793a481d0 0x7f6793a48200 0x7f6793a48230 0x7f67a82b2ce0 0x7f67a82b2d10 0x7f67a82b2d40 0x7f67a82b2d70 0x7f67a82b2da0 0x7f67a82b2dd0 0x7f67a82b2e00 0x7f67a82b2e30 0x7f67a82b2e60 0x7f67a82b2e90 0x7f67a82b2ec0 0x7f67a82b2ef0 0x7f67a82b2f20 0x7f67a82b2f50 0x7f67a82b2f80 0x7f67a82b2fb0 0x7f67a82b2fe0 0x7f67a82b3010 0x7f67a82b3040 0x7f67a82b3070 0x7f67a82b30a0 0x7f67a82b30d0 0x7f67a82b3100 0x7f67a82b3130 0x7f67a82b3160 0x7f67a82b3190 0x7f67a82b31c0 0x7f67a82b31f0 0x7f67a82b3220 0x7f67a82b3250 0x7f67a82b3280 0x7f67a82b32b0 0x7f67a82b32e0 0x7f67a82b3310 0x7f67a82b3340 0x7f67a82b3370 0x7f67a82b33a0 0x7f67a82b33d0 0x7f67a82b3400 0x7f67a82b3430 0x7f67a82b3460 0x7f67a82b3490 0x7f67a82b34c0 0x7f67a82b34f0 0x7f67a82b3520 0x7f67a82b3550 0x7f67a82b3580 0x7f67a82b35b0 0x7f67a82b35e0 0x7f67a82b3610 0x7f67a82b3640 0x7f67a82b3670 0x7f67a82b36a0 0x7f67a82b36d0 0x7f67a82b3700 0x7f67a82b3730 0x7f67a82b3760 0x7f67a82b3790 0x7f67a82b37c0 0x7f67a82b37f0 0x7f67a82b3820 0x7f67a82b3850 0x7f67a82b3880 0x7f67a82b38b0 0x7f67a82b38e0 0x7f67a82b3910 0x7f67a82b3940 0x7f67a82b3970 0x7f67a82b39a0 0x7f67a82b39d0 0x7f67a82b3a00 0x7f67a82b3a30 0x7f67a82b3a60 0x7f67a82b3a90 0x7f67a82b3ac0 0x7f67a82b3af0 0x7f67a82b3b20 0x7f67a82b3b50 0x7f67a82b3b80 0x7f67a82b3bb0 0x7f67a82b3be0 0x7f67a82b3c10 0x7f67a82b3c40 0x7f67a82b3c70 0x7f67a82b3ca0 0x7f67a82b3cd0 0x7f67a82b3d00 0x7f67a82b3d30 0x7f67a82b3d60 0x7f67a82b3d90 0x7f67a82b3dc0 0x7f67a82b3df0 0x7f67a82b3e20 0x7f67a82b3e50 0x7f67a82b3e80 0x7f67a82b3eb0 0x7f67a82b3ee0 0x7f67a82b3f10 0x7f67a82b3f40 0x7f67a82b3f70 0x7f67a82b3fa0 0x7f6793baa020 0x7f6793baa050 0x7f6793baa080 0x7f6793baa0b0 0x7f6793baa0e0 0x7f6793baa110 0x7f6793baa140 0x7f6793baa170 0x7f6793baa1a0 0x7f6793baa1d0 0x7f6793baa200 0x7f6793baa230 0x7f6793baa260 0x7f6793baa290 0x7f6793baa2c0 0x7f6793baa2f0 0x7f6793baa320 0x7f6793baa350 0x7f6793baa380 0x7f6793baa3b0 0x7f6793baa3e0 0x7f6793baa410 0x7f6793baa440 0x7f6793baa470 0x7f6793baa4a0 0x7f6793baa4d0 0x7f6793baa500 0x7f6793baa530 0x7f6793baa560 0x7f6793baa590 0x7f6793baa5c0 0x7f6793baa5f0 0x7f6793baa620 0x7f6793baa650 0x7f6793baa680 0x7f6793baa6b0 0x7f6793baa6e0 0x7f6793baa710 0x7f6793baa740 0x7f6793baa770 0x7f6793baa7a0 0x7f6793baa7d0 0x7f6793baa800 0x7f6793baa830 0x7f6793baa860 0x7f6793baa890 0x7f6793baa8c0 0x7f6793baa8f0 0x7f6793baa920}
editPowerVia -bottom_layer M1 -top_layer M2 -selected_wires 1 -exclude_stack_vias 0 -add_vias 1 -orthogonal_only 0 -via_using_exact_crossover_size 1 -uda VIA12_Manual -skip_via_on_pin {pad cover} -skip_via_on_wire_shape {Blockring Corewire Blockwire Iowire Padring Ring Fillwire Noshape}
deselectAll
setPinConstraint -cell top -pin * -layer {M6 M7}
setPinAssignMode -pinEditInBatch true
editPin -pin {CLK EN RSTN out_clk} -snap TRACK -use SIGNAL -spreadType RANGE -spreadDirection clockwise -side TOP -start {54.608 177.408} -end {161.608 177.408} -layer M7 -fixOverlap 1 -fixedPin 1
saveDesign top.design_planning.enc
checkFPlan
verify_PG_short -no_routing_blkg -no_cell_blkg -report ../reports/layout/top-dp.pg-short
verify_drc
report_design                          >  ../reports/layout/${rm_core_top}-dp.summary
report_case_analysis -all -nosplit     >  ../reports/layout/${rm_core_top}-dp.set_case
saveFPlan ../reports/layout/top-dp_dump.fp
