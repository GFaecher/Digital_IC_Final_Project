`timescale 1ns/1ps

module top_tb;
    
    logic CLK;
    logic EN;
    logic RSTN;
    logic out_clk;

    top dut (
        .CLK(CLK),
        .EN(EN),
        .RSTN(RSTN),
        .out_clk(out_clk)
    );

    initial begin
        $sdf_annotate("../data/top.sdf",top_tb.dut,,,"MAXIMUM");
        $dumpfile("top_tb.vcd");
        $dumpvars;
    end

    task generate_wave(
        input real freq_ghz,
        input real duration_ns
        );
        real half_period_ns;
        real elapsed_ns;
        integer half_cycles;
        integer i;

        half_period_ns = (1.0 / freq_ghz) / 2.0;
        half_cycles    = $rtoi(duration_ns / half_period_ns);

        for (i = 0; i < half_cycles; i++) begin
            CLK = ~CLK;
            #(half_period_ns);
        end
    endtask

    initial begin
        CLK = 1'b0;
        RSTN = 1'b0;
        EN = 1'b0;
        #200;
        RSTN = 1'b1;
        #50;
        EN = 1'b1;
        generate_wave(0.1825, 1000.0);
        #10;
        $finish;
    end

endmodule