`timescale 1ns/10ps
module mux64x32_1 #(parameter WIDTH=64)(data_in, data_out, sel);

	input logic[0:31] data_in [WIDTH-1 : 0];
	input logic[4 : 0] sel;
	output logic[WIDTH-1 : 0] data_out;
	
	genvar i;
	generate
		for(i = 0; i < WIDTH; i++) begin : mux_each
			mux32_1 each(.data_in(data_in[i]), .data_out(data_out[i]), .sel);
		end
	endgenerate
endmodule


module mux64x32_1_testbench #(parameter WIDTH=64)();

	logic[0:31] data_in [WIDTH-1 : 0];
	logic[4 : 0] sel;
	logic[WIDTH-1 : 0] data_out;
	
	mux64x32_1 dut(.data_in, .data_out, .sel);
	
	initial begin
		data_in = {'1,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0
		,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0, '0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0
		,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0}; sel <= '1; #10;
		data_in = {'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0
		,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0
		,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,'0,{32{1'b1}}}; sel <= '0; #10;	
	end
	
endmodule
