`timescale 1ns/10ps
module mux16_1 #(parameter WIDTH=16)(data_in, data_out, sel);

	input logic[WIDTH-1 : 0] data_in;
	input logic[3 : 0] sel;
	output logic data_out;
	
	logic temp1, temp2;
	
	mux8_1 mux_1(.data_in(data_in[WIDTH-1 : 8]), .data_out(temp1), .sel(sel[2:0]));
	mux8_1 mux_2(.data_in(data_in[7 : 0]), .data_out(temp2), .sel(sel[2:0]));
	mux2_1 mux_3(.data1_in(temp1), .data2_in(temp2), .data_out(data_out), .sel(sel[3]));
endmodule

module mux16_1_testbench #(parameter WIDTH=16)();
	
	logic[WIDTH-1 : 0] data_in;
	logic[3 : 0] sel;
	logic data_out;
	
	mux16_1 dut(.data_in, .data_out, .sel);
	
	initial begin
		data_in = 16'd0; sel = 4'b0000; #10;
		data_in = 16'd1; sel = 4'b1111; #10;
		data_in = 16'd2; sel = 4'b1110; #10;
		data_in = 16'd128; sel = 4'b1000; #10;
		data_in = 16'd32768; sel = 4'b0000; #10;
		
	end
endmodule