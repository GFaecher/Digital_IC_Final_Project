module tb_netlist;

  logic [3:0] CTRL;
  logic NAND_CTRL1, NAND_CTRL2, NAND_CTRL3;
  logic CLK;

  ro_netlist ro_dut(.CTRL(CTRL), .NAND_CTRL1(NAND_CTRL1), .NAND_CTRL2(NAND_CTRL2), .NAND_CTRL3(NAND_CTRL3), .CLK(CLK));

   

  initial begin
    EN = 1'b0;
    #100;
    EN = 1'b1;
    #50000;
    $finish();
  end
  
  initial begin
    $sdf_annotate("../data/ro_netlist.sdf",tb.ro_dut,,,"MAXIMUM");
  end
endmodule
