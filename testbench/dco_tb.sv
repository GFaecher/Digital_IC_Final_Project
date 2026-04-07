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

    real    t_rise_prev, t_rise_curr, period;
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

        // ---- startup kick: force node[0] high for one delta ----
        // This breaks the all-zero deadlock and starts oscillation
        force uut.node[0] = 1'b1;
        #2;
        release uut.node[0];

        #20;
        en = 1'b1;
        #50;  // let the ring settle before measuring

        $display("ctrl_vals  = [");
        for (ctrl_idx = 0; ctrl_idx < 24; ctrl_idx = ctrl_idx + 1) begin
            ctrl = ctrl_idx[5:0];
            #50;   // settling time after ctrl switch
            if (ctrl_idx < 23)
                $display("    %0d,", ctrl_idx);
            else
                $display("    %0d", ctrl_idx);
        end
        $display("]");

        $display("tap_stages = [");
        for (ctrl_idx = 0; ctrl_idx < 24; ctrl_idx = ctrl_idx + 1) begin
            if (ctrl_idx < 23)
                $display("    %0d,", 2*ctrl_idx + 3);
            else
                $display("    %0d", 2*ctrl_idx + 3);
        end
        $display("]");

        // reset and re-run for period measurement
        en = 1'b0;
        #10;
        force uut.node[0] = 1'b1;
        #2;
        release uut.node[0];
        #20;
        en = 1'b1;
        #50;

        $display("periods_ns = [");
        for (ctrl_idx = 0; ctrl_idx < 24; ctrl_idx = ctrl_idx + 1) begin
            ctrl = ctrl_idx[5:0];
            #50;   // settle
            measure_period(period);
            if (ctrl_idx < 23)
                $display("    %.6f,", period);
            else
                $display("    %.6f", period);
        end
        $display("]");

        $finish;
    end

    initial begin
        #500_000;
        $display("[TIMEOUT]");
        $finish;
    end

endmodule