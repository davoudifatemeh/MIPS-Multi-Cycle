`timescale 1ns/1ns
module Mips32(input clk, rst);
  wire PCen, LorD, MemRead, MemWrite, IRWrite, MemToReg, RegWrite, ALUSrcA, zero;
  wire[2:0] ALUCtrl;
  wire[1:0] PCSrc, RegDst, ALUSrcB;
  wire[31:0] Inst;
  DataPath dp(clk, rst, PCen, LorD, MemRead, MemWrite, IRWrite, MemToReg,RegWrite, ALUSrcA,
           ALUCtrl, PCSrc, RegDst, ALUSrcB, Inst, zero);
  Controller ctrl(clk, rst, zero, Inst, PCen, LorD, MemRead, MemWrite,IRWrite,
                  MemToReg, RegWrite, ALUSrcA, ALUCtrl, PCSrc, RegDst, ALUSrcB);
endmodule