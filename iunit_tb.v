

//test bench for iunit
module risc_iunit_tb;

	reg clk;
	reg rst_n;
	reg [12:0] instruction;
	wire [4:0] pc;
	wire [12:0] ir;	
	
	//define clock
	initial	begin
		clk = 1'b0;
		forever 
			#10 clk = ~clk;
	end
//define reset and simulation duration
//define instruction
	initial
	 begin	 
		clk = 0;
		rst_n = 0;
		
		#20 rst_n = 1'b0;
		instruction = 13'h0208; //pc = 00
		$display ("pc = %h, instruction = %h, ir = %h", pc, instruction, ir);
		
		#20 rst_n = 1'b1;
		#20 instruction = 13'h05f1; //pc = 01; sub
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#20 instruction = 13'h06aa; //pc = 02; and
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#20 instruction = 13'h08e3; //pc = 03; or
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#20 instruction = 13'h0b24; //pc = 04; xor
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#20 instruction = 13'h0d45; //pc = 05; inc
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#20 instruction = 13'h0f86; //pc = 06; dec
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#20 instruction = 13'h11c7; //pc = 07; not
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#20 instruction = 13'h1200; //pc = 08; neg
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#20 instruction = 13'h1441; //pc = 09; shr
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#20 instruction = 13'h1682; //pc = 10; shl
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#20 instruction = 13'h18c3; //pc = 11; ror
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#20 instruction = 13'h1b04; //pc = 12; rol
		$display ("pc = %h, instruction = %h, ir = %h",	pc, instruction, ir);
		
		#500 $stop;
end
//instantiate the behavioral module into the test bench


risc_iunit inst1 (
	.clk(clk),
	.rst_n(rst_n),
	.instruction(instruction),
	.pc(pc),
	.ir(ir)
);
endmodule