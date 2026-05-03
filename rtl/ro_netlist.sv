`timescale 1ns/1ps

/* Reference Implmentation:
module ro (
  input logic EN,
  output logic CLK
  );

  logic node0, node1;
 ND2D4BWP16P90 nand1(.A1(EN), .A2(CLK), .ZN(node0));
 INVD2BWP16P90 inv1(.I(node0), .ZN(node1)); 
 INVD2BWP16P90 inv2(.I(node1), .ZN(CLK));
 endmodule
*/

/* Decided to use module CKBD16BWP16P90 (I, Z), and here's why:
CKB (Clock Buffer)
D2 (Drive Strength 2) Want Most even rise and fall delays
generated is as accurate as possible. Central to our design, so more power use
is acceptable
BWP (tapless design) They all have this
16 (gate length) smallest gate in library, which should help with speed
P90 (contact to poly pitch) They all have this
Could use LVT cells, but they may not be necessary

These are the muxs we use for the same reasons as above:
MUX3ND4BWP16P90(I0, I1, I2, S0, S1, ZN);
MUX2ND4BWP16P90(I0, I1, S, ZN);

This is the Nand gate we use for the capacitor:
ND4D4BWP16P90(A1, A2, A3, A4, ZN);

*/

module ro_netlist (
    input   logic [3:0]     CTRL,
    input   logic           NAND_CTRL1,
    input   logic           NAND_CTRL2,
    input   logic           NAND_CTRL3,
    output  logic           CLK

);

logic delay_out_1, delay_out_2, delay_out_3, delay_out_4, delay_out_5, delay_out_6, delay_out_7, delay_out_8, delay_out_9, delay_out_10;
logic delay_out_11, delay_out_12, delay_out_13, delay_out_14, delay_out_15, delay_out_16, delay_out_17, delay_out_18;
logic mux_1_1out, mux_1_2out, mux_1_3out, mux_1_4out, mux_1_5out, mux_1_6out;
logic mux_2_1out, mux_2_2out;
logic mux_out;
logic start_inv_out;

ND4D4BWP16P90 nand_gate_capacitor(.A1(mux_out), .A2(NAND_CTRL1), .A3(NAND_CTRL2), .A4(NAND_CTRL2));

INVD2BWP16P90 start_inv(.I(mux_out), .ZN(start_inv_out));

CKBD2BWP16P90 delay_element1(.I(start_inv_out), .Z(delay_out_1));
CKBD2BWP16P90 delay_element2(.I(delay_out_1), .Z(delay_out_2));
CKBD2BWP16P90 delay_element3(.I(delay_out_2), .Z(delay_out_3));
CKBD2BWP16P90 delay_element4(.I(delay_out_3), .Z(delay_out_4));
CKBD2BWP16P90 delay_element5(.I(delay_out_4), .Z(delay_out_5));
CKBD2BWP16P90 delay_element6(.I(delay_out_5), .Z(delay_out_6));
CKBD2BWP16P90 delay_element7(.I(delay_out_6), .Z(delay_out_7));
CKBD2BWP16P90 delay_element8(.I(delay_out_7), .Z(delay_out_8));
CKBD2BWP16P90 delay_element9(.I(delay_out_8), .Z(delay_out_9));
CKBD2BWP16P90 delay_element10(.I(delay_out_9), .Z(delay_out_10));
CKBD2BWP16P90 delay_element11(.I(delay_out_10), .Z(delay_out_11));
CKBD2BWP16P90 delay_element12(.I(delay_out_11), .Z(delay_out_12));
CKBD2BWP16P90 delay_element13(.I(delay_out_12), .Z(delay_out_13));
CKBD2BWP16P90 delay_element14(.I(delay_out_13), .Z(delay_out_14));
CKBD2BWP16P90 delay_element15(.I(delay_out_14), .Z(delay_out_15));
CKBD2BWP16P90 delay_element16(.I(delay_out_15), .Z(delay_out_16));
CKBD2BWP16P90 delay_element17(.I(delay_out_16), .Z(delay_out_17));
CKBD2BWP16P90 delay_element18(.I(delay_out_17), .Z(delay_out_18));

// Code for an 18 input mux

MUX3ND4BWP16P90 mux_1_1(.I0(delay_out_1), .I1(delay_out_2), .I2(delay_out_3), .S0(CTRL[0]), .S1(CTRL[1]), .ZN(mux_1_1out));
MUX3ND4BWP16P90 mux_1_2(.I0(delay_out_4), .I1(delay_out_5), .I2(delay_out_6), .S0(CTRL[0]), .S1(CTRL[1]), .ZN(mux_1_2out));
MUX3ND4BWP16P90 mux_1_3(.I0(delay_out_7), .I1(delay_out_8), .I2(delay_out_9), .S0(CTRL[0]), .S1(CTRL[1]), .ZN(mux_1_3out));
MUX3ND4BWP16P90 mux_1_4(.I0(delay_out_10), .I1(delay_out_11), .I2(delay_out_12), .S0(CTRL[0]), .S1(CTRL[1]), .ZN(mux_1_4out));
MUX3ND4BWP16P90 mux_1_5(.I0(delay_out_13), .I1(delay_out_14), .I2(delay_out_15), .S0(CTRL[0]), .S1(CTRL[1]), .ZN(mux_1_5out));
MUX3ND4BWP16P90 mux_1_6(.I0(delay_out_16), .I1(delay_out_17), .I2(delay_out_18), .S0(CTRL[0]), .S1(CTRL[1]), .ZN(mux_1_6out));

MUX3ND4BWP16P90 mux_2_1(.I0(mux_1_1out), .I1(mux_1_2out), .I2(mux_1_3out), .S0(CTRL[2]), .S1(CTRL[3]), .ZN(mux_2_1out));
MUX3ND4BWP16P90 mux_2_2(.I0(mux_1_4out), .I1(mux_1_5out), .I2(mux_1_6out), .S0(CTRL[2]), .S1(CTRL[3]), .ZN(mux_2_2out));

MUX2ND4BWP16P90 mux_3(.I0(mux_2_1out), .I1(mux_2_2out), .S(CTRL[4]), .ZN(mux_out));



endmodule
