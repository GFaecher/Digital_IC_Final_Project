module accumulator (
    input logic up,
    input logic down,
    input logic clk,
    input logic rstn, // active low
    output logic [4:0] controlWord,
    output logic nand1,
    output logic nand2,
    output logic nand3
);

  logic [6:0] sum;

// need to incorperate another output for the nand4 or somehow run the nand4 off
// same controlWord
always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        // lowest possible value means fastest possible clock for fastest 
        // sampling for quickest convergence to locked loop 
        nand1 <= 1'b0;
        nand2 <= 1'b0;
        nand3 <= 1'b0;
        sum <= 8'b0;
    end else begin 
        if (up && !down && sum != 8'd0) begin
            // feedback is behind reference, speed up (subtract transistors)
            sum <= sum - 1;
        end else if (down && !up && sum != 8'd255) begin
            // feedback is ahead of reference, slow down (add transistors)
            sum <= sum + 1;
        end 

        // this creates 3 inputs for our frequency fine tuning by driving delay
        // of ring oscillator with nand4 variable capacitance

      if (sum[1:0] > 2'd0) begin
            // if the control word's 2 LSBs are greater than 0 (01, 10, 11,
            // 100, etc) turn on one of the NAND4 inputs
            nand1 <= 1'b1;
        end else begin
            nand1 <= 1'b0;
        end
      if (sum[1:0] > 2'd1) begin
            // if 2 LSBs are greater than 01 (second one turns on if need more
            // than just the first)
            nand2 <= 1'b1;
        end else begin
            nand2 <= 1'b0;
        end
      if (sum[1:0] > 2'd2) begin
            // if 2 LSBs are greater than 10 (first two on) then turn on third one
            nand3 <= 1'b1;
        end else begin
            nand3 <= 1'b0;
        end
    end 
end

// course adjustsments (# of inverters) get the 5 MSBs
  assign controlWord = sum[6:2];

endmodule