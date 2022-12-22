`timescale 1ns/1ns
module PC(input[31:0] pcIn, input clk, rst, en, output reg[31:0] pcOut);
  always @(posedge clk, posedge rst) begin
    if (rst)
      pcOut <= 32'b0;
    else if (en)
      pcOut <= pcIn;
  end
endmodule