module multiplier(
    input  [7:0] f,
    output [7:0] multiplier_out
);
    wire [3:0] a, b;
    
    assign a = f[7 : 4];
    assign b = f[3 : 0];
    assign multiplier_out = a * b;

endmodule