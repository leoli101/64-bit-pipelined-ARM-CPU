`timescale 1ns/10ps
module CPU(clk, reset);

	input logic clk, reset;
	
	logic[63:0] next_pc, cur_pc, norm_result, BR_addr, data_to_reg, next_pc_final;
	
	logic[31:0] instr;
	
	logic negative, overflow, RegWrite, Reg3Loc, Reg2Loc, isADDI, ALUSrc, MemWrite,
			zero, carry_out, UncondBr, BrTaken, is_BR, flag_en, read_en;
			
	logic overflow_reg, neg_reg, zero_reg, carry_out_reg;
						
	logic[1:0] MemToReg;
	logic[2:0] ALUop;
	
	// logic for forwarding content
	logic[63:0] alu_result, alu_result_reg;
	
	// logic for forwarding unit
	logic[31:0] instr_reg, instr_reg_ex, instr_reg_mem, instr_reg_wb;
	logic RegWrite_exe, RegWrite_reg_mem;
	
	// IF stage
	PC prog_counter(.instr_addr_in(next_pc_final), .instr_addr_out(cur_pc), .clk, .reset);
	
	instructmem instr_out(.address(cur_pc), .instruction(instr), .clk);
	
	logic overflow_2, carry_out_2;
	logic[63:0] norm_result_if;
	adder_64 adder2(.data_in_1(cur_pc), .data_in_2(64'd4), .data_out(norm_result_if), .overflow(overflow_2), .carry_out(carry_out_2));
	
	logic accelerated;
	or #0.05 or_1(accelerated, is_BR, BrTaken);
	mux64x2_1 ac(.data1_in(norm_result_if), .data2_in(next_pc), .data_out(next_pc_final), .sel(accelerated));
	
	// IF_RF_reg
	logic[63:0] pc_reg;
	IF_RF_register reg_1(.instr_in(instr), .instr_out(instr_reg), .clk, .pc_in(cur_pc), .pc_out(pc_reg), .norm_result_if, .norm_result);
	
	// logic for following stages
	logic[63:0] data_a_rf, data_b_rf;
	logic[63:0] data_a_ex, data_b_ex;
	logic isADDI_exe, MemWrite_exe, ALUSrc_exe, flag_en_exe, read_en_exe;
	logic[1:0] MemToReg_exe, MemToReg_reg_mem;
	logic[2:0] ALUop_exe;
	logic MemWrite_reg_mem, read_en_reg_mem;
	logic[63:0] data_to_reg_mem;
	logic[63:0] norm_result_exe, norm_result_mem;
	logic[63:0] data_b_mem;
	logic RegWrite_reg_wb;
	
	logic Reg3Loc_exe, Reg3Loc_mem, Reg3Loc_wb;

	
	// RF stage
	RF RF_stage(.instr_reg, .pc_reg, .next_pc, .data_a(data_a_rf), .data_b(data_b_rf), .data_to_reg, .RegWrite_reg(RegWrite_reg_wb), .neg_reg,
					.overflow_reg, .clk, .isADDI, .MemWrite, .ALUSrc, .flag_en, .read_en, .RegWrite, .MemToReg, .ALUop,
					.alu_result, .alu_result_reg, .instr_reg_ex, .instr_reg_mem, .RegWrite_exe, .RegWrite_reg_mem,
					.negative, .overflow, .flag_en_exe, .norm_result, .is_BR, .BrTaken, .instr_reg_wb, .Reg3Loc, .Reg3Loc_wb, .RegWrite_reg_wb,
					.norm_result_mem, .data_to_reg_mem);
	
	// RF_EXE_reg
	RF_EX_register reg_2(.data_a(data_a_rf), .data_b(data_b_rf), .isADDI, .MemWrite, .ALUSrc, .flag_en, .read_en, .RegWrite, .MemToReg, .ALUop,
						.data_a_ex, .data_b_ex, .isADDI_reg(isADDI_exe), .MemWrite_reg(MemWrite_exe), .ALUSrc_reg(ALUSrc_exe), .flag_en_reg(flag_en_exe), .read_en_reg(read_en_exe), 
						.RegWrite_reg(RegWrite_exe), .MemToReg_reg(MemToReg_exe), .ALUop_reg(ALUop_exe), .clk, .instr_reg, .instr_reg_ex, .Reg3Loc, .Reg3Loc_exe,
						.norm_result, .norm_result_exe);
	
	
	// EXE stage
	EX EX_stage(.data_a_ex, .data_b_ex, .isADDI_reg(isADDI_exe), .ALUSrc_reg(ALUSrc_exe), .ALUop_reg(ALUop_exe), .neg_reg, .zero_reg, .overflow_reg, .carry_out_reg,
		.flag_en_reg(flag_en_exe), .instr_reg_ex, .alu_result, .clk, .reset, .negative, .overflow);
		
	// EX_MEM_register
	EX_MEM_register reg_3(.MemWrite_reg(MemWrite_exe), .MemToReg_reg(MemToReg_exe), .read_en_reg(read_en_exe), .RegWrite_reg(RegWrite_exe), .instr_reg_ex, .alu_result,
						.MemWrite_reg_mem, .MemToReg_reg_mem, .read_en_reg_mem, .RegWrite_reg_mem, .instr_reg_mem, .alu_result_reg, .clk, .data_b_ex, .data_b_mem,
						.Reg3Loc_exe, .Reg3Loc_mem, .norm_result_exe, .norm_result_mem);

	// MEM stage
	MEM MEM_stage(.MemWrite_reg_mem, .MemToReg_reg_mem, .read_en_reg_mem, .RegWrite_reg_mem, .alu_result_reg, 
					.data_to_reg_mem, .data_b(data_b_mem), .norm_result_mem, .clk);
	
	// MEM_WB_reg
	MEM_WB_register reg_4(.data_to_reg_mem, .data_to_reg, .RegWrite_reg_mem, .RegWrite_reg_wb, .clk, .instr_reg_mem, .instr_reg_wb, .Reg3Loc_mem, .Reg3Loc_wb);
	
endmodule

module CPU_testbench();

	logic clk, reset;
	
	parameter ClockDelay = 100;
	
	CPU dut (.clk, .reset);
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
						@(posedge clk);
		reset <= 0; @(posedge clk);
						@(posedge clk);
		repeat(200)@(posedge clk);
		$stop;
	end
endmodule
