`timescale 1ns/10ps
module decoder (enable, input_select, output_select);
	input logic enable;
	input logic [4:0] input_select;
	output logic [31:0] output_select;
	
	logic [1:0] sel;
	
	decoder_1_2 findSel (.enable(enable), .input_select(input_select[4]), .output_select(sel));
	decoder_4_16 output_31to16 (input_select[3:0], sel[1], output_select[31:16]);
	decoder_4_16 output_15to0 (input_select[3:0], sel[0], output_select[15:0]);
	
endmodule


module decoder_5to32_testbench(); 
	logic [4:0] input_select;
	logic [31:0] output_select;
	logic clk, enable;
	
	decoder dut (.enable, .input_select, .output_select); 
	
	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin 
		clk <= 0; 
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 

	initial begin 
		@(posedge clk);
		enable <= 0;	@(posedge clk);
		enable <= 1; input_select <= 5'b00000;	@(posedge clk);
		input_select <= 5'b00001;	@(posedge clk);
		input_select <= 5'b00010; 	@(posedge clk);
		input_select <= 5'b00011;	@(posedge clk);
		input_select <= 5'b00100;	@(posedge clk);
		input_select <= 5'b00101; 	@(posedge clk);

		
		@(posedge clk); 
		@(posedge clk);
	  $stop;
	end
endmodule
