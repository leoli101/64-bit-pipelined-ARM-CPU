`timescale 1ns/10ps

module shift_2 (data_in, data_out);

	input logic[63:0] data_in;
	output logic[63:0] data_out;
	
	genvar i;
	
	generate
		for (i = 63; i > 1; i--) begin : each_itr
			assign data_out[i] = data_in[i-2];
		end
		
		assign data_out[1] = 0;
		assign data_out[0] = 0;
	endgenerate

endmodule

module shift_2_testbench();

	logic[63:0] data_in;
	logic[63:0] data_out;
	
	shift_2 dut(.data_in, .data_out);
	
	initial begin
		data_in = 64'd1; #10;
		data_in = 64'd10; #10;
		data_in = 64'hffffffffffffffff; #10;
	end
endmodule

