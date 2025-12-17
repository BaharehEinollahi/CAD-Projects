`timescale 1ns/1ns

module constant_rom (
    input [5:0] addr,
    output [7:0] data
);
    reg [7:0] rom [0:63];
    initial begin
        $readmemh("k.mem", rom);
    end
    
    assign data = rom[addr];

endmodule