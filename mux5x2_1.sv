`timescale 1ns/10ps
module mux5x2_1(data1_in, data2_in, data_out, sel);

	input logic[4:0] data1_in, data2_in;
	output logic[4:0] data_out;
	input logic sel;
	
	genvar i;
	
	generate
		for (i = 0; i < 5; i++) begin : each_itr
			mux2_1 each_mux(.data1_in(data1_in[i]), .data2_in(data2_in[i]), .data_out(data_out[i]), .sel);
		end
	endgenerate
	
endmodule

module mux5x2_1_testbench();

	logic[4:0] data1_in, data2_in;
	logic[4:0] data_out;
	logic sel;
	
	mux5x2_1 dut(.data1_in, .data2_in, .data_out, .sel);
	
	initial begin
		data1_in = 5'd0; data2_in = 5'd10; sel = 1'b0; #10;
		data1_in = 5'd0; data2_in = 5'd10; sel = 1'b1; #10;
		data1_in = 5'd0; data2_in = 5'd31; sel = 1'b0; #10;
		data1_in = 5'd0; data2_in = 5'd31; sel = 1'b1; #10;
	end
endmodule
