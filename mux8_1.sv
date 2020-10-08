`timescale 1ns/10ps
module mux8_1 #(parameter WIDTH=8)(data_in, data_out, sel);

	input logic[WIDTH-1 : 0] data_in;
	input logic[2 : 0] sel;
	output logic data_out;
	
	logic temp1, temp2;
	
	mux4_1 mux_1(.data_in(data_in[WIDTH-1 : 4]), .data_out(temp1), .sel(sel[1:0]));
	mux4_1 mux_2(.data_in(data_in[3 : 0]), .data_out(temp2), .sel(sel[1:0]));
	mux2_1 mux_3(.data1_in(temp1), .data2_in(temp2), .data_out(data_out), .sel(sel[2]));
endmodule

module mux8_1_testbench #(parameter WIDTH=8)();
	
	logic[WIDTH-1 : 0] data_in;
   logic[2 : 0] sel;
	logic data_out;
	
	mux8_1 dut(.data_in, .data_out, .sel);
	
	initial begin
		data_in = 8'd0; sel = 3'b000; #10;
		data_in = 8'd1; sel = 3'b111; #10;
		data_in = 8'd2; sel = 3'b110; #10;
		data_in = 8'd8; sel = 3'b100; #10;
		data_in = 8'd16; sel = 3'b011; #10;
		data_in = 8'd32; sel = 3'b010; #10;
		data_in = 8'd64; sel = 3'b001; #10;
		
	end
endmodule
