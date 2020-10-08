`timescale 1ns/10ps
module addsub(data_in_1, data_in_2, data_out, overflow, carry_out, subtract);

	input logic[63:0] data_in_1, data_in_2;
	input logic subtract;
	output logic[63:0] data_out;
	output logic overflow, carry_out;
	
	logic[63:0] temp, actual_data_2, neg_data_2;
	logic[63:0] add_to_data_2;
	logic dc_1, dc_2;
	
	genvar i;
	generate
		for(i = 0; i < 64; i++) begin : eachneg
			not #0.05 each_neg(neg_data_2[i], data_in_2[i]);
		end
	endgenerate
	
	mux64x2_1 m1(.data1_in(data_in_2), .data2_in(neg_data_2), .data_out(temp), .sel(subtract));
	mux64x2_1 m2(.data1_in(64'd0), .data2_in(64'd1), .data_out(add_to_data_2), .sel(subtract));
	adder_64 ad_first(.data_in_1(temp), .data_in_2(add_to_data_2), .data_out(actual_data_2), .overflow(dc_1), .carry_out(dc_2));
	
	adder_64 ad_final(.data_in_1, .data_in_2(actual_data_2), .data_out, .overflow, .carry_out);
	
endmodule

module addsub_testbench();

	logic[63:0] data_in_1, data_in_2;
	logic subtract;
	logic[63:0] data_out;
	logic negative, zero, overflow, carry_out;
	
	addsub dut(data_in_1, data_in_2, data_out, overflow, carry_out, subtract);
	
	initial begin
		data_in_1 = 1; data_in_2 = 1; subtract = 1; #10;
		data_in_1 = 0; data_in_2 = 1; subtract = 0; #10;
		data_in_1 = -1; data_in_2 = 1; subtract = 0; #10;
		data_in_1 = 0; data_in_2 = 1; subtract = 1; #10;
		data_in_1 = -1; data_in_2 = -1; subtract = 1; #10;
		data_in_1 = -1; data_in_2 = -1; subtract = 0; #10;
//		data_in_1 = 1; data_in_2 = 1; subtract = 1; #10;
//		data_in_1 = 1; data_in_2 = 1; subtract = 1; #10;
//		data_in_1 = 1; data_in_2 = 1; subtract = 1; #10;
//		data_in_1 = 1; data_in_2 = 1; subtract = 1; #10;
//		data_in_1 = 1; data_in_2 = 1; subtract = 1; #10;
//		data_in_1 = 1; data_in_2 = 1; subtract = 1; #10;
//		data_in_1 = 1; data_in_2 = 1; subtract = 1; #10;

	end
endmodule
