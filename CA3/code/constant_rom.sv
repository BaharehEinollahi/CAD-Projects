`timescale 1ns/1ns

module constant_rom (
    input [5:0] addr,
    output logic [7:0] data
);
    
    logic [7:0] rom [0:63];
    
    initial begin
        $readmemh("../proj_desc/k.mem", rom);
    end
    
    assign data = rom[addr];
    module parallel_in_mux 
#(parameter WIDTH = 8)
(sel_1, [WIDTH-1:0] a,sel_2, [WIDTH-1:0] b, [WIDTH-1:0] otherwise, [WIDTH-1:0] out
);
    
endmodule