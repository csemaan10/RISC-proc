

//test bench for the execution unit
module risc_eunit_tb;

	wire dmenbl, rdwr, reg_wr_vld, load_op; //control signals
	reg clk;
	reg rst_n;
	reg [3:0] opcode;
	reg [3:0] dmaddrin;
	reg [7:0] oprnd_a;
	reg [7:0] oprnd_b;
	reg [2:0] dstin;
	wire [3:0] dmaddr;
	wire [7:0] rslt;
	wire [2:0] dst;
	wire [7:0] dmdatain;
//define clock
initial
 begin
   clk = 1'b0;
   forever
   #10 clk = ~clk;
end

initial //define input vectors
begin
 #0 rst_n = 1'b0;
	//add -------------------------------------------------------
	@ (negedge clk)
	rst_n = 1'b1;
	opcode = 4'b0001; //add
	oprnd_a = 3'b000; //00h + ffh
	oprnd_b = 3'b111; //rslt = ffh, next page
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, add, rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//sub -------------------------------------------------------
	opcode = 4'b0010; //sub
	oprnd_a = 3'b001; //22h - cch
	oprnd_b = 3'b110; //rslt = 56h
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, sub, rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//and -------------------------------------------------------
	opcode = 4'b0011; //and
	oprnd_a = 3'b010; //44h & aah
	oprnd_b = 3'b101; //rslt = 00h
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, and, rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//or --------------------------------------------------------
	opcode = 4'b0100; //or
	oprnd_a = 3'b011; //66h | 88h
	oprnd_b = 3'b100; //rslt = eeh
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, or , rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//xor -------------------------------------------------------
	opcode = 4'b0101; //xor
	oprnd_a = 3'b100; //88h ^ eeh
	oprnd_b = 3'b011; //rslt = 66h
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, xor, rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//inc -------------------------------------------------------
	opcode = 4'b0110; //inc
	oprnd_a = 3'b101; //aah + 1
	oprnd_b = 3'b000; //rslt = abh
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, inc, rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//dec --------------------------------------------------------
	opcode = 4'b0111; //dec
	oprnd_a = 3'b110; //cch - 1
	oprnd_b = 3'b000; //rslt = cbh
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, dec, rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//not --------------------------------------------------------
	opcode = 4'b1000; //not
	oprnd_a = 3'b111; //ffh = 00h
	oprnd_b = 3'b000; //rslt = 00h
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, not, rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//neg --------------------------------------------------------
	opcode = 4'b1001; //neg
	oprnd_a = 3'b000; //00h = 00h
	oprnd_b = 3'b000; //rslt = 00h
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, neg, rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//shr --------------------------------------------------------
	opcode = 4'b1010; //shr
	oprnd_a = 3'b001; //56h = 2bh
	oprnd_b = 3'b000; //rslt = 2bh
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, shr, rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//shl --------------------------------------------------------
	opcode = 4'b1011; //shl
	oprnd_a = 3'b010; //44h = 88h
	oprnd_b = 3'b000; //rslt = 88h
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, shl, rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//ror --------------------------------------------------------
	opcode = 4'b1100; //ror
	oprnd_a = 3'b011; //eeh = 77h
	oprnd_b = 3'b000; //rslt = 77h
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, ror, rslt = %h",	oprnd_a, oprnd_b, rslt); //next pag
	
	//rol --------------------------------------------------------
	opcode = 4'b1101; //rol
	oprnd_a = 3'b100; //66h = cch
	oprnd_b = 3'b000; //rslt = cch
	@ (negedge clk)
	$display ("oprnd_a = %h, oprnd_b = %h, rol, rslt = %h",	oprnd_a, oprnd_b, rslt);
	
	//-----------------------------------------------------------
	//Investigate the effect of the following lines on your circuit, 
	// which signals change as a result of the following three lines
	opcode = 4'b0000; //nop
	#20 opcode = 4'b1111; //st
	#20 opcode = 4'b0000; //nop
	#20 $stop;
end

risc_eunit inst1 (.clk(clk),
	.rst_n(rst_n),
	.opcode(opcode),
	.dmaddrin(dmaddrin),
	.oprnd_a(oprnd_a),
	.oprnd_b(oprnd_b),
	.dstin(dstin),
	.dmaddr(dmaddr),
	.rslt(rslt),
	.dst(dst),
	.dmdatain(dmdatain),
	.dmenbl(dmenbl),
	.rdwr(rdwr),
	.reg_wr_vld(reg_wr_vld),
	.load_op(load_op)
	);
endmodule