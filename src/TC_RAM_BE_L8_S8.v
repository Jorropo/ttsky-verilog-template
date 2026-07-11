module TC_RAM_BE_L8_S8 #(
    parameter ADDR_WIDTH = 8
) (
    input clk,
    input rst,
    input en0,
    input [ADDR_WIDTH-1:0] addr0,
    output [8-1:0] out0,
    input en1,
    input [ADDR_WIDTH-1:0] addr1,
    input [8-1:0] in1
);
    reg [7:0] ram [0:(1<<ADDR_WIDTH)-1];
    integer rst_i;

    initial begin
        for (rst_i = 0; rst_i < (1 << ADDR_WIDTH); rst_i = rst_i + 1)
            ram[rst_i] = 8'h0;
    end

    assign out0 = en0 ? {(ram[addr0 + 0])} : 8'b0;

    always @(posedge clk) begin
        if (rst) begin
            for (rst_i = 0; rst_i < (1<<ADDR_WIDTH); rst_i = rst_i + 1)
                ram[rst_i] <= 8'h0;
        end else begin
            if (en1) begin
                ram[addr1 + 0] <= in1[0 +: 8];
            end
        end
    end
endmodule
