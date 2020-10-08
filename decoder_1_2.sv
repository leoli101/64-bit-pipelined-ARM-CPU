`timescale 1ns/10ps
module decoder_1_2 (enable, input_select, output_select);
	input logic enable;
	input logic input_select;
	output logic [1:0] output_select;
	
	logic not_input;
	not #0.05 tempNot(not_input, input_select);
	
	and #0.05 result1 (output_select[1], input_select, enable);
	and #0.05 result0 (output_select[0], not_input, enable);
endmodule 