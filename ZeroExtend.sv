`timescale 1ns/10ps

module ZeroExtend #(parameter WIDTH=8) (data_in, data_out);

	input logic[WIDTH-1:0] data_in;
	output logic[63:0] data_out;
	
	initial assert(WIDTH > 0 && WIDTH < 64);
	
	genvar i;
	generate
		for (i = 0; i < WIDTH; i++) begin : first_loop
			assign data_out[i] = data_in[i];
		end
		
		for (i = WIDTH; i < 64; i++) begin : second_loop
			assign data_out[i] = 1'b0;
		end
	endgenerate
endmodule

module ZeroExtend_testbench();

	logic[7:0] data_in;
	logic[63:0] data_out;
	
	ZeroExtend dut(.data_in, .data_out);
	
	initial begin
		data_in = 8'b10000000; #10;
		data_in = 8'b01111111; #10;
		data_in = 8'b00000000; #10;
	end
endmodule

