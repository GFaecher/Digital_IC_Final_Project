#####################################################################################
# Compile script for the ${rm_core_top}
#####################################################################################

sh hostname
date

set start_time [clock seconds]

set rm_task synthesis

# -----------------------------------------------------------------------------------
# Setup the Configuration
# -----------------------------------------------------------------------------------

source -echo -verbose ../scripts/core_config.tcl

# -----------------------------------------------------------------------------------
# Setup the Target Technology
# -----------------------------------------------------------------------------------
source -echo -verbose ../scripts/tech.tcl

set_db information_level 9

set_db tns_opto true
set_db lp_insert_clock_gating false
set_db use_scan_seqs_for_non_dft false
set_db timing_report_load_unit pf
set_db timing_report_time_unit ps

# -----------------------------------------------------------------------------------
# Setup Library
# -----------------------------------------------------------------------------------


set link_library [concat ${ss_0p72v_m40c_libs} ${ff_0p88v_125c_libs} ]
set_db library ${link_library}
set_db lbr_seq_in_out_phase_opto true

# -----------------------------------------------------------------------------------
# Read in list of dont_use cells
# -----------------------------------------------------------------------------------

foreach dont_use ${rm_dont_use_list} {
  set_dont_use [get_lib_cells */${dont_use} ]
}


source -verbose ../scripts/init_genus.tcl

syn_generic
write_hdl > ../data/${rm_core_top}-map.v
syn_map

check_design -unresolved > ../reports/compile/${rm_core_top}.check_design 

write_sdf -version 3.0  -precision 4 > ../data/${rm_core_top}.sdf

report_timing > ../reports/compile/${rm_core_top}.timing
report_area > ../reports/compile/${rm_core_top}.area 
report_power > ../reports/compile/${rm_core_top}.power
report_clock_gating > ../reports/compile/${rm_core_top}.clock_gating
write_hdl > ../data/${rm_core_top}-compile.v 
exit
