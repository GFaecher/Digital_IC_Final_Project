`timescale 1ns/1ps

module dco_tb;

    reg        en;
    reg  [5:0] ctrl;
    wire       clk_out;

    dco #(.N_INV(50), .INV_DELAY(1)) uut (
        .en      (en),
        .ctrl    (ctrl),
        .clk_out (clk_out)
    );

    real    t_rise_prev, t_rise_curr, period, freq_mhz;
    integer ctrl_idx;

    task automatic measure_period;
        output real measured_period;
        begin
            @(posedge clk_out);
            t_rise_prev = $realtime;
            @(posedge clk_out);
            t_rise_curr = $realtime;
            measured_period = t_rise_curr - t_rise_prev;
        end
    endtask

    initial begin
        en   = 1'b0;
        ctrl = 6'd0;
        #5;

        force uut.node[0] = 1'b1;
        #2;
        release uut.node[0];
        #20;

        en = 1'b1;
        #50;

        for (ctrl_idx = 0; ctrl_idx < 24; ctrl_idx = ctrl_idx + 1) begin
            ctrl = ctrl_idx[5:0];
            #50;
            measure_period(period);

            // Convert period (ns) to frequency (MHz)
            freq_mhz = 1000.0 / period;

            $display("CTRL: %0d, Freq: %.3f MHz", ctrl_idx, freq_mhz);
        end

        $finish;
    end

    initial begin
        #500_000;
        $display("[TIMEOUT]");
        $finish;
    end

endmodule
