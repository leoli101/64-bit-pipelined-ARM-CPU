`timescale 1ns/10ps
module mux4_1 #(parameter WIDTH=4)(data_in, data_out, sel);

	input logic[WIDTH-1 : 0] data_in;
	input logic[1 : 0] sel;
	output logic data_out;
	
	logic temp1, temp2;
	
	mux2_1 mux_1(.data1_in(data_in[3]), .data2_in(data_in[2]), .data_out(temp1), .sel(sel[0]));
	mux2_1 mux_2(.data1_in(data_in[1]), .data2_in(data_in[0]), .data_out(temp2), .sel(sel[0]));
	mux2_1 mux_3(.data1_in(temp1), .data2_in(temp2), .data_out(data_out), .sel(sel[1]));
endmodule

module mux4_1_testbench #(parameter WIDTH=4)();

	logic[WIDTH-1 : 0] data_in;
	logic[1 : 0] sel;
	logic data_out;
	
	mux4_1 dut(.data_in, .data_out, .sel);
	
	initial begin
		data_in = 4'b0000; sel = 2'b00; #10;
		data_in = 4'b0001; sel = 2'b11; #10;
		data_in = 4'b0010; sel = 2'b10; #10;
		data_in = 4'b0100; sel = 2'b01; #10;
		data_in = 4'b1000; sel = 2'b00; #10;
	end
endmodule
