`timescale 1ns/10ps
module datapath(norm_result, Imm9, Imm12, data_b, clk, RegWrite, Reg3Loc, Reg2Loc, isADDI, ALUSrc,
					MemWrite, instr, MemToReg, ALUop, zero, negative, overflow, carry_out, read_en);

	input logic clk, RegWrite, Reg3Loc, Reg2Loc, isADDI, ALUSrc, MemWrite, read_en;
	input logic[2:0] ALUop;
	input logic[1:0] MemToReg;
	input logic[31:0] instr;
	input logic[8:0] Imm9;
	input logic[11:0] Imm12;
	input logic[63:0] norm_result;
	output logic zero, negative, overflow, carry_out;
	output logic[63:0] data_b;
	
	logic[4:0] reg_2, reg_3;
	
	logic[63:0] data_a, alu_2, alu_result, data_to_reg;
	
	mux5x2_1 reg2_loc(.data1_in(instr[4:0]), .data2_in(instr[20:16]), .data_out(reg_2), .sel(Reg2Loc));
	
	mux5x2_1 reg3_loc(.data1_in(instr[4:0]), .data2_in(5'd30), .data_out(reg_3), .sel(Reg3Loc));
	
	regfile RegFile(.ReadRegister1(instr[9:5]), .ReadRegister2(reg_2), .WriteRegister(reg_3), .WriteData(data_to_reg), .ReadData1(data_a), .ReadData2(data_b), .RegWrite, .clk);

	logic[63:0] SE_Imm9, SE_Imm12, SE_out;
	
	SignedExtend #(.WIDTH(9)) se_9(.data_in(Imm9), .data_out(SE_Imm9));
	
	ZeroExtend #(.WIDTH(12)) se_12(.data_in(Imm12), .data_out(SE_Imm12));
	
	mux64x2_1 ADDI(.data1_in(SE_Imm9), .data2_in(SE_Imm12), .data_out(SE_out), .sel(isADDI));
	
	mux64x2_1 alusrc(.data1_in(data_b), .data2_in(SE_out), .data_out(alu_2), .sel(ALUSrc));
	
	alu alu_1(.A(data_a), .B(alu_2), .cntrl(ALUop), .result(alu_result), .negative, .zero, .overflow, .carry_out);
	
	logic[63:0] dmem_out;
	
	datamem dmem(.address(alu_result), .write_enable(MemWrite), .read_enable(read_en), .write_data(data_b), .clk, .xfer_size(4'd8), .read_data(dmem_out));

	mux64x4_1 mem_2_reg(.data1_in(alu_result), .data2_in(dmem_out), .data3_in(norm_result), .data4_in(alu_result), .data_out(data_to_reg), .sel(MemToReg));

endmodule

//module datapath_testbench();
//
//	logic clk, RegWrite, Reg3Loc, Reg2Loc, isADDI, ALUSrc, MemWrite;
//	logic[2:0] ALUop;
//	logic[1:0] MemToReg;
//	logic[31:0] instr;
//	logic[8:0] Imm9;
//	logic[11:0] Imm12;
//	logic[63:0] norm_result;
//	logic zero, negative, overflow, carry_out;
//	logic[63:0] data_b;
//	
//	parameter CLOCK_PERIOD=50;
//	initial begin
//		clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk;
//	end
//	
//	datapath dut(norm_result, Imm9, Imm12, data_b, clk, RegWrite, Reg3Loc, Reg2Loc, isADDI, ALUSrc,
//					MemWrite, instr, MemToReg, ALUop, zero, negative, overflow, carry_out);
//					
//	initial begin
//		reset <= 1; @(posedge clk);
//		RegWrite <= 1; Reg3Loc <= 0; isADDI <= 1; ALUSrc <= 1; MemWrite <= 0;
//		ALUop <= 3'b010; MemToReg <= 2'b00; Imm12
//	end
//endmodule
