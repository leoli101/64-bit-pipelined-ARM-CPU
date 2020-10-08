`timescale 1ns/10ps
module regfile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, ReadData1, ReadData2, RegWrite, clk);
	input logic[4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input logic[63 : 0] WriteData;
	input logic RegWrite, clk;
	output logic[63 : 0] ReadData1, ReadData2;
	
	logic[31:0] temp;
	logic[63:0] reg_out [0 : 31];
	logic[0:31] reg_inversed [63 : 0];
	decoder decoder_1(.enable(RegWrite), .input_select(WriteRegister), .output_select(temp));
	
	genvar i;
	generate
		for(i=0; i<31; i++) begin : each_reg
			
			registerx64 each(.data_in(WriteData), .data_out(reg_out[i]), .wr_en(temp[i]), .clk);
		end
	endgenerate
		
	registerx64 each(.data_in(64'b0), .data_out(reg_out[31]), .wr_en(1'b1), .clk);
	
	genvar j, k;
	generate
		for(j=0; j<32; j++) begin : each_row
			for(k=0; k<64; k++) begin : each_col
				buf #0.05 buf_1(reg_inversed[k][j], reg_out[j][k]);
			end
		end
	endgenerate
	
	mux64x32_1 mux_1(.data_in(reg_inversed), .data_out(ReadData1), .sel(ReadRegister1));
	mux64x32_1 mux_2(.data_in(reg_inversed), .data_out(ReadData2), .sel(ReadRegister2));
endmodule
