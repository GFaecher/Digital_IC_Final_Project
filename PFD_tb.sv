// =============================================================================
// Testbench: PFD_tb.sv
// Description: Comprehensive testbench for the Phase Frequency Detector (PFD)
//
// Test Cases:
//   1.  Async reset clears UP and DOWN
//   2.  EN=0 prevents FF capture; outputs stay 0
//   3.  FREF leads FVCO -> UP fires first each cycle
//   4.  FVCO leads FREF -> DOWN fires first each cycle
//   5.  Locked (same freq, 0 phase offset) -> pulse widths equal and short
//   6.  FREF faster than FVCO -> avg UP width > avg DOWN width
//   7.  FVCO faster than FREF -> avg DOWN width > avg UP width
//   8.  UP & DOWN never simultaneously high beyond 1 ps (AND-reset deadzone)
//   9.  Mid-run RSTN assertion immediately clears both outputs
//   10. Re-enable (EN: 0->1) restores normal PFD operation
// =============================================================================

`timescale 1ns/1ps
`include "RTL.svh"

module PFD_tb;

    // -------------------------------------------------------------------------
    // DUT Signals
    // -------------------------------------------------------------------------
    logic VDD;
    logic FREF;
    logic FVCO;
    logic RSTN;
    logic EN;
    logic UP;
    logic DOWN;

    // -------------------------------------------------------------------------
    // DUT Instantiation
    // -------------------------------------------------------------------------
    PFD dut (
        .VDD  (VDD),
        .FREF (FREF),
        .FVCO (FVCO),
        .RSTN (RSTN),
        .EN   (EN),
        .UP   (UP),
        .DOWN (DOWN)
    );

    // -------------------------------------------------------------------------
    // Simulation Parameters
    // -------------------------------------------------------------------------
    localparam real REF_PERIOD  = 20.0;   // ns -> 50   MHz reference
    localparam real VCO_PERIOD  = 20.0;   // ns -> 50   MHz (locked / nominal)
    localparam real FAST_PERIOD = 16.0;   // ns -> 62.5 MHz (VCO faster than REF)
    localparam real SLOW_PERIOD = 25.0;   // ns -> 40   MHz (VCO slower than REF)
    localparam real PHASE_LEAD  =  5.0;   // ns phase offset used in lead/lag tests

    // -------------------------------------------------------------------------
    // Score tracking
    // -------------------------------------------------------------------------
    int pass_count = 0;
    int fail_count = 0;

    // -------------------------------------------------------------------------
    // Clock-generator stop flag
    // -------------------------------------------------------------------------
    logic stop_clocks = 1'b1;

    // =========================================================================
    // Task: apply_reset
    //   Asserts RSTN low for hold_ns then releases it.
    // =========================================================================
    task automatic apply_reset(input real hold_ns = 10.0);
        RSTN = 1'b0;
        #(hold_ns);
        RSTN = 1'b1;
        #1;
    endtask

    // =========================================================================
    // Task: check
    //   Logs a named pass/fail result.
    // =========================================================================
    task automatic check(input string name, input logic condition);
        if (condition) begin
            $display("[PASS] %s", name);
            pass_count++;
        end else begin
            $display("[FAIL] %s  | UP=%b DOWN=%b RSTN=%b EN=%b @%0t",
                     name, UP, DOWN, RSTN, EN, $realtime);
            fail_count++;
        end
    endtask

    // =========================================================================
    // Task: start_clocks
    //   Spawns independent FREF and FVCO generators.
    //   vco_start_delay_ns > 0 -> FVCO lags FREF (FREF leads).
    //   vco_start_delay_ns = 0 -> both start simultaneously.
    // =========================================================================
    task automatic start_clocks(
        input real ref_period_ns,
        input real vco_period_ns,
        input real vco_start_delay_ns
    );
        stop_clocks = 1'b0;
        FREF        = 1'b0;
        FVCO        = 1'b0;

        fork
            // FREF generator
            forever begin
                if (stop_clocks) disable fork;
                #(ref_period_ns / 2.0);
                if (!stop_clocks) FREF = ~FREF;
            end
            // FVCO generator (optional startup delay)
            begin
                if (vco_start_delay_ns > 0.0) #(vco_start_delay_ns);
                forever begin
                    if (stop_clocks) disable fork;
                    #(vco_period_ns / 2.0);
                    if (!stop_clocks) FVCO = ~FVCO;
                end
            end
        join_none
    endtask

    // =========================================================================
    // Task: stop_clock_gen
    //   Signals generators to stop and idles both clocks.
    // =========================================================================
    task automatic stop_clock_gen();
        stop_clocks = 1'b1;
        #2;
        FREF = 1'b0;
        FVCO = 1'b0;
    endtask

    // =========================================================================
    // Task: measure_avg_pulse_widths
    //   Samples n_cycles UP/DOWN rising+falling pairs and returns averages.
    // =========================================================================
    task automatic measure_avg_pulse_widths(
        input  int  n_cycles,
        output real up_avg_ns,
        output real dn_avg_ns
    );
        real up_total, dn_total, t_r, t_f;
        up_total = 0.0;
        dn_total = 0.0;
        repeat (n_cycles) begin
            @(posedge UP);  t_r = $realtime;
            @(negedge UP);  t_f = $realtime;
            up_total += (t_f - t_r);

            @(posedge DOWN); t_r = $realtime;
            @(negedge DOWN); t_f = $realtime;
            dn_total += (t_f - t_r);
        end
        up_avg_ns = up_total / n_cycles;
        dn_avg_ns = dn_total / n_cycles;
    endtask

    // =========================================================================
    // Main Test Sequence
    // =========================================================================
    initial begin
        $dumpfile("PFD_tb.vcd");
        $dumpvars(0, PFD_tb);

        // Global init
        VDD  = 1'b1;
        FREF = 1'b0;
        FVCO = 1'b0;
        RSTN = 1'b1;
        EN   = 1'b1;
        #5;

        $display("==========================================================");
        $display("  PFD Testbench");
        $display("  FF macro: always_ff @(posedge clk, negedge rstn)");
        $display("  D=VDD=1 -> Q sets on posedge clk, clears on ~rstn");
        $display("==========================================================");

        // =====================================================================
        // TEST 1: Async reset clears UP and DOWN
        // =====================================================================
        $display("\n--- TEST 1: Async Reset ---");
        start_clocks(REF_PERIOD, VCO_PERIOD, 0.0);
        // Let FFs set so there is something to clear
        @(posedge FREF); @(posedge FREF);
        @(posedge FVCO); @(posedge FVCO);
        #1;
        RSTN = 1'b0; #1;
        check("TEST1a: UP=0 on async reset",    UP   === 1'b0);
        check("TEST1b: DOWN=0 on async reset",   DOWN === 1'b0);
        RSTN = 1'b1;
        stop_clock_gen(); #5;

        // =====================================================================
        // TEST 2: EN=0 prevents FF capture
        // =====================================================================
        $display("\n--- TEST 2: EN=0 Disables FF Capture ---");
        apply_reset();
        EN = 1'b0;
        start_clocks(REF_PERIOD, VCO_PERIOD, 0.0);
        repeat (6) @(posedge FREF); #1;
        check("TEST2a: UP=0 while EN=0",    UP   === 1'b0);
        check("TEST2b: DOWN=0 while EN=0",   DOWN === 1'b0);
        stop_clock_gen();
        EN = 1'b1; #5;

        // =====================================================================
        // TEST 3: FREF leads FVCO -> UP fires before DOWN
        // =====================================================================
        $display("\n--- TEST 3: FREF leads FVCO by %.1f ns -> UP fires first ---", PHASE_LEAD);
        apply_reset();
        // FVCO delayed by PHASE_LEAD -> FREF posedge arrives first
        start_clocks(REF_PERIOD, VCO_PERIOD, PHASE_LEAD);

        begin : test3_blk
            automatic int up_first = 0;
            automatic int N = 10;
            repeat (N) begin
                automatic logic up_won = 1'bx;
                fork
                    begin : t3_up
                        @(posedge UP); up_won = 1'b1; disable t3_dn;
                    end : t3_up
                    begin : t3_dn
                        @(posedge DOWN); up_won = 1'b0; disable t3_up;
                    end : t3_dn
                join
                if (up_won) up_first++;
                @(negedge UP  or negedge DOWN); #1;
                @(negedge UP  or negedge DOWN); #1;
            end
            $display("  UP fired first: %0d / %0d cycles", up_first, N);
            check("TEST3: UP fires before DOWN >= 8/10 cycles", up_first >= 8);
        end : test3_blk

        stop_clock_gen(); apply_reset(); #5;

        // =====================================================================
        // TEST 4: FVCO leads FREF -> DOWN fires before UP
        // =====================================================================
        $display("\n--- TEST 4: FVCO leads FREF by %.1f ns -> DOWN fires first ---", PHASE_LEAD);
        apply_reset();
        stop_clocks = 1'b0;
        FREF = 1'b0; FVCO = 1'b0;
        // FVCO starts immediately; FREF starts after PHASE_LEAD
        fork
            forever begin
                if (stop_clocks) disable fork;
                #(VCO_PERIOD / 2.0);
                if (!stop_clocks) FVCO = ~FVCO;
            end
            begin
                #(PHASE_LEAD);
                forever begin
                    if (stop_clocks) disable fork;
                    #(REF_PERIOD / 2.0);
                    if (!stop_clocks) FREF = ~FREF;
                end
            end
        join_none

        begin : test4_blk
            automatic int dn_first = 0;
            automatic int N = 10;
            repeat (N) begin
                automatic logic dn_won = 1'bx;
                fork
                    begin : t4_up
                        @(posedge UP); dn_won = 1'b0; disable t4_dn;
                    end : t4_up
                    begin : t4_dn
                        @(posedge DOWN); dn_won = 1'b1; disable t4_up;
                    end : t4_dn
                join
                if (dn_won) dn_first++;
                @(negedge UP  or negedge DOWN); #1;
                @(negedge UP  or negedge DOWN); #1;
            end
            $display("  DOWN fired first: %0d / %0d cycles", dn_first, N);
            check("TEST4: DOWN fires before UP >= 8/10 cycles", dn_first >= 8);
        end : test4_blk

        stop_clock_gen(); apply_reset(); #5;

        // =====================================================================
        // TEST 5: Locked condition -> pulse widths equal and short
        // =====================================================================
        $display("\n--- TEST 5: Locked (same freq, 0 phase offset) ---");
        apply_reset();
        start_clocks(REF_PERIOD, VCO_PERIOD, 0.0);

        begin : test5_blk
            automatic real up_w, dn_w;
            measure_avg_pulse_widths(10, up_w, dn_w);
            $display("  Avg UP=%.2f ns  Avg DOWN=%.2f ns", up_w, dn_w);
            check("TEST5a: UP pulse < half period when locked",
                  up_w < REF_PERIOD / 2.0);
            check("TEST5b: DOWN pulse < half period when locked",
                  dn_w < REF_PERIOD / 2.0);
            check("TEST5c: |UP_width - DOWN_width| < 2 ns when locked",
                  (up_w - dn_w < 2.0) && (dn_w - up_w < 2.0));
        end : test5_blk

        stop_clock_gen(); apply_reset(); #5;

        // =====================================================================
        // TEST 6: FREF faster than FVCO -> avg UP width > avg DOWN width
        // =====================================================================
        $display("\n--- TEST 6: FREF %.0f MHz faster than FVCO %.0f MHz ---",
                 1000.0/REF_PERIOD, 1000.0/SLOW_PERIOD);
        apply_reset();
        start_clocks(REF_PERIOD, SLOW_PERIOD, 0.0);

        begin : test6_blk
            automatic real up_w, dn_w;
            measure_avg_pulse_widths(8, up_w, dn_w);
            $display("  Avg UP=%.2f ns  Avg DOWN=%.2f ns", up_w, dn_w);
            check("TEST6: UP avg width > DOWN avg width (FREF faster)", up_w > dn_w);
        end : test6_blk

        stop_clock_gen(); apply_reset(); #5;

        // =====================================================================
        // TEST 7: FVCO faster than FREF -> avg DOWN width > avg UP width
        // =====================================================================
        $display("\n--- TEST 7: FVCO %.0f MHz faster than FREF %.0f MHz ---",
                 1000.0/FAST_PERIOD, 1000.0/REF_PERIOD);
        apply_reset();
        start_clocks(REF_PERIOD, FAST_PERIOD, 0.0);

        begin : test7_blk
            automatic real up_w, dn_w;
            measure_avg_pulse_widths(8, up_w, dn_w);
            $display("  Avg UP=%.2f ns  Avg DOWN=%.2f ns", up_w, dn_w);
            check("TEST7: DOWN avg width > UP avg width (FVCO faster)", dn_w > up_w);
        end : test7_blk

        stop_clock_gen(); apply_reset(); #5;

        // =====================================================================
        // TEST 8: UP & DOWN never simultaneously high beyond 1 ps
        // =====================================================================
        $display("\n--- TEST 8: UP & DOWN not simultaneously high beyond 1 ps ---");
        apply_reset();
        start_clocks(REF_PERIOD, VCO_PERIOD, PHASE_LEAD);

        begin : test8_blk
            automatic int  violations = 0;
            automatic real window_ns  = REF_PERIOD * 30;
            fork
                begin
                    repeat (300) begin
                        @(posedge UP or posedge DOWN);
                        if (UP && DOWN) begin
                            #0.001;   // 1 ps propagation allowance
                            if (UP && DOWN) violations++;
                        end
                    end
                end
                #(window_ns);
            join_any
            disable fork;
            $display("  Overlap violations = %0d", violations);
            check("TEST8: UP & DOWN never both high beyond 1 ps", violations == 0);
        end : test8_blk

        stop_clock_gen(); apply_reset(); #5;

        // =====================================================================
        // TEST 9: Mid-run async reset immediately clears outputs
        // =====================================================================
        $display("\n--- TEST 9: Mid-run RSTN assertion ---");
        apply_reset();
        start_clocks(REF_PERIOD, VCO_PERIOD, PHASE_LEAD);
        repeat (4) @(posedge FREF); #1;
        RSTN = 1'b0; #1;
        check("TEST9a: UP=0 on mid-run reset",    UP   === 1'b0);
        check("TEST9b: DOWN=0 on mid-run reset",   DOWN === 1'b0);
        RSTN = 1'b1;
        stop_clock_gen(); #5;

        // =====================================================================
        // TEST 10: Re-enable (EN: 0->1) restores normal operation
        // =====================================================================
        $display("\n--- TEST 10: EN 0->1 restores PFD operation ---");
        apply_reset();
        EN = 1'b0;
        start_clocks(REF_PERIOD, VCO_PERIOD, PHASE_LEAD);
        repeat (4) @(posedge FREF); #1;
        check("TEST10a: UP=0 while EN=0",    UP   === 1'b0);
        check("TEST10b: DOWN=0 while EN=0",   DOWN === 1'b0);

        EN = 1'b1;   // re-enable
        @(posedge FREF); #1;
        check("TEST10c: UP asserts on first FREF posedge after EN=1", UP === 1'b1);
        @(posedge FVCO); #1;
        check("TEST10d: DOWN asserts on first FVCO posedge after EN=1", DOWN === 1'b1);

        stop_clock_gen(); apply_reset(); #5;

        // =====================================================================
        // Summary
        // =====================================================================
        $display("");
        $display("==========================================================");
        $display("  RESULTS: %0d passed, %0d failed  (total %0d)",
                 pass_count, fail_count, pass_count + fail_count);
        $display("==========================================================");
        if (fail_count == 0)
            $display("  *** ALL TESTS PASSED ***");
        else
            $display("  *** FAILURES DETECTED - inspect PFD_tb.vcd ***");
        $display("");
        $finish;
    end

    // =========================================================================
    // Watchdog: kill runaway simulations
    // =========================================================================
    initial begin
        #500_000;
        $display("[WATCHDOG] Simulation timed out at %0t", $realtime);
        $finish;
    end

    // =========================================================================
    // Signal monitor
    // =========================================================================
    initial begin
        $monitor("[%8.1f ns] RSTN=%b EN=%b | FREF=%b FVCO=%b | UP=%b DOWN=%b",
                 $realtime, RSTN, EN, FREF, FVCO, UP, DOWN);
    end

endmodule