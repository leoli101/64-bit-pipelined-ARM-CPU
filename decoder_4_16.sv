`timescale 1ns/10ps

module decoder_4_16 (input_select, enable, output_select);	
	input logic enable;
	input logic [3:0] input_select;
	output logic [15:0] output_select;
	
	logic [3:0] first_select;
	
	decoder_2_4 firstDecoder(input_select[3:2], enable, first_select);
	
	decoder_2_4 output_15to12 (input_select[1:0], first_select[3], output_select[15:12]);
	decoder_2_4 output_11to8 (input_select[1:0], first_select[2], output_select[11:8]);
	decoder_2_4 output_7to4 (input_select[1:0], first_select[1], output_select[7:4]);
	decoder_2_4 output_3to0 (input_select[1:0], first_select[0], output_select[3:0]);
	
endmodule
