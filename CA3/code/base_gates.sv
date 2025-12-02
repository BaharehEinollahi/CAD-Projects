`timescale 1ns/1ns


module logic_not (input a, output out);
    c2 c2_inv (
        .D00(1'b0), .D01(1'b1), .D10(1'b0), .D11(1'b0),
        .A1(a), .B1(1'b0), .A0(1'b1), .B0(1'b1), .out(out)
    );
endmodule


module logic_and2 (input a, input b, output out);
    c2 c2_and (
        .D00(1'b0), .D01(1'b0), .D10(1'b0), .D11(1'b1), 
        .A1(a), .B1(1'b0), .A0(b), .B0(1'b1), .out(out)
    );
endmodule


module logic_and3 (input a, input b, input c, output out);
    c2 c2_inst (.D00(0), .D01(0), .D10(0), .D11(1), 
                .A1(c), .B1(c), .A0(a), .B0(b), .out(out));
endmodule


module logic_or2 (input a, input b, output out);
    c2 c2_or (
        .D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b1), 
        .A1(a), .B1(1'b0), .A0(b), .B0(1'b1), .out(out)
    );
endmodule

module logic_xor2 (input a, input b, output out);
    c2 xor_gate (
        .D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b0),
        .A1(a), .B1(1'b0),
        .A0(b), .B0(1'b1),
        .out(out)
    );
endmodule

module logic_dff (input clk, input rst, input d, output out);
    s2 s2_dff (
        .D00(d), .D01(1'b0), .D10(1'b0), .D11(1'b0), 
        .A1(1'b0), .B1(1'b0), .A0(1'b0), .B0(1'b0), 
        .clr(rst), .clk(clk), .out(out)
    );
endmodule

module logic_mux (input sel_1, input a, input sel_2, input b, input otherwise, output out);
    c2 mux(
    .D00( otherwise ),
    .D01( b ),
    .D10( a ),
    .D11( a ),
    .A1( sel_1 ), .B1( 1'b0 ),
    .A0( sel_2 ), .B0( 1'b1 ),
    .out( out )
    );
endmodule

