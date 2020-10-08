`timescale 1ns/10ps
module mux64x2_1 #(parameter WIDTH=64)(data1_in, data2_in, data_out, sel);

	input logic[WIDTH-1 : 0] data1_in, data2_in;
	input logic sel;
	output logic[WIDTH-1 : 0] data_out;

	genvar i;
	generate
		for(i = 0; i < WIDTH; i++) begin : mux_each
			mux2_1 each(.data1_in(data1_in[i]), .data2_in(data2_in[i]), .data_out(data_out[i]), .sel);
		end
	endgenerate
endmodule

module mux64x2_1_testbench #(parameter WIDTH=64)();

	logic[WIDTH-1 : 0] data1_in, data2_in;
	logic sel;
	logic[WIDTH-1 : 0] data_out;
	
	mux64x2_1 dut(.data1_in, .data2_in, .data_out, .sel);
	
	initial begin
		data1_in = 64'b0; data2_in = 64'b0; sel = 1'b0; #10;
		data1_in = 64'b0; data2_in = 64'b0; sel = 1'b1; #10;
		data1_in = 64'b0; data2_in = 64'b1; sel = 1'b0; #10;
		data1_in = 64'b0; data2_in = 64'b1; sel = 1'b1; #10;
		data1_in = 64'b1; data2_in = 64'b0; sel = 1'b0; #10;
		data1_in = 64'b1; data2_in = 64'b0; sel = 1'b1; #10;
		data1_in = 64'b1; data2_in = 64'b1; sel = 1'b0; #10;
		data1_in = 64'b1; data2_in = 64'b1; sel = 1'b1; #10;
	end
endmodule
