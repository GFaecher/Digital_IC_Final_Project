module ro (
  input logic EN,
  output logic CLK
  );

  logic node0, node1;
 ND2D4BWP16P90 nand1(.A1(EN), .A2(CLK), .ZN(node0));
 INVD2BWP16P90 inv1(.I(node0), .ZN(node1)); 
 INVD2BWP16P90 inv2(.I(node1), .ZN(CLK));
 endmodule
