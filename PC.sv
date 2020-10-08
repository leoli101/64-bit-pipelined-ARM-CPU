`timescale 1ns/10ps

module PC(instr_addr_in, instr_addr_out, clk, reset);

	input logic[63:0] instr_addr_in;
	output logic[63:0] instr_addr_out;
	input logic clk, reset;

	genvar i;
	
	generate
		for (i = 0; i < 64; i++) begin : each_itr
			D_FF each_dff(.q(instr_addr_out[i]), .d(instr_addr_in[i]), .reset, .clk);
		end
	endgenerate
endmodule
