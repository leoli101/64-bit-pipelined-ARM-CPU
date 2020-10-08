`timescale 1ns/10ps
module MEM(MemWrite_reg_mem, MemToReg_reg_mem, read_en_reg_mem, RegWrite_reg_mem, alu_result_reg, 
			 data_to_reg_mem, data_b, norm_result_mem, clk);

	input logic MemWrite_reg_mem, read_en_reg_mem, RegWrite_reg_mem, clk;
	input logic[1:0] MemToReg_reg_mem;
	input logic[63:0] alu_result_reg, data_b, norm_result_mem;
	output logic[63:0] data_to_reg_mem;
	
	logic[63:0] dmem_out;
	
	datamem dmem(.address(alu_result_reg), .write_enable(MemWrite_reg_mem), .read_enable(read_en_reg_mem), .write_data(data_b),
					.clk, .xfer_size(4'd8), .read_data(dmem_out));
	
	// norm_result -> RF_EX_reg -> EX_MEM_reg -> norm_result_mem
	mux64x4_1 mem_2_reg(.data1_in(alu_result_reg), .data2_in(dmem_out), .data3_in(norm_result_mem),
								.data4_in(alu_result_reg), .data_out(data_to_reg_mem), .sel(MemToReg_reg_mem));
endmodule
