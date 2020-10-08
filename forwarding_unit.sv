`timescale 1ns/10ps
module forwarding_unit(instr_reg, instr_reg_ex, instr_reg_mem, RegWrite_exe, RegWrite_reg_mem, sel_1, sel_2, sel_3);

	input logic[31:0] instr_reg, instr_reg_ex, instr_reg_mem;
	input logic RegWrite_exe, RegWrite_reg_mem;
	
	output logic[1:0] sel_1, sel_2;
	output logic sel_3;
	
	logic rd_ex_rn_rf, rd_mem_rn_rf, rd_ex_rm_rf, rd_mem_rm_rf;
	logic rd_ex_rd_rf, rd_mem_rd_rf;
	logic is31_ex, is31_mem;
	
	comparator_5 c_1(.data_1(instr_reg_ex[4:0]), .data_2(instr_reg[9:5]), .data_out(rd_ex_rn_rf));
	comparator_5 c_2(.data_1(instr_reg_mem[4:0]), .data_2(instr_reg[9:5]), .data_out(rd_mem_rn_rf));
	comparator_5 c_3(.data_1(instr_reg_ex[4:0]), .data_2(instr_reg[20:16]), .data_out(rd_ex_rm_rf));
	comparator_5 c_4(.data_1(instr_reg_mem[4:0]), .data_2(instr_reg[20:16]), .data_out(rd_mem_rm_rf));
	comparator_5 c_5(.data_1(instr_reg_ex[4:0]), .data_2(instr_reg[4:0]), .data_out(rd_ex_rd_rf));
	comparator_5 c_6(.data_1(instr_reg_mem[4:0]), .data_2(instr_reg[4:0]), .data_out(rd_mem_rd_rf));
	
	comparator_5 c_7(.data_1(instr_reg_ex[4:0]), .data_2(5'd31), .data_out(is31_ex));
	comparator_5 c_8(.data_1(instr_reg_mem[4:0]), .data_2(5'd31), .data_out(is31_mem));
	
	always_comb begin
		if (rd_ex_rn_rf == 1 && RegWrite_exe == 1 && is31_ex == 0) begin
			sel_1 = 2'b00;
		end else if (rd_mem_rn_rf == 1 && RegWrite_reg_mem == 1 && is31_mem == 0) begin
			sel_1 = 2'b10;
		end else if (instr_reg_mem[31:26] == 6'b100101 && instr_reg[9:5] == 5'd30) begin
			sel_1 = 2'b11;
		end else begin
			sel_1 = 2'b01;
		end
		
		if ((rd_ex_rm_rf == 1) && (RegWrite_exe == 1) && (is31_ex == 0)) begin
			sel_2 = 2'b00;
		end else if (rd_mem_rm_rf == 1 && RegWrite_reg_mem == 1 && is31_mem == 0) begin
			sel_2 = 2'b10;
		end else if (instr_reg_ex[31:21] == 11'b11010110000 && rd_ex_rd_rf == 1 && RegWrite_exe == 1 && is31_ex == 0) begin
			sel_2 = 2'b00;
		end else if (instr_reg_ex[31:21] == 11'b11010110000 && rd_mem_rd_rf == 1 && RegWrite_reg_mem == 1 && is31_mem == 0) begin
			sel_2 = 2'b10;
		end else if (instr_reg[31:21] == 11'b11111000000 && rd_ex_rd_rf == 1 && RegWrite_exe == 1 && is31_ex == 0) begin
			sel_2 = 2'b00;
		end else if (instr_reg[31:21] == 11'b11111000000 && rd_mem_rd_rf == 1 && RegWrite_reg_mem == 1 && is31_mem == 0) begin
			sel_2 = 2'b10;
		end else begin
			sel_2 = 2'b01;
		end
		
		if (instr_reg_mem[31:21] == 11'b11111000010 && rd_mem_rd_rf == 1 && RegWrite_reg_mem == 1 && is31_mem == 0) begin
			sel_3 = 1;
		end else begin
			sel_3 = 0;
		end
	end
endmodule
