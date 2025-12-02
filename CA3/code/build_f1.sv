module build_f1(
    input a,
    input b,
    input c,
    input d,
    input [1:0]sel,
    output out
);


    wire [3:0] res;
    wire out_res0_res1;
    wire d_inv;
    logic_not not1(d, d_inv);
    //(b & c) | (~b & d)
    //(d & b) | (~d & c)
    c1 c12(.A0(d) , .A1(c) , .SA(b) , .B0(c) , .B1(b) , .SB(d) , .S0(sel[0]) , .S1(sel[0]), .f(out_res0_res1)) ;
    //b ^ c ^ d 
    c1 c13(.A0(d) , .A1(d_inv) , .SA(c) , .B0(d_inv) , .B1(d) , .SB(c) , .S0(b) , .S1(b),.f(res[2])) ;
    //c ^ (b | ~d)
    c2 c24(.D00(0), .D01(1), .D10(1), .D11(0) , .A1(b) , .B1(d_inv) , .A0(c) , .B0(c) , .out(res[3]));

    c2 c25(.D00(out_res0_res1), .D01(out_res0_res1), .D10(res[2]), .D11(res[3]) , .A1(sel[1]) , .B1(sel[1]) , .A0(sel[0]) , .B0(sel[0]) , .out(out));

endmodule


module parallel_build_f1 (
    input  [7:0] a,
    input  [7:0] b,
    input  [7:0] c,
    input  [7:0] d,
    input  [1:0] sel,
    output [7:0] out
);

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : f1_gen
        build_f1 f1_unit (
            .a(a[i]),
            .b(b[i]),
            .c(c[i]),
            .d(d[i]),
            .sel(sel),
            .out(out[i])
        );
    end
endgenerate

endmodule

