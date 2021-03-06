`timescale 1ns/10ps
module comparator_5(data_1, data_2, data_out);

	input logic[4:0] data_1, data_2;
	output logic data_out;
	
	logic res_1, res_2, res_3, res_4, res_5, res_6, res_7;
	
	xor #0.05 xor_1(res_1, data_1[4], data_2[4]);
	xor #0.05 xor_2(res_2, data_1[3], data_2[3]);
	xor #0.05 xor_3(res_3, data_1[2], data_2[2]);
	xor #0.05 xor_4(res_4, data_1[1], data_2[1]);
	xor #0.05 xor_5(res_5, data_1[0], data_2[0]);
	
	or #0.05 or_1(res_6, res_1, res_2, res_3, res_4);
	or #0.05 or_2(res_7, res_6, res_5);
	assign data_out = ~res_7;
endmodule

module comparator_5_testbench();

	logic[4:0] data_1, data_2;
	logic data_out;
	
	comparator_5 dut(.data_1, .data_2, .data_out);
	
	initial begin
		data_1 = 5'b10000; data_2 = 5'b00001; #10;
		data_1 = 5'b10000; data_2 = 5'b10000; #10;
	end
endmodule
