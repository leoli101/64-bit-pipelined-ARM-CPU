`timescale 1ns/10ps
module mux64_4(data_1, data_2, data_3, data_4, data_out, sel);

	input logic[63:0] data_1, data_2, data_3, data_4;
	input logic[1:0] sel;
	
	output logic[63:0] data_out;
	
	genvar i;
	
	generate
		for (i = 0; i < 64; i++) begin : each_mux
			mux_4 each_1(.data_1(data_1[i]), .data_2(data_2[i]), .data_3(data_3[i]), .data_4(data_4[i]), .data_out(data_out[i]), .sel);
		end
	endgenerate
	
endmodule

module mux64_4_testbench();

	logic[63:0] data_1, data_2, data_3, data_4;
	logic[1:0] sel;
	
	logic[63:0] data_out;
	
	mux64_4 dut(.data_1, .data_2, .data_3, .data_4, .data_out, .sel);
	
	initial begin
		data_1 = 64'd1; data_2 = 64'd10; data_3 = 64'd100; data_4 = 64'd1000; sel = 2'b00; #10;
		data_1 = 64'd1; data_2 = 64'd10; data_3 = 64'd100; data_4 = 64'd1000; sel = 2'b01; #10;
		data_1 = 64'd1; data_2 = 64'd10; data_3 = 64'd100; data_4 = 64'd1000; sel = 2'b10; #10;
		data_1 = 64'd1; data_2 = 64'd10; data_3 = 64'd100; data_4 = 64'd1000; sel = 2'b11; #10;
	end
	
endmodule
