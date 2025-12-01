
module parallel_in_mux 
#(parameter WIDTH = 8)
(
    input sel_1,
    input  [WIDTH-1:0] a,
    input sel_2,
    input  [WIDTH-1:0] b,
    input  [WIDTH-1:0] otherwise,
    output [WIDTH-1:0] out
);
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : bit_slice_mux
            logic_mux mux_i (
                .sel_1(sel_1), 
                .a(a[i]), 
                .sel_2(sel_2), 
                .b(b[i]), 
                .otherwise(otherwise[i]),
                .out(out[i])
            );
        end
    endgenerate
endmodule

module logic_full_adder 
(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire wire_axorb;
    wire wire_and_ab;
    wire wire_and_axorb_cin;

    logic_xor2 gate_xor1 (.a(a), .b(b), .out(wire_axorb));
    logic_xor2 gate_xor2 (.a(wire_axorb), .b(cin), .out(sum));

    logic_and2 gate_and1 (.a(a), .b(b), .out(wire_and_ab));
    logic_and2 gate_and2 (.a(wire_axorb), .b(cin), .out(wire_and_axorb_cin));
    logic_or2  gate_or1  (.a(wire_and_ab), .b(wire_and_axorb_cin), .out(cout));

endmodule


module adder 
#(parameter WIDTH = 8)
(
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    output [WIDTH-1:0] sum
);
    wire [WIDTH:0] c;

    assign c[0] = 0;

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : adder_slice
            logic_full_adder fa (
                .a(a[i]),
                .b(b[i]),
                .cin(c[i]),
                .sum(sum[i]),
                .cout(c[i+1])
            );
        end
    endgenerate

endmodule