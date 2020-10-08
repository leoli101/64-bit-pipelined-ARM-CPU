`timescale 1ns/10ps

module instr_fetch(is_BR, UncondBr, BrTaken, Imm26, Imm19, reset, clk, BR_addr, norm_result, cur_pc, next_pc);

	input logic[63:0] BR_addr, cur_pc;
	input logic is_BR, UncondBr, BrTaken, reset, clk;
	input logic[25:0] Imm26;
	input logic[18:0] Imm19;
	// output logic[31:0] instr;
	output logic[63:0] norm_result, next_pc;
	
	logic[63:0] SE_Imm26, SE_Imm19, BrAddr, BrAddr_final;
	
	SignedExtend #(.WIDTH(19)) SE_1(.data_in(Imm19), .data_out(SE_Imm19));
	
	SignedExtend #(.WIDTH(26)) SE_2(.data_in(Imm26), .data_out(SE_Imm26));
	
	mux64x2_1 uncondbr(.data1_in(SE_Imm19), .data2_in(SE_Imm26), .data_out(BrAddr), .sel(UncondBr));
	
	shift_2 shifter(.data_in(BrAddr), .data_out(BrAddr_final));
	
	logic [63:0] Br_result;
	logic overflow_1, overflow_2, carry_out_1, carry_out_2;
	logic [63:0] not_BR;
	
	
	adder_64 adder1(.data_in_1(cur_pc), .data_in_2(BrAddr_final), .data_out(Br_result), .overflow(overflow_1), .carry_out(carry_out_1));
	
	adder_64 adder2(.data_in_1(cur_pc), .data_in_2(64'd4), .data_out(norm_result), .overflow(overflow_2), .carry_out(carry_out_2));
	
	
	mux64x2_1 brtaken(.data1_in(norm_result), .data2_in(Br_result), .data_out(not_BR), .sel(BrTaken));
	
	mux64x2_1 BR(.data1_in(not_BR), .data2_in(BR_addr), .data_out(next_pc), .sel(is_BR));
	
	// PC prog_counter(.instr_addr_in(next_pc), .instr_addr_out(cur_pc), .clk, .reset);
	
	// instructmem instr_out(.address(cur_pc), .instruction(instr), .clk);
	
endmodule

/*
module instr_fetch_testbench();

	logic[63:0] BR_addr;
	logic is_BR, UncondBr, BrTaken, reset, clk;
	logic[25:0] Imm26;
	logic[18:0] Imm19;
	logic[31:0] instr;
	logic[63:0] norm_result;
	
	instr_fetch dut(.is_BR, .UncondBr, .BrTaken, .Imm26, .Imm19, .reset, .clk, .BR_addr, .instr, .norm_result);
	
	parameter CLOCK_PERIOD=50;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		BR_addr <= 64'd100; is_BR <= 0; BrTaken <= 0; reset <= 1; UncondBr <= 0; @(posedge clk);
		BR_addr <= 64'd100; is_BR <= 0; BrTaken <= 0; reset <= 0; UncondBr <= 0; @(posedge clk);
		BR_addr <= 64'd100; is_BR <= 0; BrTaken <= 1; reset <= 0; UncondBr <= 0; Imm19 <= 19'd4; @(posedge clk);
		BR_addr <= 64'd100; is_BR <= 0; BrTaken <= 1; reset <= 0; UncondBr <= 1; Imm26 <= 26'd8; @(posedge clk);
		BR_addr <= 64'd100; is_BR <= 0; BrTaken <= 0; reset <= 0; UncondBr <= 0; @(posedge clk);
		BR_addr <= 64'd100; is_BR <= 1; @(posedge clk);
		@(posedge clk);
		$stop;
	end
	
endmodule
*/