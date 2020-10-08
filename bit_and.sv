`timescale 1ns/10ps

module bit_and(data_in_1, data_in2, data_out);
	input logic[63:0] data_in_1, data_in2;
	output logic[63:0] data_out;
	
	genvar i;
	generate
		for(i = 0; i < 64; i++) begin : eachAnd
			and #0.05 and_1(data_out[i], data_in_1[i], data_in2[i]);
		end
	endgenerate
	
endmodule 

module bit_or(data_in_1, data_in2, data_out);
	input logic[63:0] data_in_1, data_in2;
	output logic[63:0] data_out;
	
	genvar i;
	generate
		for(i = 0; i < 64; i++) begin : eachOr
			or #0.05 and_1(data_out[i], data_in_1[i], data_in2[i]);
		end
	endgenerate
	
endmodule 

module bit_xor(data_in_1, data_in2, data_out);
	input logic[63:0] data_in_1, data_in2;
	output logic[63:0] data_out;
	
	genvar i;
	generate
		for(i = 0; i < 64; i++) begin : eachXor
			xor #0.05 xor_1(data_out[i], data_in_1[i], data_in2[i]);
		end
	endgenerate
	
endmodule 