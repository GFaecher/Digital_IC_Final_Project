`timescale 1ns/1ps

module accumulator_tb();

    logic up_tb;
    logic down_tb;
    logic clk_tb;
    logic rstn_tb;
    logic controlWord_tb;
    logic nand1_tb;
    logic nand2_tb;
    logic nand3_tb;

    accumulator dut (
        .up (up_tb),
        .down (down_tb),
        .clk (clk_tb),
        .rstn (rstn_tb),
        .controlWord (controlWord_tb),
        .nand1 (nand1_tb),
        .nand2 (nand2_tb),
        .nand3 (nand3_tb)
    );

    initial clk_tb = 0;
    always #1 clk_tb = ~clk_tb
    initial begin
        $dumpfile("accumulator_tb.vcd");
        $dumpvars;
        rstn_tb = 1'b0;
        up_tb = 1'b0;
        down_tb = 1'b0;
        #5;
        rstn_tb = 1'b1;
        #1
        for (int i = 0; i < 100; i++) begin
            #8
        end
    end

endmodule