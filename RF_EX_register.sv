`timescale 1ns/10ps
module RF_EX_register(data_a, data_b, isADDI, MemWrite, ALUSrc, flag_en, read_en, RegWrite, MemToReg, ALUop,
							data_a_ex, data_b_ex, isADDI_reg, MemWrite_reg, ALUSrc_reg, flag_en_reg, read_en_reg, 
							RegWrite_reg, MemToReg_reg, ALUop_reg, clk, instr_reg, instr_reg_ex,
							Reg3Loc, Reg3Loc_exe, norm_result, norm_result_exe);

	input logic[63:0] data_a, data_b, norm_result;
	input logic[31:0] instr_reg;
	input logic isADDI, MemWrite, ALUSrc, flag_en, read_en, RegWrite, clk, Reg3Loc;
	input logic[1:0] MemToReg;
	input logic[2:0] ALUop;	

	output logic[63:0] data_a_ex, data_b_ex, norm_result_exe;
	output logic[31:0] instr_reg_ex;
	output logic isADDI_reg, MemWrite_reg, ALUSrc_reg, flag_en_reg, read_en_reg, RegWrite_reg, Reg3Loc_exe; 
	output logic[1:0] MemToReg_reg;
	output logic[2:0] ALUop_reg;

	genvar i;
	
	generate
	
		for (i = 0; i < 64; i++) begin : each_1
			D_FF each_dff(.q(data_a_ex[i]), .d(data_a[i]), .reset(1'b0), .clk);
		end
		
		for (i = 0; i < 64; i++) begin : each_2
			D_FF each_dff(.q(data_b_ex[i]), .d(data_b[i]), .reset(1'b0), .clk);
		end
		
		for (i = 0; i < 32; i++) begin : each_3
			D_FF each_dff(.q(instr_reg_ex[i]), .d(instr_reg[i]), .reset(1'b0), .clk);
		end
		
		for (i = 0; i < 3; i++) begin : each_4
			D_FF each_dff(.q(ALUop_reg[i]), .d(ALUop[i]), .reset(1'b0), .clk);
		end
		
		for (i = 0; i < 2; i++) begin : each_5
			D_FF each_dff(.q(MemToReg_reg[i]), .d(MemToReg[i]), .reset(1'b0), .clk);
		end
		
		for (i = 0; i < 64; i++) begin : each_6
			D_FF each_dff(.q(norm_result_exe[i]), .d(norm_result[i]), .reset(1'b0), .clk);
		end
	endgenerate
	
	// control signal
	D_FF each_dff_1(.q(isADDI_reg), .d(isADDI), .reset(1'b0), .clk);
	D_FF each_dff_2(.q(MemWrite_reg), .d(MemWrite), .reset(1'b0), .clk);
	D_FF each_dff_3(.q(ALUSrc_reg), .d(ALUSrc), .reset(1'b0), .clk);
	D_FF each_dff_4(.q(flag_en_reg), .d(flag_en), .reset(1'b0), .clk);
	D_FF each_dff_5(.q(read_en_reg), .d(read_en), .reset(1'b0), .clk);
	D_FF each_dff_6(.q(RegWrite_reg), .d(RegWrite), .reset(1'b0), .clk);
	D_FF each_dff_7(.q(Reg3Loc_exe), .d(Reg3Loc), .reset(1'b0), .clk);
endmodule
