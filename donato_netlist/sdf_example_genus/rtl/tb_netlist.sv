module tb_netlist;

  logic [3:0] CTRL;
  logic NAND_CTRL1, NAND_CTRL2, NAND_CTRL3;
  logic CLK;
  logic EN;

  integer       cycle_count;
  real          period_ns;
  real          freq_ghz;
  time          meas_start;
  integer       out_file;                  // <-- file handle
  localparam    MEAS_WINDOW = 20;

  ro_netlist ro_dut(
    .EN(EN),
    .CTRL(CTRL),
    .NAND_CTRL1(NAND_CTRL1),
    .NAND_CTRL2(NAND_CTRL2),
    .NAND_CTRL3(NAND_CTRL3),
    .CLK(CLK)
  );

  task automatic measure_freq(
    input logic n1, input logic n2, input logic n3
  );
    NAND_CTRL1 = n1;
    NAND_CTRL2 = n2;
    NAND_CTRL3 = n3;

    #5;

    cycle_count = 0;
    meas_start  = $time;

    fork
      begin : count_edges
        forever begin
          @(posedge CLK);
          cycle_count = cycle_count + 1;
        end
      end
      begin : timer
        #(MEAS_WINDOW);
      end
    join_any
    disable count_edges;

    if (cycle_count > 1) begin
      period_ns = real'(MEAS_WINDOW) / real'(cycle_count);
      freq_ghz  = 1.0 / period_ns;
      $fdisplay(out_file, "CTRL=%04b | NAND[3:1]=%b%b%b | Cycles=%0d | Period=%.4f ns | Freq=%.4f GHz",
                CTRL, n3, n2, n1, cycle_count, period_ns, freq_ghz);
    end else begin
      $fdisplay(out_file, "CTRL=%04b | NAND[3:1]=%b%b%b | Oscillator not running (cycles=%0d)",
                CTRL, n3, n2, n1, cycle_count);
    end
  endtask

  task automatic sweep_nand_combos();
    integer i;
    for (i = 0; i < 8; i++) begin
      measure_freq(i[0], i[1], i[2]);
    end
  endtask

  initial begin
    EN         = 0;
    CTRL       = 4'b0000;
    NAND_CTRL1 = 0;
    NAND_CTRL2 = 0;
    NAND_CTRL3 = 0;

    // Open output file
    out_file = $fopen("ro_freq_results.txt", "w");
    if (out_file == 0) begin
      $display("ERROR: Could not open output file.");
      $finish();
    end

    #10;
    EN = 1;
    #5;

    $fdisplay(out_file, "============================================================");
    $fdisplay(out_file, "  Ring Oscillator Frequency Sweep");
    $fdisplay(out_file, "  Measurement window: %0d ns", MEAS_WINDOW);
    $fdisplay(out_file, "============================================================");

    for (int c = 0; c < 16; c++) begin
      CTRL = c[3:0];
      #2;
      $fdisplay(out_file, "------------------------------------------------------------");
      sweep_nand_combos();
    end

    $fdisplay(out_file, "============================================================");
    $fdisplay(out_file, "  Sweep complete.");
    $fdisplay(out_file, "============================================================");

    $fclose(out_file);
    $finish();
  end

  initial begin
    $dumpfile("ro_netlist.vcd");
    $dumpvars;
    $sdf_annotate("../data/ro_netlist.sdf", tb_netlist.ro_dut,,, "MAXIMUM");
  end

endmodule