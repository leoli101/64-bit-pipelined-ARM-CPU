`timescale 1ns/10ps
module MEM_WB_register(data_to_reg_mem, data_to_reg, RegWrite_reg_mem, RegWrite_reg_wb, clk, instr_reg_mem, instr_reg_wb,
								Reg3Loc_mem, Reg3Loc_wb);

	input logic[63:0] data_to_reg_mem;
	input logic[31:0] instr_reg_mem;
	input logic RegWrite_reg_mem, clk, Reg3Loc_mem;
	
	output logic[63:0] data_to_reg;
	output logic[31:0] instr_reg_wb;
	output logic RegWrite_reg_wb, Reg3Loc_wb;
	
	genvar i;
	
	generate
	
		for (i = 0; i < 64; i++) begin : each_1
			D_FF each_dff(.q(data_to_reg[i]), .d(data_to_reg_mem[i]), .reset(1'b0), .clk);
		end
		
		for (i = 0; i < 64; i++) begin : each_2
			D_FF each_dff(.q(instr_reg_wb[i]), .d(instr_reg_mem[i]), .reset(1'b0), .clk);
		end

	endgenerate

	// control signal
	D_FF each_dff(.q(RegWrite_reg_wb), .d(RegWrite_reg_mem), .reset(1'b0), .clk);
	D_FF each_dff_1(.q(Reg3Loc_wb), .d(Reg3Loc_mem), .reset(1'b0), .clk);
	
endmodule
