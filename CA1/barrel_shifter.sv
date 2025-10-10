module barrel_shifter (
    input  [31:0] value,
    input  [4:0]  shift_amount,
    output [31:0] out
);
    assign out = (value << shift_amount) | (value >> (32 - shift_amount));
endmodule