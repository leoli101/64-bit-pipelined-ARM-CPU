`timescale 1ns/10ps
module alu(A, B, cntrl, result, negative, zero, overflow, carry_out);

	input logic[63:0] A, B;
	input logic[2:0] cntrl;
	output logic[63:0] result;
	output logic negative, zero, overflow, carry_out;
	
	logic[63:0] temp_1, temp_2, temp_3, temp_4;
	
	logic[63:0] arr_2d[0:7];
	logic[0:7] arr_2d_inv[63:0];
	
	assign arr_2d[0] = B;
	assign arr_2d[1] = 64'b0;
	assign arr_2d[2] = temp_1;
	assign arr_2d[3] = temp_1;
	assign arr_2d[4] = temp_2;
	assign arr_2d[5] = temp_3;
	assign arr_2d[6] = temp_4;
	assign arr_2d[7] = 64'b0;
	
	genvar i, j;
	generate
		for(i = 0; i < 8; i++) begin : each_i
			for(j = 0; j < 64; j++) begin : each_j
				assign arr_2d_inv[j][i] = arr_2d[i][j];
			end
		end
	endgenerate
	
	
	addsub as_1(.data_in_1(A), .data_in_2(B), .data_out(temp_1), .overflow(overflow), .carry_out(carry_out), .subtract(cntrl[0]));
	
	bit_and ba(.data_in_1(A), .data_in2(B), .data_out(temp_2));
	
	bit_or bo(.data_in_1(A), .data_in2(B), .data_out(temp_3));
	
	bit_xor bxo(.data_in_1(A), .data_in2(B), .data_out(temp_4));
	
	mux64x8_1 mux_final(.data_in(arr_2d_inv), .data_out(result), .sel(cntrl));
	
	assign negative = result[63];
	
	is_zero isz(.data_in(result), .data_out(zero));
	
endmodule