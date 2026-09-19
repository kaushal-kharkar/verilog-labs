// mux_df.v
// 2-to-1 multiplexer, DATAFLOW style.
//
// FIX: Y changed from 'reg' to 'wire'. A continuous assignment (assign)
// can only drive a net; a reg is a variable and can only be written
// procedurally (inside initial/always).

module mux_df (
  input       I0,
  input       I1,
  input       S,
  output wire Y
);

  assign Y = S ? I1 : I0;

endmodule