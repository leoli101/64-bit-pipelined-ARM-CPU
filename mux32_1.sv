`timescale 1ns/10ps
module mux32_1 #(parameter WIDTH=32)(data_in, data_out, sel);

	input logic[WIDTH-1 : 0] data_in;
	input logic[4 : 0] sel;
	output logic data_out;
	
	logic temp1, temp2;
	
	mux16_1 mux_1(.data_in(data_in[WIDTH-1 : 16]), .data_out(temp1), .sel(sel[3:0]));
	mux16_1 mux_2(.data_in(data_in[15 : 0]), .data_out(temp2), .sel(sel[3:0]));
	mux2_1 mux_3(.data1_in(temp1), .data2_in(temp2), .data_out(data_out), .sel(sel[4]));
endmodule

module mux32_1_testbench #(parameter WIDTH=32)();
	
	logic[WIDTH-1 : 0] data_in;
	logic[4 : 0] sel;
	logic data_out;
	
	mux32_1 dut(.data_in, .data_out, .sel);
	
	initial begin
		data_in = 32'd0; sel = 5'b00000; #10;
		data_in = 32'd1; sel = 5'b11111; #10;
		data_in = 32'd2; sel = 5'b11110; #10;
		data_in = 32'd32768; sel = 5'b10000; #10;
		data_in = 32'd2147483648; sel = 5'b00000; #10;
		
	end
endmodule
