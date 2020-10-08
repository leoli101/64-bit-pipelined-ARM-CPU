`timescale 1ns/10ps
module adder_64(data_in_1, data_in_2, data_out, overflow, carry_out);

	input logic[63:0] data_in_1, data_in_2;
	output logic[63:0] data_out;
	output logic overflow, carry_out;
	
	logic Cout[63:0];
	
	full_adder fa(.Cout(Cout[0]), .Sum(data_out[0]), .A(data_in_1[0]), .B(data_in_2[0]), .Cin(1'b0));
	genvar i;
	generate
		for (i = 1; i < 64; i++) begin : each_adder
			full_adder adder_each(.Cout(Cout[i]), .Sum(data_out[i]), .A(data_in_1[i]), .B(data_in_2[i]), .Cin(Cout[i-1]));
		end
	endgenerate
	
	
	xor #0.05 xor_1(overflow, Cout[63], Cout[62]);
	buf #0.05 co_1(carry_out, Cout[63]);
	
endmodule

module adder_64_testbench();

	logic[63:0] data_in_1, data_in_2;
	logic[63:0] data_out;
	logic negative, zero, overflow, carry_out;
	
	adder_64 dut(.data_in_1, .data_in_2, .data_out, .overflow, .carry_out);
	
	integer i;
	initial begin
		for(i = 0; i < 2**4; i++) begin
			data_in_1 = i; data_in_2 = i; #10; 
		end
		data_in_1 = 2**64 - 1; data_in_2 = 1; #10;
	end
endmodule

