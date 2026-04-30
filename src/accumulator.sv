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

logic [7:0] sum;

// need to incorperate another output for the nand4 or somehow run the nand4 off
// same controlWord
always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        // lowest possible value means fastest possible clock for fastest 
        // sampling for quickest convergence to locked loop 
        controlWord <= 5'b0;
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

        // Potential Problem: There are dead spots between 1, 2, and 3 nand4
        // inputs turning on (could lower so they occur sequentially with only 2
        // LSB)
        if (sum[0:2] > 3'd0) begin
            // if the control word's 3 LSBs are greater than 0 (001, 010, 011,
            // 100, etc) turn on one of the NAND4 inputs
            nand1 <= 1'b1;
        end else begin
            nand1 <= 1'b0;
        end
        if (sum[0:2] > 3'd1) begin
            // if 3 LSBs are greater than 1 (second one turns on if need more
            // than just the first)
            nand2 <= 1'b1;
        end else begin
            nand2 <= 1'b0;
        end
        if (sum[0:2] > 3'd3) begin
            // if 3 LSBs are greater than 011 (first two on) then turn on third one
            nand3 <= 1'b1;
        end else begin
            nand3 <= 1'b0;
        end
    end 
end

// course adjustsments (# of inverters) get the 5 MSBs
assign control = sum[3:7];

endmodule