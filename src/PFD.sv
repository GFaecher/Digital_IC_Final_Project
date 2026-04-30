// PFD Module for Digital IC Final Project
// Phase Frequency Detector (PFD) implementation in SystemVerilog
// Overview:
// -- Two D flip flops (UP and DOWN) to detect the phase difference between FREF and FCLOCK
// -- and AND gate to reset the flip flops when both are high
`include "RTL.svh"

module PFD (
    input logic     FREF,
    input logic     FDCO,
    input logic     RSTN,
    input logic     EN,
    
    output logic    UP,
    output logic    DOWN
);  
    logic Q_UP;
    logic Q_DOWN;
    logic AND_RESET;

`FF(1'b1, Q_UP, FREF, EN, FF_RESET, 1'b0) // If Up is active for a long time, slow down feedback clock
`FF(1'b1, Q_DOWN, FDCO, EN, FF_RESET, 1'b0) // If Down is active for a long time, speed up feedback clock

assign FF_RESET = AND_RESET || !RSTN;
assign AND_RESET = Q_UP && Q_DOWN;
assign UP = Q_UP;
assign DOWN = Q_DOWN;


endmodule