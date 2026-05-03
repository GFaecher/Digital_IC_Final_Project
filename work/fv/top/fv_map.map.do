
//input ports
add mapped point CLK CLK -type PI PI
add mapped point EN EN -type PI PI
add mapped point RSTN RSTN -type PI PI

//output ports
add mapped point out_clk out_clk -type PO PO

//inout ports




//Sequential Pins
add mapped point accum_uut/sum[5]/q accum_uut_sum_reg[5]/Q -type DFF DFF
add mapped point accum_uut/sum[4]/q accum_uut_sum_reg[4]/Q -type DFF DFF
add mapped point accum_uut/sum[3]/q accum_uut_sum_reg[3]/Q -type DFF DFF
add mapped point accum_uut/sum[2]/q accum_uut_sum_reg[2]/Q -type DFF DFF
add mapped point accum_uut/sum[1]/q accum_uut_sum_reg[1]/Q -type DFF DFF
add mapped point accum_uut/sum[0]/q accum_uut_sum_reg[0]/Q -type DFF DFF
add mapped point accum_uut/nand1/q accum_uut_nand1_reg/Q -type DFF DFF
add mapped point accum_uut/nand3/q accum_uut_nand3_reg/Q -type DFF DFF
add mapped point divide_uut/half_freq/q divide_uut_half_freq_reg/Q -type DFF DFF
add mapped point pfd_uut/Q_DOWN/q pfd_uut_Q_DOWN_reg/Q -type DFF DFF
add mapped point pfd_uut/Q_UP/q pfd_uut_Q_UP_reg/Q -type DFF DFF
add mapped point accum_uut/nand2/q accum_uut_nand2_reg/Q -type DFF DFF
add mapped point divide_uut/quarter_freq/q divide_uut_quarter_freq_reg/Q -type DFF DFF
add mapped point divide_uut/eighth_freq/q divide_uut_eighth_freq_reg/Q -type DFF DFF



//Black Boxes
add mapped point dco_uut dco_uut -type BBOX BBOX



//Empty Modules as Blackboxes
