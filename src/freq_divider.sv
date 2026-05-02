module freq_divider (
    input logic DCO_output,
    input logic rstn, // active low
    input logic en,
    output logic PFD_input
);

// Dividing by too much will lead to oversampling of the up and down outputs of the
// PFD which leads to over compensation by the DCO meaning bigger swings from
// too fast to too slow and will take longer to reach steady state

// Dividing by too little will miss up and down outputs all together and PLL
// will not function as intented

logic half_freq;
logic quarter_freq;
logic eighth_freq; // this one should do


always_ff @(posedge DCO_output or negedge reset) begin
    if (!reset) begin
        half_freq <= 0;
    end else if (en) begin
        half_freq <= !half_freq;
    end
end

always_ff @(posedge half_freq or negedge reset) begin
    if (!reset) begin
        quarter_freq <= 0;
    end else if (en) begin
        quarter_freq <= !quarter_freq;
    end 
end
always_ff @(posedge quarter_freq or negedge reset) begin
    if (!reset) begin
        eighth_freq <= 0;
    end else if (en) begin
        eighth_freq <= !eighth_freq;
    end
end

assign PFD_input = eighth_freq;
