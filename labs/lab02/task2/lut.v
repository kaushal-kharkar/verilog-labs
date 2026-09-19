// lut.v
// A small parameterized ROM (lookup table): DEPTH words, each WIDTH bits
// wide. dout continuously reflects mem[sel].

module lut #(
  parameter WIDTH = 8,
  parameter DEPTH = 4
) (
  input      [$clog2(DEPTH)-1:0] sel,
  output reg [WIDTH-1:0]         dout
);

  reg [WIDTH-1:0] mem [0:DEPTH-1];

  integer i;

  // ROM contents: mem[i] = i*i, loaded once at time 0.
  // initial runs exactly once, before anything reads the ROM; the contents
  // never change afterwards, so always/assign would be the wrong tool.
  initial begin
    for (i = 0; i < DEPTH; i = i + 1)
      mem[i] = i * i;
  end

  // Combinational read: dout is declared 'reg', so it must be driven from a
  // procedural block. @(*) re-evaluates whenever sel (or the addressed
  // memory word) changes -- i.e. pure combinational behaviour, no clock.
  always @(*) begin
    dout = mem[sel];
  end

endmodule
