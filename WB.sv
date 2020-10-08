module WB(RegWrite_reg_wb, dmem_out_reg, norm_result_wb, alu_result_wb, data_to_reg);

	input logic RegWrite_reg_wb;
	input logic[63:0] dmem_out_reg, norm_result_wb, alu_result_wb;
	
	output logic[63:0] data_to_reg;
	
	mux64x4_1 mem_2_reg(.data1_in(alu_result_wb), .data2_in(dmem_out_reg), .data3_in(norm_result_wb),
								.data4_in(alu_result_wb), .data_out(data_to_reg), .sel(MemToReg));
endmodule
