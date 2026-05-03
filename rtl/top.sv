`timescale 1ns/1ps

module top (
    input logic CLK,
    input logic EN,
    input logic RSTN,
    output logic out_clk
);

logic divider_out;
logic up_out;
logic down_out;
logic dco_out;
logic [3:0] cWord;
logic nand1_out;
logic nand2_out;
logic nand3_out;

PFD pfd_uut (
    .FREF (CLK),
    .FDCO (divider_out),
    .RSTN (RSTN),
    .EN (EN),
    .UP (up_out),
    .DOWN (down_out)
);

accumulator accum_uut (
    .up (up_out),
    .down (down_out),
    .clk (dco_out),
    .rstn (RSTN),
    .en (EN),
    .controlWord (cWord),
    .nand1 (nand1_out),
    .nand2 (nand2_out),
    .nand3 (nand3_out)
);

ro_netlist dco_uut (
    .EN (EN),
    .CTRL (cWord),
    .NAND_CTRL1 (nand1_out),
    .NAND_CTRL2 (nand2_out),
    .NAND_CTRL3 (nand3_out),
    .CLK (dco_out)
);

freq_divider divide_uut (
    .DCO_output (dco_out),
    .rstn (RSTN),
    .en (EN),
    .PFD_input (divider_out)
);

assign out_clk = divider_out;

endmodule