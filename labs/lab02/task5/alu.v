module alu (
    input  [3:0] a,
    input  [3:0] b,
    input        op,     // 0 = add, 1 = sub
    output reg [3:0] result
);
    reg [3:0] b_comp;

    // Fixed sensitivity list to @(*) so it updates whenever 'a', 'b', or 'op' changes
    always @(*) begin
        if (op == 1'b0) begin
            result = a + b;
        end else begin
            // Fixed blocking assignments (=) so two's complement calculates in order
            b_comp = ~b + 1'b1;
            result = a + b_comp;
        end
    end
endmodule