
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

module parallel_in_mux4 
#(parameter WIDTH = 8)
(
    input [1:0]sel,
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    input  [WIDTH-1:0] c,
    input  [WIDTH-1:0] d,
    output [WIDTH-1:0] out
);
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : bit_slice_mux
            c2 c24(.D00(a[i]), .D01(b[i]), .D10(c[i]), .D11(d[i]) , .A1(sel[1]) , .B1(sel[1]) , .A0(sel[0]) , .B0(sel[0]) , .out(out[i]));
        end
    endgenerate
endmodule

module parallel_in_mux16 
#(parameter WIDTH = 8)
(
    input [3:0]sel,
    input  [WIDTH-1:0] a[0:15],
    output [WIDTH-1:0] out
);
    wire [WIDTH-1:0] w1, w2, w3, w4;
    parallel_in_mux4 m1(sel[1:0], a[0], a[1], a[2], a[3], w1);
    parallel_in_mux4 m2(sel[1:0], a[4], a[5], a[6], a[7], w2);
    parallel_in_mux4 m3(sel[1:0], a[8], a[9], a[10], a[11], w3);
    parallel_in_mux4 m4(sel[1:0], a[12], a[13], a[14], a[15], w4);

    parallel_in_mux4 m5(sel[3:2], w1, w2, w3, w4, out);
    
endmodule

module parallel_in_mux64 
#(parameter WIDTH = 8)
(
    input [5:0]sel,
    input  [WIDTH-1:0] a[0:63],
    output [WIDTH-1:0] out
);
    wire [WIDTH-1:0] w1, w2, w3, w4;
    wire [WIDTH-1:0] a_group1[0:15];
    wire [WIDTH-1:0] a_group2[0:15];
    wire [WIDTH-1:0] a_group3[0:15];
    wire [WIDTH-1:0] a_group4[0:15];
    
    // Assign the slices element by element using generate blocks or a common for loop
    genvar j;
    generate
        for (j = 0; j < 16; j = j + 1) begin : slice_assign
            assign a_group1[j] = a[j];
            assign a_group2[j] = a[j + 16];
            assign a_group3[j] = a[j + 32];
            assign a_group4[j] = a[j + 48];
        end
    endgenerate
    parallel_in_mux16 m1(sel[3:0], a_group1, w1);
    parallel_in_mux16 m2(sel[3:0], a_group2, w2);
    parallel_in_mux16 m3(sel[3:0], a_group3, w3);
    parallel_in_mux16 m4(sel[3:0], a_group4, w4);
    // parallel_in_mux4 m1(sel[3:0], a[0:15], w1);
    // parallel_in_mux4 m2(sel[3:0], a[16:31], w2);
    // parallel_in_mux4 m3(sel[3:0], a[32:47], w3);
    // parallel_in_mux4 m4(sel[3:0], a[48:63], w4);

    parallel_in_mux4 m5(sel[5:4], w1, w2, w3, w4, out);
    
endmodule

module full_adder (input a, input b, input cin, output sum, output cout);
    wire cin_inv;
    logic_not not1(cin, cin_inv);
    //b ^ a ^ cin
    c1 c13(.A0(cin) , .A1(cin_inv) , .SA(a) , .B0(cin_inv) , .B1(cin) , .SB(a) , .S0(b) , .S1(b),.f(sum)) ;
    c1 c24(.A0(1'b0) , .A1(cin) , .SA(b) , .B0(cin) , .B1(1'b1) , .SB(b) , .S0(a) , .S1(a),.f(cout)) ;
    // c2 c24(.D00(0), .D01(0), .D10(cin), .D11(1) , .A1(a) , .B1(b) , .A0(a) , .B0(b) , .out(cout));
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

    assign c[0] = 1'b0;

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