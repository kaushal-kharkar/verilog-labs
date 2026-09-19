// tb.v
// Self-checking testbench for lut.v using a parameter override.
// Loops sel through every valid address and checks dout == sel*sel.

module tb;

  // Test configuration -- different from lut's defaults (WIDTH=8, DEPTH=4).
  // Change these two numbers to test another size; everything else follows.
  localparam T_WIDTH = 8;
  localparam T_DEPTH = 8;

  // Inputs and outputs
  reg  [$clog2(T_DEPTH)-1:0] t_sel;     // 3 bits for DEPTH=8
  wire [T_WIDTH-1:0]         t_dout;

  // Checking variables
  integer            i;
  integer            errors;
  reg  [T_WIDTH-1:0] exp_dout;

  // DUT instantiation with parameter override (#(...) syntax)
  lut #(
    .WIDTH (T_WIDTH),
    .DEPTH (T_DEPTH)
  ) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;

    // Walk through every valid address, 5 time units apart
    for (i = 0; i < T_DEPTH; i = i + 1) begin
      t_sel = i;
      #5;
      exp_dout = i * i;                   // same formula the ROM was loaded with
      if (t_dout !== exp_dout) begin
        $display("FAIL at time %0t: sel=%0d  got dout=%0d  expected %0d",
                 $time, t_sel, t_dout, exp_dout);
        errors = errors + 1;
      end
    end

    $display("LUT test (WIDTH=%0d, DEPTH=%0d): %0d of %0d addresses passed",
             T_WIDTH, T_DEPTH, T_DEPTH - errors, T_DEPTH);
    $finish;
  end

  initial
    $monitor($time, " sel=%0d | dout=%0d (%b)", t_sel, t_dout, t_dout);

endmodule