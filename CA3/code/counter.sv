`timescale 1ns/1ns

module counter
#(parameter WIDTH = 3)
(
    input clk,
    input rst,
    input inz,
    input en,
    input [WIDTH-1:0] inz_value,
    output wire cout,
    output wire cout2,
    output wire [WIDTH-1:0] out
);

    wire [WIDTH-1:0] sum;
    wire [WIDTH-1:0] carry;
    
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : logic_chain
            if (i == 0) begin
                assign carry[i] = out[i];
            end else begin
                logic_and2 and_gate (out[i], carry[i-1], carry[i]);
            end
        end
    endgenerate

    assign cout = carry[WIDTH-1];

    
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : sum_logic
            if (i == 0) begin
                
                logic_not not_gate (out[i], sum[i]);
            end else begin
                logic_xor2 xor_gate (out[i], carry[i-1], sum[i]);
            end
        end
    endgenerate



    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : registers
            s2 bit_reg (
                .D00(out[i]),
                .D01(sum[i]),
                .D10(inz_value[i]),
                .D11(inz_value[i]),
                .A1(inz), .B1(1'b0),
                .A0(en),  .B0(1'b1),
                .clr(rst),
                .clk(clk),
                .out(out[i])
            );
        end
    endgenerate

    s2 cout2_reg (
        .D00(cout2),
        .D01(cout),
        .D10(1'b0),
        .D11(1'b0),
        .A1(inz), .B1(1'b0),
        .A0(en),  .B0(1'b1),
        .clr(rst),
        .clk(clk),
        .out(cout2)
    );

endmodule