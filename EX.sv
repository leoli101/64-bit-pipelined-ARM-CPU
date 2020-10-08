`timescale 1ns/10ps
module EX(data_a_ex, data_b_ex, isADDI_reg, ALUSrc_reg, ALUop_reg, neg_reg, zero_reg, overflow_reg, carry_out_reg,
			 flag_en_reg, instr_reg_ex, alu_result, clk, reset, negative, overflow);

	input logic[31:0] instr_reg_ex;
	input logic[63:0] data_a_ex, data_b_ex;
	input logic isADDI_reg, ALUSrc_reg, flag_en_reg;
	input logic[2:0] ALUop_reg;
	input logic clk, reset;
	output logic negative, overflow;
	output logic neg_reg, zero_reg, overflow_reg, carry_out_reg;
	output logic[63:0] alu_result;
		
	logic[63:0] SE_Imm9, SE_Imm12, SE_out, alu_2;
	logic zero, carry_out;
	
	SignedExtend #(.WIDTH(9)) se_9(.data_in(instr_reg_ex[20:12]), .data_out(SE_Imm9));
	
	ZeroExtend #(.WIDTH(12)) se_12(.data_in(instr_reg_ex[21:10]), .data_out(SE_Imm12));
	
	mux64x2_1 ADDI(.data1_in(SE_Imm9), .data2_in(SE_Imm12), .data_out(SE_out), .sel(isADDI_reg));
	
	mux64x2_1 alusrc(.data1_in(data_b_ex), .data2_in(SE_out), .data_out(alu_2), .sel(ALUSrc_reg));
	
	alu alu_1(.A(data_a_ex), .B(alu_2), .cntrl(ALUop_reg), .result(alu_result), .negative, .zero, .overflow, .carry_out);
	
	flag_reg neg(.new_flag(negative), .flag_en(flag_en_reg), .q(neg_reg), .clk, .reset);
	
	flag_reg zero_1(.new_flag(zero), .flag_en(flag_en_reg), .q(zero_reg), .clk, .reset);
	
	flag_reg overflow_1(.new_flag(overflow), .flag_en(flag_en_reg), .q(overflow_reg), .clk, .reset);
	
	flag_reg cout(.new_flag(carry_out), .flag_en(flag_en_reg), .q(carry_out_reg), .clk, .reset);
endmodule
