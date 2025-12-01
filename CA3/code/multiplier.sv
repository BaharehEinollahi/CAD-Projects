module multiplier #(
    parameter WIDTH = 8
) (
    input  [WIDTH-1:0] f,
    output [WIDTH-1:0] multiplier_out
);

    localparam HALF_WIDTH = WIDTH / 2;

    wire [HALF_WIDTH-1:0] ms_half; 
    wire [HALF_WIDTH-1:0] ls_half;
    
    assign ms_half = f[WIDTH-1 : HALF_WIDTH];
    assign ls_half = f[HALF_WIDTH - 1 : 0];
    assign multiplier_out = ms_half * ls_half;

endmodule