module TC_Counter (clk, rst, overwrite, overwrite_value, out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 8;
    parameter count = 1;
    input clk;
    input rst;
    input overwrite;
    input [WORD_WIDTH-1:0] overwrite_value;
    output reg [WORD_WIDTH-1:0] out;
    
    reg [WORD_WIDTH-1:0] value;
    
    initial begin
        out = {WORD_WIDTH{1'b0}};
        value = {WORD_WIDTH{1'b0}};
    end
    
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            out <= {WORD_WIDTH{1'b0}};
            value <= {WORD_WIDTH{1'b0}};
        end else begin
            if (overwrite) begin
                out <= overwrite_value;
                value <= overwrite_value + count;
            end else begin
                out <= value;
                value <= value + count;
            end
        end
    end
endmodule
