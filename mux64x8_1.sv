`timescale 1ns/10ps
module mux64x8_1 #(parameter WIDTH=64)(data_in, data_out, sel);

	input logic[0:7] data_in [WIDTH-1 : 0];
	input logic[2 : 0] sel;
	output logic[WIDTH-1 : 0] data_out;
	
	genvar i;
	generate
		for(i = 0; i < WIDTH; i++) begin : mux_each
			mux8_1 each(.data_in(data_in[i]), .data_out(data_out[i]), .sel);
		end
	endgenerate
endmodule 