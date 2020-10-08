`timescale 1ns/10ps
module EX_MEM_register(MemWrite_reg, MemToReg_reg, read_en_reg, RegWrite_reg, instr_reg_ex, alu_result,
								MemWrite_reg_mem, MemToReg_reg_mem, read_en_reg_mem, RegWrite_reg_mem, instr_reg_mem,
								alu_result_reg, clk, data_b_ex, data_b_mem, Reg3Loc_exe, Reg3Loc_mem, norm_result_exe, norm_result_mem);

	input logic MemWrite_reg, read_en_reg, RegWrite_reg, clk, Reg3Loc_exe;
	input logic[1:0] MemToReg_reg;
	input logic[63:0] alu_result, data_b_ex, norm_result_exe;
	input logic[31:0] instr_reg_ex;
	
	output logic MemWrite_reg_mem, read_en_reg_mem, RegWrite_reg_mem, Reg3Loc_mem;
	output logic[1:0] MemToReg_reg_mem;
	output logic[63:0] alu_result_reg, data_b_mem, norm_result_mem;
	output logic[31:0] instr_reg_mem;
	
	genvar i;
	
	generate
	
		for (i = 0; i < 32; i++) begin : each_1
			D_FF each_dff(.q(instr_reg_mem[i]), .d(instr_reg_ex[i]), .reset(1'b0), .clk);
		end
		
		for (i = 0; i < 64; i++) begin : each_2
			D_FF each_dff(.q(alu_result_reg[i]), .d(alu_result[i]), .reset(1'b0), .clk);
		end
		
		for (i = 0; i < 2; i++) begin : each_3
			D_FF each_dff(.q(MemToReg_reg_mem[i]), .d(MemToReg_reg[i]), .reset(1'b0), .clk);
		end
		
		for (i = 0; i < 64; i++) begin : each_4
			D_FF each_dff(.q(data_b_mem[i]), .d(data_b_ex[i]), .reset(1'b0), .clk);
		end
		
		for (i = 0; i < 64; i++) begin : each_5
			D_FF each_dff(.q(norm_result_mem[i]), .d(norm_result_exe[i]), .reset(1'b0), .clk);
		end
		
	endgenerate
	
	// control signal
	D_FF each_dff_1(.q(MemWrite_reg_mem), .d(MemWrite_reg), .reset(1'b0), .clk);
	D_FF each_dff_2(.q(read_en_reg_mem), .d(read_en_reg), .reset(1'b0), .clk);
	D_FF each_dff_3(.q(RegWrite_reg_mem), .d(RegWrite_reg), .reset(1'b0), .clk);
	D_FF each_dff_4(.q(Reg3Loc_mem), .d(Reg3Loc_exe), .reset(1'b0), .clk);
	
endmodule
