
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

module full_adder (input a, input b, input cin, output sum, output cout);
    wire cin_inv;
    logic_not not1(cin, cin_inv);
    //b ^ a ^ cin
    c1 c13(.A0(cin) , .A1(cin_inv) , .SA(a) , .B0(cin_inv) , .B1(cin) , .SB(a) , .S0(b) , .S1(b),.f(sum)) ;
    c2 c24(.D00(0), .D01(0), .D10(cin), .D11(1) , .A1(a) , .B1(b) , .A0(a) , .B0(b) , .out(cout));
endmodule

module half_adder(input a, input b, output sum, output cout);
    logic_xor2 lx1 (.a(a), .b(b), .out(sum));
    logic_and2 la1 (.a(a), .b(b), .out(cout));
endmodule

module half_adder_no_cout(input a, input b, output sum);
    logic_xor2 lx1 (.a(a), .b(b), .out(sum));
endmodule


module half_adder(input a, input b, output sum, output cout);
    logic_xor2 lx1 (.a(a), .b(b), .out(sum));
    logic_and2 la1 (.a(a), .b(b), .out(cout));
endmodule

module full_adder_no_cout(input a, input b, input cin, output sum);
    wire cin_inv;
    logic_not not1(cin, cin_inv);
    c1 c1_sum(.A0(cin) , .A1(cin_inv) , .SA(a), .B0(cin_inv) , .B1(cin) , .SB(a), .S0(b) , .S1(b),.f(sum));
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
        for (i = 0; i < WIDTH; i = i + 1) begin : adder_slice
            if (i == 0) begin
                half_adder ha (
                    .a(a[i]),
                    .b(b[i]),
                    .sum(sum[i]),
                    .cout(c[i+1])
                );
            end
            else if (i == WIDTH - 1) begin
                full_adder_no_cout fa_last (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(c[i]),
                    .sum(sum[i])
                );
            end
            else begin
                full_adder fa (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(c[i]),
                    .sum(sum[i]),
                    .cout(c[i+1])
                );
            end
        end
    endgenerate

endmodule