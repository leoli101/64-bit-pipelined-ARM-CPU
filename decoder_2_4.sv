`timescale 1ns/10ps

module decoder_2_4 (input_select, enable, output_select);
	input logic enable;
	input logic [1:0] input_select;
	output logic [3:0] output_select;
	
	logic [1:0] sel;
	
	decoder_1_2 findSel (.enable(enable), .input_select(input_select[1]), .output_select(sel));
	decoder_1_2 result0 (.enable(sel[0]), .input_select(input_select[0]), .output_select(output_select[1:0]));
	decoder_1_2 result1 (.enable(sel[1]), .input_select(input_select[0]), .output_select(output_select[3:2]));
	
endmodule
