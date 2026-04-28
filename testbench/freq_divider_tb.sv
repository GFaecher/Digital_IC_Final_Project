`timescale 1ns/1ps

module freq_divider_tb();

    logic DCO_output_tb;
    logic PFD_input_tb;
    logic rstn_tb;

    freq_divider dut (
        .DCO_output (DCO_output_tb),
        .rstn (rstn_tb),
        .PFD_input (PFD_input_tb)
    );

    initial begin
      $dumpfile("FIR_63TAP.vcd");
      $dumpvars;
      // initialize
      rstn_tb = 1'b0;
      DCO_output_tb = 1'b0; 
      #5; // wait 5 cycles
      rstn_tb = 1'b1;
      for(int i = 0; i < 80; i = i + 1) begin
          #0.5 DCO_output_tb = ~DCO_output_tb;
      end

    end 
endmodule