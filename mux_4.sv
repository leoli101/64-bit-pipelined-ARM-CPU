`timescale 1ns/10ps
module mux_4(data_1, data_2, data_3, data_4, data_out, sel);

	input logic data_1, data_2, data_3, data_4;
	input logic[1:0] sel;
	
	output logic data_out;
	
	logic d1, d2;
	
	mux2_1 m_1(.data1_in(data_1), .data2_in(data_2), .data_out(d1), .sel(sel[0]));
	mux2_1 m_2(.data1_in(data_3), .data2_in(data_4), .data_out(d2), .sel(sel[0]));
	mux2_1 m_3(.data1_in(d1), .data2_in(d2), .data_out(data_out), .sel(sel[1]));
	
endmodule

module mux_4_testbench();
	logic data_1, data_2, data_3, data_4;
	logic[1:0] sel;
	
	logic data_out;
	
	mux_4 dut(.data_1, .data_2, .data_3, .data_4, .data_out, .sel);
	
	initial begin
		data_1 = 1; data_2 = 0; data_3 = 0; data_4 = 0; sel = 2'b00; #10;
		data_1 = 0; data_2 = 1; data_3 = 0; data_4 = 0; sel = 2'b01; #10;
		data_1 = 0; data_2 = 0; data_3 = 1; data_4 = 0; sel = 2'b10; #10;
		data_1 = 0; data_2 = 0; data_3 = 0; data_4 = 1; sel = 2'b11; #10;
	end
endmodule
