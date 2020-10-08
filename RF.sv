`timescale 1ns/10ps
module RF(instr_reg, pc_reg, next_pc, data_a, data_b, data_to_reg, RegWrite_reg, neg_reg, overflow_reg, clk,
			 isADDI, MemWrite, ALUSrc, flag_en, read_en, RegWrite, MemToReg, ALUop,
			 alu_result, alu_result_reg, instr_reg_ex, instr_reg_mem, RegWrite_exe, RegWrite_reg_mem,
			 negative, overflow, flag_en_exe, norm_result, is_BR, BrTaken, instr_reg_wb, Reg3Loc, Reg3Loc_wb,
			 RegWrite_reg_wb, norm_result_mem, data_to_reg_mem);

	input logic clk, RegWrite_reg_wb;
	output logic is_BR, BrTaken;
	input logic[31:0] instr_reg, instr_reg_wb;
	input logic[63:0] pc_reg, norm_result, norm_result_mem;
	input logic[63:0] data_to_reg, data_to_reg_mem; // WriteBack stage
	input logic RegWrite_reg /*WriteBack stage*/, neg_reg, overflow_reg;
	input logic Reg3Loc_wb;
	
	/*************forwarding unit********************/
	input logic[63:0] alu_result, alu_result_reg;
	input logic[31:0] instr_reg_ex, instr_reg_mem;
	input logic RegWrite_exe, RegWrite_reg_mem;
	input logic negative, overflow, flag_en_exe;
	/***************************************/
	output logic[63:0] next_pc, data_a, data_b;
	output logic isADDI, MemWrite, ALUSrc, flag_en, read_en, RegWrite, Reg3Loc;
	output logic[1:0] MemToReg;
	output logic[2:0] ALUop;
	
	logic[63:0] data_a_reg, data_b_reg, BR_addr;
	logic zero;
	logic Reg2Loc, UncondBr;
	
	logic[1:0] sel_1, sel_2;
	logic sel_3;
	
	logic negative_ctrl, overflow_ctrl;
	
	/*************flag forwarding********************/
	mux2_1 f_1(.data1_in(neg_reg), .data2_in(negative), .data_out(negative_ctrl), .sel(flag_en_exe));
	mux2_1 f_2(.data1_in(overflow_reg), .data2_in(overflow), .data_out(overflow_ctrl), .sel(flag_en_exe));
	/************************************************/
	
	instr_path ipath(.instr_reg, .pc_reg, .UncondBr, .BrTaken, .is_BR, .next_pc, .BR_addr, .norm_result);
	
	control_unit cu(.zero, .negative(negative_ctrl), .overflow(overflow_ctrl), .instr(instr_reg), .RegWrite, .Reg3Loc, .Reg2Loc, .isADDI, .ALUSrc, .MemWrite,
						.ALUop, .MemToReg, .UncondBr, .BrTaken, .is_BR, .flag_en, .read_en);

	logic[4:0] reg_2, reg_3;
	
	mux5x2_1 reg2_loc(.data1_in(instr_reg[4:0]), .data2_in(instr_reg[20:16]), .data_out(reg_2), .sel(Reg2Loc));
	
	// This should be done in WB stage
	mux5x2_1 reg3_loc(.data1_in(instr_reg_wb[4:0]), .data2_in(5'd30), .data_out(reg_3), .sel(Reg3Loc_wb));
	
	// clk is inverted
	regfile RegFile(.ReadRegister1(instr_reg[9:5]), .ReadRegister2(reg_2), .WriteRegister(reg_3), .WriteData(data_to_reg), .ReadData1(data_a_reg), .ReadData2(data_b_reg), .RegWrite(RegWrite_reg_wb), .clk(~clk));

	// determine if data_b is 0
	// this zero flag is for CBZ
	is_zero iz(.data_in(data_b), .data_out(zero));
	
	

	/*************forwarding unit********************/
	forwarding_unit fu(.instr_reg, .instr_reg_ex, .instr_reg_mem, .RegWrite_exe, .RegWrite_reg_mem, .sel_1, .sel_2, .sel_3);
	
	mux64x2_1 BR_result(.data1_in(data_b_reg), .data2_in(data_to_reg_mem), .data_out(BR_addr), .sel(sel_3));
	mux64_4 mux_data_a(.data_1(alu_result), .data_2(data_a_reg), .data_3(data_to_reg_mem), .data_4(norm_result_mem), .data_out(data_a), .sel(sel_1));
	mux64_4 mux_data_b(.data_1(alu_result), .data_2(data_b_reg), .data_3(data_to_reg_mem), .data_4(data_b_reg), .data_out(data_b), .sel(sel_2));
	/************************************************/
endmodule
