module tb_netlist;

  logic [3:0] CTRL;
  logic NAND_CTRL1, NAND_CTRL2, NAND_CTRL3;
  logic CLK;
  logic EN;

  ro_netlist ro_dut(.EN(EN), .CTRL(CTRL), .NAND_CTRL1(NAND_CTRL1), .NAND_CTRL2(NAND_CTRL2), .NAND_CTRL3(NAND_CTRL3), .CLK(CLK));

   

  initial begin
    EN = 1'b0;
    #10;
    EN = 1'b1;
    CTRL = 4'b0000;
    #10;
    CTRL = 4'b0001;
    #10;
    CTRL = 4'b0010;
    #10;
    CTRL = 4'b0011;
    #10;
    CTRL = 4'b0100;
    #10;
    CTRL = 4'b0101;
    #10;
    CTRL = 4'b0110;
    #10;
    CTRL = 4'b0111;
    #10;
    CTRL = 4'b1000;
    #10;
    CTRL = 4'b1001;
    #10;
    CTRL = 4'b1010;
    #10;
    CTRL = 4'b1011;
    #10;
    CTRL = 4'b1100;
    #10;
    CTRL = 4'b1101;
    #10;
    CTRL = 4'b1110;
    #10;
    CTRL = 4'b1111;
    #10;
    $finish();
  end
  
  initial begin
    $sdf_annotate("../data/ro_netlist.sdf",tb_netlist.ro_dut,,,"MAXIMUM");
    $dumpfile("ro_netlist.vcd");
    $dumpvars;
  end
endmodule