// module multiplier(
//     input  [7:0] f,
//     output [7:0] multiplier_out
// );
//     wire [3:0] a, b;
    
//     assign a = f[7 : 4];
//     assign b = f[3 : 0];
//     assign multiplier_out = a * b;

// endmodule

//------------------------------------------------------------
// number of gates:                                      520
//------------------------------------------------------------

module half_adder(input a, input b, output sum, output cout);
    logic_xor2 lx1 (.a(a), .b(b), .out(sum));
    logic_and2 la1 (.a(a), .b(b), .out(cout));
endmodule

module multiplier(
    input [7:0] f,
    output [7:0] multiplier_out
);
    wire [3:0] a;
    wire [3:0] b;
    assign a = f[7:4];
    assign b = f[3:0];

    wire pp0_0, pp0_1, pp0_2, pp0_3;
    wire pp1_0, pp1_1, pp1_2, pp1_3;
    wire pp2_0, pp2_1, pp2_2, pp2_3;
    wire pp3_0, pp3_1, pp3_2, pp3_3;

    logic_and2 pa00 (.a(a[0]), .b(b[0]), .out(pp0_0));
    logic_and2 pa01 (.a(a[1]), .b(b[0]), .out(pp0_1));
    logic_and2 pa02 (.a(a[2]), .b(b[0]), .out(pp0_2));
    logic_and2 pa03 (.a(a[3]), .b(b[0]), .out(pp0_3));

    logic_and2 pa10 (.a(a[0]), .b(b[1]), .out(pp1_0));
    logic_and2 pa11 (.a(a[1]), .b(b[1]), .out(pp1_1));
    logic_and2 pa12 (.a(a[2]), .b(b[1]), .out(pp1_2));
    logic_and2 pa13 (.a(a[3]), .b(b[1]), .out(pp1_3));

    logic_and2 pa20 (.a(a[0]), .b(b[2]), .out(pp2_0));
    logic_and2 pa21 (.a(a[1]), .b(b[2]), .out(pp2_1));
    logic_and2 pa22 (.a(a[2]), .b(b[2]), .out(pp2_2));
    logic_and2 pa23 (.a(a[3]), .b(b[2]), .out(pp2_3));

    logic_and2 pa30 (.a(a[0]), .b(b[3]), .out(pp3_0));
    logic_and2 pa31 (.a(a[1]), .b(b[3]), .out(pp3_1));
    logic_and2 pa32 (.a(a[2]), .b(b[3]), .out(pp3_2));
    logic_and2 pa33 (.a(a[3]), .b(b[3]), .out(pp3_3));

    wire s1_0, c1_0, s1_1, c1_1, s1_2, c1_2, s1_3, c1_3;
    wire s2_0, c2_0, s2_1, c2_1, s2_2, c2_2, s2_3, c2_3;
    wire s3_0, c3_0, s3_1, c3_1, s3_2, c3_2, s3_3, c3_3;

    assign multiplier_out[0] = pp0_0;

    half_adder ha1_0 (.a(pp0_1), .b(pp1_0), .sum(s1_0), .cout(c1_0));
    full_adder fa1_1 (.a(pp0_2), .b(pp1_1), .cin(c1_0), .sum(s1_1), .cout(c1_1));
    full_adder fa1_2 (.a(pp0_3), .b(pp1_2), .cin(c1_1), .sum(s1_2), .cout(c1_2));
    half_adder ha1_3 (.a(pp1_3), .b(c1_2), .sum(s1_3), .cout(c1_3));

    assign multiplier_out[1] = s1_0;

    half_adder ha2_0 (.a(s1_1), .b(pp2_0), .sum(s2_0), .cout(c2_0));
    full_adder fa2_1 (.a(s1_2), .b(pp2_1), .cin(c2_0), .sum(s2_1), .cout(c2_1));
    full_adder fa2_2 (.a(s1_3), .b(pp2_2), .cin(c2_1), .sum(s2_2), .cout(c2_2));
    full_adder fa2_3 (.a(c1_3), .b(pp2_3), .cin(c2_2), .sum(s2_3), .cout(c2_3));

    assign multiplier_out[2] = s2_0;

    half_adder ha3_0 (.a(s2_1), .b(pp3_0), .sum(s3_0), .cout(c3_0));
    full_adder fa3_1 (.a(s2_2), .b(pp3_1), .cin(c3_0), .sum(s3_1), .cout(c3_1));
    full_adder fa3_2 (.a(s2_3), .b(pp3_2), .cin(c3_1), .sum(s3_2), .cout(c3_2));
    full_adder fa3_3 (.a(c2_3), .b(pp3_3), .cin(c3_2), .sum(s3_3), .cout(c3_3));

    assign multiplier_out[3] = s3_0;
    assign multiplier_out[4] = s3_1;
    assign multiplier_out[5] = s3_2;
    assign multiplier_out[6] = s3_3;
    assign multiplier_out[7] = c3_3;

endmodule