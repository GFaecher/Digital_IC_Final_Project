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

    initial begin
        $sdf_annotate("../data/ro_netlist.sdf",top_tb.dut.dco_uut,,,"MAXIMUM");
        $dumpfile("top_tb.vcd");
        $dumpvars;
    end

    initial ref_clk = 0;
    always #5 ref_clk = ~ref_clk;

    initial begin
        rstn = 1'b0;
        en = 1'b0;
        #10;
        rstn = 1'b1;
        en = 1'b1;
        #100;
        $finish;
    end

endmodule