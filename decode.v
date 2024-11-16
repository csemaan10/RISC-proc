
 module risc_decode (clk, rst_n, instr, dmaddr, opnda, opndb, dst, du_opcode);
 // dmaddr: data memory address (for load and st instruction, must be extracted from the opcode)
 // opnda, opndb: addresses for operand a and operand b
 // dst is the destination register if applicable
	input wire clk;
	input wire rst_n;
	input wire [12:0] instr;
	output reg [3:0] dmaddr;
	output reg [2:0] opnda;
	output reg [2:0] opndb;
	output reg [2:0] dst;
	output reg [3:0] du_opcode;	
	
	// internal registers and net

	wire [3:0] opcode_i;
	reg [3:0] dmaddr_i;
	reg [2:0] opnda_i, opndb_i, dst_i;
	
	parameter ld = 4'b1110, st = 4'b1111;
	

	assign opcode_i = instr[12:9];

always @ (opcode_i or instr)
	begin

	case (opcode_i)
	ld: begin
	 dmaddr_i = instr[7:4];
	 dst_i = instr[2:0];
	 opnda_i = instr[7:4];
	end
	st: begin
	 dmaddr_i = instr[3:0];
	 dst_i = instr[3:0];
	 opnda_i = instr[6:4];
	 
	end
	default: begin
	 dst_i = instr[2:0];
	 opnda_i = instr[8:6];
	 opndb_i = instr[5:3];
	end	
	endcase
end

always @ (posedge clk or negedge rst_n)
 begin
  if (~rst_n)
	begin

		dmaddr <= 4'b0;
		opnda <= 3'b0;
		opndb <= 3'b0;
		dst <= 3'b0;
		du_opcode <= 4'b0;
		
	end
	else
	begin
	// pass the extracted information from the
   // instructions to the next unit, this include opcode,
  // dmaddr, dst, opnda, and opndb
		dmaddr <= dmaddr_i;
		opnda <= opnda_i;
		opndb <= opndb_i;
		dst <= dst_i;
		du_opcode <= opcode_i;	
		
	end
end
endmodule