`timescale 1ns/1ns
module register1(input clk, rst, input[31:0] in, output[31:0] out);
  logic[31:0] _out;
  always @(posedge clk, posedge rst) begin
    if(rst)
      _out <= 32'b0;
    else
    _out <= in;
  end
  assign out = _out;
endmodule

module register2(input clk, rst, en, input[31:0] in, output[31:0] out);
  logic[31:0] _out;
  always @(posedge clk, posedge rst) begin
    if(rst)
      _out <= 32'b0;
    else if (en)
    _out <= in;
  end
  assign out = _out;
endmodule