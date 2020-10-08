`timescale 1ns/10ps
module full_adder(Cout, Sum, A, B, Cin);

	input logic A, B, Cin;
	output logic Cout, Sum;
	
	logic temp1, temp2, temp3;
	
	and #0.05 and_1(temp1, A, B);
	and #0.05 and_2(temp2, A, Cin);
	and #0.05 and_3(temp3, B, Cin);
	or #0.05 or_1(Cout, temp1, temp2, temp3);
	xor #0.05 xor_1(Sum, A, B, Cin);
	
endmodule

module full_adder_testbench();

	logic A, B, Cin;
	logic Cout, Sum;
	
	full_adder dut(.Cout, .Sum, .A, .B, .Cin);
	
	initial begin
		A = 0; B = 0; Cin = 0; #10;
		A = 0; B = 0; Cin = 1; #10;
		A = 0; B = 1; Cin = 0; #10;
		A = 0; B = 1; Cin = 1; #10;
		A = 1; B = 0; Cin = 0; #10;
		A = 1; B = 0; Cin = 1; #10;
		A = 1; B = 1; Cin = 0; #10;
		A = 1; B = 1; Cin = 1; #10;
	end
	
endmodule
