`timescale 1ns/10ps
module IF_RF_register(instr_in, instr_out, clk, pc_in, pc_out, norm_result_if, norm_result);

	input logic clk;
	input logic[31:0] instr_in;
	input logic[63:0] pc_in, norm_result_if;
	output logic[63:0] pc_out, norm_result;
	output logic[31:0] instr_out;
	
	genvar i;
	
	generate
		for (i = 0; i < 32; i++) begin : each_dff
			D_FF dff_itr(.q(instr_out[i]), .d(instr_in[i]), .reset(1'b0), .clk(clk));
		end
		
		for (i = 0; i < 64; i++) begin : each_dff_1
			D_FF dff_itr(.q(pc_out[i]), .d(pc_in[i]), .reset(1'b0), .clk(clk));
		end
		
		for (i = 0; i < 64; i++) begin : each_dff_2
			D_FF dff_itr(.q(norm_result[i]), .d(norm_result_if[i]), .reset(1'b0), .clk(clk));
		end
	endgenerate
endmodule

//module IF_RF_register_testbench();
//
//	logic clk;
//	logic[63:0] instr_in;
//	logic[63:0] instr_out;
//	
//	IF_RF_register dut(.instr_in, instr_out, clk);
//	
//	parameter CLOCK_PERIOD=50;
//	initial begin
//		clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk;
//	end
//	
//	initial begin
//	
//	end
//endmodule


