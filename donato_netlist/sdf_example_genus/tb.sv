module tb;

  logic CLK, EN;

  ro ro_dut(.CLK, .EN);

   

  initial begin
    EN = 1'b0;
    #100;
    EN = 1'b1;
    #50000;
    $finish();
  end
  
  initial begin
    $sdf_annotate("../data/ro.sdf",tb.ro_dut,,,"MAXIMUM");
  end
endmodule
