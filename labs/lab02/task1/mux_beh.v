// mux_beh.v
// 2-to-1 multiplexer, BEHAVIORAL style.
// FIX: output declared as 'reg' because it is assigned inside an always block
//      (procedural assignment targets must be variables, not nets).

module mux_beh (
  input      I0,
  input      I1,
  input      S,
  output reg Y
);

  always @(*) begin
    if (S)
      Y = I1;
    else
      Y = I0;
  end

endmodule