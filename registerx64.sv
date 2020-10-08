`timescale 1ns/10ps
module registerx64 #(parameter WIDTH=64)(data_in, data_out, wr_en, clk);
	
	input logic clk, wr_en;
	input logic[WIDTH-1 : 0] data_in;
	output logic[WIDTH-1 : 0] data_out;
	logic[WIDTH-1 : 0] arr;
	
	genvar i;
	generate
		for(i = 0; i<WIDTH; i++) begin: dff_each_loop
			mux2_1 mux_each(.data1_in(data_out[i]), .data2_in(data_in[i]), .data_out(arr[i]), .sel(wr_en));
			D_FF dff_each(.q(data_out[i]), .d(arr[i]), .reset(1'b0), .clk);
		end
	endgenerate
endmodule

`timescale 1ns/10ps
module registerx64_testbench();

	logic clk, reset, wr_en;
	logic[63 : 0] data_in;
	logic[63 : 0] data_out;
	
	registerx64 dut(.data_in, .data_out, .wr_en, .clk);
	parameter CLOCK_PERIOD=50;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i;
	initial begin
		wr_en <= 1'b1; data_in <= 64'b0; @(posedge clk);
		wr_en <= 1'b0; @(posedge clk);
		@(posedge clk);
		wr_en <= 1'b1; data_in <= 64'b1; @(posedge clk);
		wr_en <= 1'b0; @(posedge clk);
		@(posedge clk);
		wr_en <= 1'b1; data_in <= 64'd64; @(posedge clk);
		wr_en <= 1'b0; data_in <= 64'd128; @(posedge clk);
		@(posedge clk);	
		$stop;
	end
endmodule
