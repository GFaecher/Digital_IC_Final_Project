`timescale 1ns/1ps

module dco #(
    parameter N_INV    = 50,
    parameter INV_DELAY = 1   // propagation delay per inverter (ns)
)(
    input  wire       en,
    input  wire [5:0] ctrl,
    output wire       clk_out
);

    wire [N_INV:0] node;

    genvar k;
    generate
        for (k = 0; k < N_INV; k = k + 1) begin : inv_chain
            (* keep = "true" *)
            assign #INV_DELAY node[k+1] = ~node[k]; // TODO: When ready, take out the delay
        end
    endgenerate

    reg  mux_out;
    integer i;

    always @(*) begin
        mux_out = 1'b0;
        for (i = 0; i < 24; i = i + 1) begin
            if (ctrl == i[5:0])
                mux_out = node[2*i + 3];
        end
    end

    wire ring_fb;
    assign ring_fb = mux_out & en;
    assign node[0] = ring_fb;
    assign clk_out = ring_fb;

endmodule