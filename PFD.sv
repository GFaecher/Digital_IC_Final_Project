// PFD Module for Digital IC Final Project
// Phase Frequency Detector (PFD) implementation in SystemVerilog
// Overview:
// -- Two D flip flops (UP and DOWN) to detect the phase difference between FREF and FCLOCK
// -- and AND gate to reset the flip flops when both are high
`include "RTL.svh"

module PFD (
    input logic     VDD,
    input logic     FREF,
    input logic     FVCO,
    input logic     RSTN,
    input logic     EN,
    
    output logic    UP,
    output logic    DOWN
);  
    logic Q_UP;
    logic Q_DOWN;
    logic AND_RESET;

`FF(VDD, Q_UP, FREF, EN, AND_RESET, 1'b0)
`FF(VDD, Q_DOWN, FVCO, EN, AND_RESET, 1'b0)

assign AND_RESET = Q_UP && Q_DOWN;
assign UP = Q_UP;
assign DOWN = Q_DOWN;


endmodule