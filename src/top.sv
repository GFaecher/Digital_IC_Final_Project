module top (
    input logic ref_clk,
    input logic en,
    input logic rstn,
    output logic out_clk
);

logic divider_out;
logic up_out;
logic down_out;
logic dco_out;
logic [4:0] cWord;
logic nand1_out;
logic nand2_out;
logic nand3_out;

PFD pfd_uut (
    .FREF (ref_clk),
    .FDCO (divider_out),
    .RSTN (rstn),
    .EN (en),
    .UP (up_out),
    .DOWN (down_out)
);

accumulator accum_uut (
    .up (up_out),
    .down (down_out),
    .clk (dco_out),
    .rstn (rstn),
    .controlWord (cWord),
    .nand1 (nand1_out),
    .nand2 (nand2_out),
    .nand3 (nand3_out)
);

ro_netlist dco_uut (
    .CTRL (cWord),
    .NAND_CTRL1 (nand1_out),
    .NAND_CTRL2 (nand2_out),
    .NAND_CTRL3 (nand3_out),
    .CLK (dco_out)
);

freq_divider divide_uut (
    .DCO_output (dco_out),
    .rstn (rstn),
    .PFD_input (divider_out)
);