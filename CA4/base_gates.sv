`timescale 1ns/1ns


module logic_not (input a, output out);
    c1 c13(.A0(1'b1) , .A1(1'b0) , .SA(a) , .B0(1'b0) , .B1(1'b0) , .SB(1'b0) , .S0(1'b0) , .S1(1'b0),.f(out)) ;

endmodule


module logic_and2 (input a, input b, output out);
    c1 c13(.A0(1'b0) , .A1(b) , .SA(a) , .B0(1'b0) , .B1(1'b0) , .SB(1'b0) , .S0(1'b0) , .S1(1'b0),.f(out)) ;

endmodule


module logic_and3 (input a, input b, input c, output out);
    c1 c13(.A0(1'b0) , .A1(1'b0) , .SA(1'b0) , .B0(1'b0) , .B1(b) , .SB(a) , .S0(c) , .S1(c),.f(out)) ;

endmodule


module logic_or2 (input a, input b, output out);
    c1 c13(.A0(b) , .A1(1'b1) , .SA(a) , .B0(1'b0) , .B1(1'b0) , .SB(1'b0) , .S0(1'b0) , .S1(1'b0),.f(out)) ;

endmodule

module logic_xor2 (input a, input b, output out);
    c1 c13(.A0(a) , .A1(a) , .SA(a) , .B0(1'b1) , .B1(1'b0) , .SB(a) , .S0(b) , .S1(b),.f(out)) ;

endmodule

module logic_dff (input clk, input rst, input d, output out);
    s2 s2_dff (
        .D00(d), .D01(1'b0), .D10(1'b0), .D11(1'b0), 
        .A1(1'b0), .B1(1'b0), .A0(1'b0), .B0(1'b0), 
        .clr(rst), .clk(clk), .out(out));
endmodule

module logic_mux (input sel_1, input a, input sel_2, input b, input otherwise, output out);
        c1 c13(.A0(otherwise) , .A1(b) , .SA(sel_2) , .B0(otherwise) , .B1(a) , .SB(sel_1) , .S0(sel_1) , .S1(sel_1),.f(out)) ;

endmodule

