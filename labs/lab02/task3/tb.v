// tb.v
// Self-checking testbench for comp2.v (2-bit unsigned magnitude comparator).
// Applies all 16 (A,B) combinations, computes the expected GT/LT/EQ
// independently, compares with !==, counts errors, prints a summary.

module tb;

  // DUT inputs (driven procedurally) and outputs (driven by DUT)
  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;

  // Expected values and bookkeeping
  reg        exp_gt, exp_lt, exp_eq;
  integer    i, j;
  integer    errors;
  integer    total;

  // DUT instantiation (instance named DUT for the waveform dump)
  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    total  = 0;

    // Development aid only -- uncomment to watch every signal change live:
    // $monitor($time, " A=%b B=%b | GT=%b LT=%b EQ=%b", t_a, t_b, t_gt, t_lt, t_eq);

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;
        #5;

        // Expected outputs computed independently from the integer counters
        exp_gt = (i >  j);
        exp_lt = (i <  j);
        exp_eq = (i == j);
        total  = total + 1;

        // 4-state comparison: !== also catches x/z on the outputs
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    // One-line summary built piece by piece with $write (no newline until the end)
    $write("SUMMARY: %0d of %0d combinations passed", total - errors, total);
    if (errors == 0)
      $write("  -> ALL PASS");
    else
      $write("  -> %0d FAILED", errors);
    $write("\n");

    $finish;
  end

endmodule