module barrel_shifter (
    input  [7:0] value,
    input  [2:0]  shift_amount,
    output [16:0] out
);
    assign out = (value << shift_amount) | (value >> (32 - shift_amount));
endmodule