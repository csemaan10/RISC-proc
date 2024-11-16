

//test bench for decode unit
module risc_decode_tb;
 //define the signals
	reg clk;
	reg rst_n;
	reg [12:0] instr;
	wire [3:0] dmaddr;
	wire [2:0] opnda;
	wire [2:0] opndb;
	wire [2:0] dst;
	wire [3:0] du_opcode;	
 initial
 begin
  clk = 1'b0;
  forever
  #10 clk = ~clk;
 end
initial
 begin
  #0 rst_n = 1'b0;
  #20 rst_n = 1'b1;
 end
 
initial
begin
	#20 instr = 13'h0208; //add
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h05f1; //sub
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h06aa; //and
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h08e3; //or
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h0b1c; //xor
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h0d45; //inc
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h0f86; //dec
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h11c7; //not
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h1200; //neg
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h1441; //shr
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h1682; //shl
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h18c3; //ror
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h1b04; //rol
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h1e00; //st
	#20 $display ("opcode=%b, opnda=%b, opndb=%b, dst=%b", instr[12:9], opnda, opndb, dst);
	#20 $stop;
end
//instantiate the behavioral module into the test bench
risc_decode inst1 (.clk(clk),
	.rst_n(rst_n),
	.instr(instr),
	.dmaddr(dmaddr),
	.opnda(opnda),
	.opndb(opndb),
	.dst(dst),
	.du_opcode(du_opcode)
	);
endmodule