

// behavioral iunit

// this unit will receive instruction from memory
// and pass it along to the decode section
// so you need an input to receive instruction and 
// an output to pass instruction to decode
module risc_iunit (clk, rst_n, instruction, pc, ir);

  input wire clk;
  input wire rst_n;
  input wire [12:0] instruction;
  output reg [4:0] pc;
  output reg [12:0] ir;
  
  parameter nop = 13'h0000; // this will be used as No operation instruction

  always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin

	 
		ir <= nop;
		pc <= 5'b0;
	  
   end else begin

	 // if the PC reached maximum value you must reset it
	 
		ir <= instruction;
		pc <= (pc + 1) % 32;
		
	end
  end
endmodule