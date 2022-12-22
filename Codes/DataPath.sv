`timescale 1ns/1ns
module DataPath(input clk, rst, PCen, LorD, MemRead, MemWrite, IRWrite, MemToReg,RegWrite, ALUSrcA,
                input[2:0] ALUCtrl, input[1:0] PCSrc, RegDst, ALUSrcB, output[31:0] inst, output zero);
  wire[31:0] pcIn, pcOut, ALURegOut, MemIn, ARegOut, BRegOut, MemOut, Data, WriteReg, WriteData,
             ReadData1, ReadData2, four, A, B, signex, res, shl1Out, shl2In, shl2Out, JumpAddr;
  wire[4:0] R31;
  assign R31 = 5'b11111;
  assign four = 32'b00000000000000000000000000000100;
  PC pc(pcIn, clk, rst, PCen, pcOut);
  MUX2_32 mux1(LorD, pcOut, ALURegOut, MemIn);
  Memory Mem(clk, rst, MemRead, MemWrite, MemIn, BRegOut, MemOut);
  register2 IR(clk, rst, IRWrite, MemOut, inst);
  assign shl2In = {6'b0, inst[25:0]};
  register1 MDR(clk, rst, MemOut, Data);
  MUX3_5 mux2(RegDst, inst[20:16], inst[15:11], R31, WriteReg);
  MUX2_32 mux3(MemToReg, ALURegOut, Data, WriteData);
  RegFile regfile(inst[25:21], inst[20:16], WriteReg, WriteData, RegWrite, clk, ReadData1, ReadData2);
  register1 AReg(clk, rst, ReadData1, ARegOut);
  register1 BReg(clk, rst, ReadData2, BRegOut);
  MUX2_32 mux4(ALUSrcA, pcOut, ARegOut, A);
  MUX4_32 mux5(ALUSrcB, BRegOut, four, signex, shl1Out, B);
  SignExtend signextend(inst[15:0], signex);
  ShL2 shl1(signex, shl1Out);
  ShL2 shl2(shl2In, shl2Out);
  assign JumpAddr = {pcOut[31:28], shl2Out[27:0]};
  ALU alu(A, B, ALUCtrl, res, zero);
  register1 ALUReg(clk, rst, res, ALURegOut);
  MUX4_32 mux6(PCSrc, res, JumpAddr, ALURegOut, ARegOut, pcIn);
endmodule