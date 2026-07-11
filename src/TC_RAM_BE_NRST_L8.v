module TC_RAM_BE_NRST_L8 #(
    parameter ADDR_WIDTH = 8,
    parameter MEM_FILE = ""
) (
    input clk,
    input rst,
    input en0,
    input [ADDR_WIDTH-1:0] addr0,
    output [8-1:0] out0
);
    reg [7:0] ram [0:(1<<ADDR_WIDTH)-1];

    initial $readmemh(MEM_FILE, ram);

    assign out0 = en0 ? {(ram[addr0 + 0])} : 8'b0;

    always @(posedge clk) begin
        if (!rst) begin
        end
    end
endmodule
