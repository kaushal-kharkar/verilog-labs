// tb.v
// Testbench for DUT (2-to-1 mux).
// Applies all 8 combinations of I0, I1, S (5 time units apart) and observes Y.

module tb;

  // DUT inputs: driven procedurally from initial block -> variables (reg)
  reg   t_i0, t_i1, t_s;
  // DUT output: driven by the DUT's port -> net (wire)
  wire  t_y;

  // DUT instantiation (instance name 'DUT' so $dumpvars(0, DUT) resolves)
  DUT DUT (
    .I0 (t_i0),
    .I1 (t_i1),
    .S  (t_s),
    .Y  (t_y)
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
    // All 8 combinations of {I0, I1, S}, 5 time units apart
    {t_i0, t_i1, t_s} = 3'b000;  #5;
    {t_i0, t_i1, t_s} = 3'b001;  #5;
    {t_i0, t_i1, t_s} = 3'b010;  #5;
    {t_i0, t_i1, t_s} = 3'b011;  #5;
    {t_i0, t_i1, t_s} = 3'b100;  #5;
    {t_i0, t_i1, t_s} = 3'b101;  #5;
    {t_i0, t_i1, t_s} = 3'b110;  #5;
    {t_i0, t_i1, t_s} = 3'b111;  #5;
    $finish;
  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule