`timescale 1ns/1ns
module MUX2_5(input selector, input[4:0] A, B, output logic[4:0] out);
  always @(A, B, selector) begin
    out = 5'b0;
    case(selector)
      1'b0: out = A;
      1'b1: out = B;
    endcase
  end
endmodule

module MUX3_5(input[1:0] selector, input[4:0] A, B, C, output logic[4:0] out);
  always @(A, B, C, selector) begin
    out = 5'b0;
    case(selector)
      2'b00: out = A;
      2'b01: out = B;
      2'b10: out = C;
    endcase
  end
endmodule

module MUX2_32(input selector, input[31:0] A, B, output logic[31:0] out);
  always @(A, B, selector) begin
    out = 32'b0;
    case(selector)
      1'b0: out = A;
      1'b1: out = B;
    endcase
  end
endmodule

module MUX4_32(input[1:0] selector, input[31:0] A, B, C, D, output logic[31:0] out);
  always @(A, B, C, D, selector) begin
    out = 32'b0;
    case(selector)
      2'b00: out = A;
      2'b01: out = B;
      2'b10: out = C;
      2'b11: out = D;
    endcase
  end
endmodule