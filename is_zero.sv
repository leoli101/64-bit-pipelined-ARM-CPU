`timescale 1ns/10ps
module is_zero(data_in, data_out);

	input logic[63:0] data_in;
	output logic data_out;
	
	logic[15:0] temp;
	logic[3:0] temp2;
	
	genvar i, j;
	generate
		for (i = 0; i < 64; i+=4) begin : each_nor
			nor #0.05 nor_each(temp[i/4], data_in[i], data_in[i+1], data_in[i+2], data_in[i+3]);
		end
	endgenerate
	
	generate
		for (j = 0; j < 16; j+=4) begin: each_and
			and #0.05 and_each(temp2[j/4], temp[j], temp[j+1], temp[j+2], temp[j+3]);
		end
	endgenerate
	
	and #0.05 final_and(data_out, temp2[3], temp2[2], temp2[1], temp2[0]);
endmodule

module is_zero_testbench();

	logic[63:0] data_in;
	logic data_out;
	
	is_zero dut(.data_in, .data_out);
	
	initial begin
		data_in = 64'd1; #10;
		data_in = 64'd0; #10;
		data_in = 64'd10; #10;
		data_in = 64'h8000000000000000; #10;
	end
endmodule
