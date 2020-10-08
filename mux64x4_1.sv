`timescale 1ns/10ps
module mux64x4_1(data1_in, data2_in, data3_in, data4_in, data_out, sel);

	input logic[63 : 0] data1_in, data2_in, data3_in, data4_in;
	input logic[1:0] sel;
	output logic[63 : 0] data_out;

	genvar i;
	generate
		for(i = 0; i < 64; i++) begin : mux_each
			mux4_1 each(.data_in({data1_in[i], data2_in[i], data3_in[i], data4_in[i]}), .data_out(data_out[i]), .sel);
		end
	endgenerate
endmodule

module mux64x4_1_testbench();
	
	logic[63 : 0] data1_in, data2_in, data3_in, data4_in;
	logic[1:0] sel;
	logic[63 : 0] data_out;
	
	mux64x4_1 dut(.data1_in, .data2_in, .data3_in, .data4_in, .data_out, .sel);
	
	initial begin
		data1_in = 64'd10; data2_in = 64'd100; data3_in = 64'd0; data4_in = 64'd5; sel = 2'b00; #10;
		data1_in = 64'd10; data2_in = 64'd100; data3_in = 64'd0; data4_in = 64'd5; sel = 2'b01; #10;
		data1_in = 64'd10; data2_in = 64'd100; data3_in = 64'd0; data4_in = 64'd5; sel = 2'b10; #10;
		data1_in = 64'd10; data2_in = 64'd100; data3_in = 64'd0; data4_in = 64'd5; sel = 2'b11; #10;
	end
endmodule
