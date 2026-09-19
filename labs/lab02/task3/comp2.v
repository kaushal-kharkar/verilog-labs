// comp2.v
// 2-bit unsigned magnitude comparator.
// Given two 2-bit values A and B, exactly one of GT, LT, EQ is 1
// for any input combination.
//
// FIX: GT was (A >= B), which also asserted GT whenever A == B, so GT and
// EQ were both 1 on all four equal-input cases. Changed to strict (A > B).

module comp2 (
  input  [1:0] A,
  input  [1:0] B,
  output       GT,
  output       LT,
  output       EQ
);

  assign EQ = (A == B);
  assign GT = (A >  B);
  assign LT = (A <  B);

endmodule
