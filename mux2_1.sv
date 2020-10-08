`timescale 1ns/10ps
module mux2_1 (data1_in, data2_in, data_out, sel);

	input logic data1_in, data2_in;
	input logic sel;
	output logic data_out;
	logic temp, temp1, temp2;
	
	not #0.05 not_1(temp, sel);
	and #0.05 and_1(temp1, data1_in, temp);
	and #0.05 and_2(temp2, data2_in, sel);
	or #0.05 or_1(data_out, temp1, temp2);
endmodule

module mux2_1_testbench ();

	logic data1_in, data2_in;
	logic sel;
	logic data_out;
	
	mux2_1 dut(.data1_in, .data2_in, .data_out, .sel);
	
	initial begin
		data1_in = 1'b0; data2_in = 1'b0; sel = 1'b0; #10;
		data1_in = 1'b0; data2_in = 1'b0; sel = 1'b1; #10;
		data1_in = 1'b0; data2_in = 1'b1; sel = 1'b0; #10;
		data1_in = 1'b0; data2_in = 1'b1; sel = 1'b1; #10;
		data1_in = 1'b1; data2_in = 1'b0; sel = 1'b0; #10;
		data1_in = 1'b1; data2_in = 1'b0; sel = 1'b1; #10;
		data1_in = 1'b1; data2_in = 1'b1; sel = 1'b0; #10;
		data1_in = 1'b1; data2_in = 1'b1; sel = 1'b1; #10;
	end
endmodule
