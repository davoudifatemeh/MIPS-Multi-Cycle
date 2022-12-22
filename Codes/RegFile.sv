`timescale 1ns/1ns
module RegFile(input[4:0] ReadReg1, ReadReg2, WriteReg, input[31:0] WriteData,
               input RegWrite, clk, output[31:0] ReadData1, ReadData2);
  reg[31:0] R[0:31];
  initial
  begin
    R[0] = 32'b0;
  end
  assign ReadData1 = R[ReadReg1];
  assign ReadData2 = R[ReadReg2];
  always @(posedge clk) begin
    if (RegWrite)
      R[WriteReg] = WriteData;
  end
endmodule