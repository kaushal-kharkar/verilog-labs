`timescale 1ns / 1ps

module tb;
  reg  [3:0] a;
  reg  [3:0] b;
  reg        op;
  wire [3:0] result;

  // Instantiate the ALU module
  alu uut (
    .a(a),
    .b(b),
    .op(op),
    .result(result)
  );

  initial begin
    $monitor("Time=%0t | op=%b a=%b b=%b -> result=%b", $time, op, a, b, result);

    // Test Addition (op = 0)
    op = 0; a = 4'b0010; b = 4'b0001; #10; // 2 + 1 = 3
    a = 4'b0100; #10;                     // 4 + 1 = 5 (Check if changing 'a' triggers update)

    // Test Subtraction (op = 1)
    op = 1; a = 4'b0101; b = 4'b0010; #10; // 5 - 2 = 3

    $finish;
  end
endmodule