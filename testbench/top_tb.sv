`timescale 1ns/1ps

module top_tb;
    
    reg ref_clk;
    reg en;
    reg rstn;
    wire out_clk;

    top dut (
        .ref_clk (ref_clk),
        .en (en),
        .rstn (rstn),
        .out_clk (out_clk)
    );

    initial ref_clk = 0;
    always #5 ref_clk = ~ref_clk;

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars;
        rstn = 1'b0;
        en = 1'b0;
        #10;
        rstn = 1'b1;
        en = 1'b1;
        #1000;
    end

endmodule