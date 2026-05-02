`timescale 1ns/1ps

module ro_netlist (
    input   logic           EN,
    input   logic [4:0]     CTRL,
    input   logic           NAND_CTRL1,
    input   logic           NAND_CTRL2,
    input   logic           NAND_CTRL3,
    output  logic           CLK

);

// JUST FOR SYNTHESIS
// genus will treat it like a shell or black box since its included in the
// macro.vc

endmodule