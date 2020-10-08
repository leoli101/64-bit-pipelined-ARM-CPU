`timescale 1ns/10ps
module flag_reg(new_flag, flag_en, q, clk, reset);
	input logic new_flag, clk, reset, flag_en;
	output logic q;
	logic d;
	
	mux2_1 mux_1(.data1_in(q), .data2_in(new_flag), .data_out(d), .sel(flag_en));
	
	D_FF dff_1(.q, .d, .reset, .clk);

endmodule

module flag_reg_testbench();
	logic new_flag, clk, reset, flag_en;
	logic q;
	
	flag_reg dut(.new_flag, .flag_en, .q, .clk, .reset);
	
	parameter CLOCK_PERIOD=50;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		new_flag <= 1; flag_en <= 0; reset <= 0; @(posedge clk);
		new_flag <= 1; flag_en <= 1; reset <= 0; @(posedge clk);
		new_flag <= 0; flag_en <= 0; reset <= 0; @(posedge clk);
		new_flag <= 0; flag_en <= 1; reset <= 0; @(posedge clk);
		@(posedge clk);
		$stop;
	end
endmodule

