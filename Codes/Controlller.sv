`timescale 1ns/1ns
module Controller(input clk, rst, zero, input[31:0] Inst, output logic PCen, LorD, MemRead, MemWrite, IRWrite,
                  MemToReg, RegWrite, ALUSrcA, output logic[2:0] ALUCtrl, output logic[1:0] PCSrc, RegDst, ALUSrcB);
                  
  parameter [4:0] A = 5'b00000, B = 5'b00001, C = 5'b00010, D = 5'b00011, E = 5'b00100, F = 5'b00101,
                  G = 5'b00110, H = 5'b00111, I = 5'b01000, J = 5'b01001, K = 5'b01010, L = 5'b01011,
                  M = 5'b01100, N = 5'b01101, O = 5'b01110, P = 5'b01111, Q = 5'b10000, R = 5'b10001;
  logic[4:0] ps, ns;
                  
  always @(ps, Inst, zero) begin
    {LorD,MemRead,MemWrite,IRWrite,MemToReg,RegWrite,ALUSrcA,ALUCtrl,PCSrc,RegDst,ALUSrcB,PCen} = 17'b0;
    ns = A;
    case(ps)
      A:begin MemRead = 1'b1; ALUSrcA = 1'b0; LorD = 1'b0; IRWrite = 1'b1; ALUSrcB = 2'b01;
              ALUCtrl = 3'b0; PCen = 1'b1; PCSrc = 2'b0; ns = B; end
      B: begin ALUSrcA = 1'b0; ALUSrcB = 2'b11; ALUCtrl = 3'b0;
         case(Inst[31:26])
          6'b100011: ns = C;
          6'b101011: ns = C;
          6'b000010: ns = F;
          6'b000100: ns = H;
          6'b000101: ns = I;
          6'b000001: ns = J;
          6'b000011: ns = K;
          6'b000000: ns = N;
          6'b001000: ns = P;
          6'b001100: ns = R;
          default ns = B;
        endcase
      end
      C: begin ALUSrcA = 1'b1; ALUSrcB = 2'b10; ALUCtrl = 3'b0;
         case(Inst[31:26])
          6'b100011: ns = D;
          6'b101011: ns = G;
        endcase
      end 
      D: begin LorD = 1'b1; MemRead = 1'b1; ns = E; end
      E: begin MemToReg = 1'b1; RegWrite = 1'b1; RegDst = 2'b0; ns = A; end
      F: begin PCen = 1'b1; PCSrc = 2'b01; ns = A; end
      G: begin LorD = 1'b1; MemWrite = 1'b1; ns = A; end
      H: begin ALUSrcA = 1'b1; ALUSrcB = 2'b0; ALUCtrl = 3'b001; PCSrc = 2'b10; PCen = zero; ns = A; end 
      I: begin ALUSrcA = 1'b1; ALUSrcB = 2'b0; ALUCtrl = 3'b001; PCSrc = 2'b10; PCen = ~zero; ns = A; end
      J: begin PCen = 1'b1; PCSrc = 2'b11; ns = A; end
      K: begin ALUSrcA = 1'b0; ALUSrcB = 2'b01; ALUCtrl = 3'b0; ns = L; end
      L: begin MemToReg = 1'b0; RegWrite = 1'b1; RegDst = 2'b10; ns = M; end
      M: begin PCen = 1'b1; PCSrc = 2'b01; ns = A; end
      N: begin ALUSrcA = 1'b1; ALUSrcB = 2'b00;
         case(Inst[5:0])
           6'b100000: ALUCtrl = 3'b0;
           6'b100010: ALUCtrl = 3'b001;
           6'b100100: ALUCtrl = 3'b010;
           6'b100101: ALUCtrl = 3'b011;
           6'b101010: ALUCtrl = 3'b100;
         endcase
         ns = O;
       end
      O: begin MemToReg = 1'b0; RegWrite = 1'b1; RegDst = 2'b01; ns = A; end
      P: begin ALUSrcA = 1'b1; ALUSrcB = 2'b10; ALUCtrl = 3'b0; ns = Q; end
      Q: begin MemToReg = 1'b0; RegWrite = 1'b1; RegDst = 2'b0; ns = A; end
      R: begin ALUSrcA = 1'b1; ALUSrcB = 2'b10; ALUCtrl = 3'b010; ns = Q; end
      default ns = A;
    endcase
  end
  
  always @(negedge clk, posedge rst) begin
    if(rst) ps <= A;
    else ps <= ns;
  end 
endmodule