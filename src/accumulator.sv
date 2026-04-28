module accumulator (
    input logic up,
    input logic down,
    input logic clk,
    input logic reset; // active low
    output logic [5:0] controlWord
);

// need to incorperate another output for the nand4 or somehow run the nand4 off
// same controlWord
always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        // lowest possible value means fastest possible clock for fastest 
        // sampling for quickest convergence to locked loop 
        controlWord <= 6'b0;
    end else begin 
        if (up && !down && controlWord != 6'b0) begin
            // feedback is behind reference, speed up (subtract transistors)
            controlWord <= controlWord - 1;
        end else if (down && !up && controlWord != 6'b63) begin
            // feedback is ahead of reference, slow down (add transistors)
            controlWord <= controlWord + 1;
        end 
    end 
end