if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name ss_0p72v_m40c_lib_set\
   -timing\
    [list ${::IMEX::libVar}/mmmc/N16ADFP_StdCellss0p72vm40c_ccs.lib\
    ${::IMEX::libVar}/mmmc/N16ADFP_SRAM_ss0p72v0p72vm40c_100a.lib]
create_library_set -name ff_0p88v_125c_lib_set\
   -timing\
    [list ${::IMEX::libVar}/mmmc/N16ADFP_StdCellff0p88v125c_ccs.lib\
    ${::IMEX::libVar}/mmmc/N16ADFP_SRAM_ff0p88v0p88v125c_100a.lib]
create_library_set -name tt_0p8v_25c_lib_set\
   -timing\
    [list ${::IMEX::libVar}/mmmc/N16ADFP_StdCelltt0p8v25c_ccs.lib\
    ${::IMEX::libVar}/mmmc/N16ADFP_SRAM_tt0p8v0p8v25c_100a.lib]
create_rc_corner -name rc_worst_m40c\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T -40\
   -qx_tech_file ${::IMEX::libVar}/mmmc/rc_worst_m40c/qrcTechFile
create_rc_corner -name rc_typ_25c\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 25\
   -qx_tech_file ${::IMEX::libVar}/mmmc/rc_typ_25c/qrcTechFile
create_rc_corner -name rc_best_125c\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 125\
   -qx_tech_file ${::IMEX::libVar}/mmmc/rc_typ_25c/qrcTechFile
create_delay_corner -name tt_0p8v_25c_delay_corner\
   -library_set tt_0p8v_25c_lib_set\
   -rc_corner rc_typ_25c
create_delay_corner -name ss_0p72v_m40c_delay_corner\
   -library_set ss_0p72v_m40c_lib_set\
   -rc_corner rc_worst_m40c
create_delay_corner -name ff_0p88v_125c_delay_corner\
   -library_set ff_0p88v_125c_lib_set\
   -rc_corner rc_best_125c
create_constraint_mode -name tt0p8v25c_mode\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/constraints.tcl]
create_constraint_mode -name ss0p72vm40c_mode\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/ss0p72vm40c_mode/ss0p72vm40c_mode.sdc]
create_constraint_mode -name ff0p88v125c_mode\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/ff0p88v125c_mode/ff0p88v125c_mode.sdc]
create_analysis_view -name normBC -constraint_mode ff0p88v125c_mode -delay_corner ff_0p88v_125c_delay_corner -latency_file ${::IMEX::dataVar}/mmmc/views/normBC/latency.sdc
create_analysis_view -name typical -constraint_mode tt0p8v25c_mode -delay_corner tt_0p8v_25c_delay_corner
create_analysis_view -name normWC -constraint_mode ss0p72vm40c_mode -delay_corner ss_0p72v_m40c_delay_corner -latency_file ${::IMEX::dataVar}/mmmc/views/normWC/latency.sdc
set_analysis_view -setup [list normWC] -hold [list normBC]
