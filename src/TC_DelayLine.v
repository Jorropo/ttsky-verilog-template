module TC_DelayLine (clk, rst, in, out);
    parameter UUID = 0;
    parameter NAME = "";
    parameter WORD_WIDTH = 1;
    input clk;
    input rst;
    input [WORD_WIDTH-1:0] in;
    output reg [WORD_WIDTH-1:0] out;

    always @ (posedge clk or posedge rst) begin
        if (rst)
            out <= {WORD_WIDTH{1'b0}};
        else
            out <= in;
    end
endmodule
