
module risc_regfile (clk, rst_n, rslt, reg_wr_vld, load_op,
    dst, dmdataout,opnda_addr, opndb_addr, oprnd_a, oprnd_b );


  input clk, rst_n, reg_wr_vld, load_op;
	input wire [7:0] rslt;
	input wire [2:0] opnda_addr;
	input wire [2:0] opndb_addr; 
	input wire [2:0] dst;
	input wire [7:0] dmdataout;
	output reg [7:0] oprnd_a;
	output reg [7:0] oprnd_b;
	  
	//specify which are wire or reg by width
	//inputs are wire for behavioral
	//wire [7:0] rslt, dmdataout;
	//wire [2:0] dst;
	wire[7:0] reg_data_in;
	

	reg [7:0] regfile0;
	reg [7:0] regfile1;
	reg [7:0] regfile2;
	reg [7:0] regfile3;
	reg [7:0] regfile4;
	reg [7:0] regfile5;
	reg [7:0] regfile6;
	reg [7:0] regfile7;
	
	// define an enable signal (type wire) for each register, 

	wire regfile0_enbl;
	wire regfile1_enbl;
	wire regfile2_enbl;
	wire regfile3_enbl;
	wire regfile4_enbl;
	wire regfile5_enbl;
	wire regfile6_enbl;
	wire regfile7_enbl;
	
	// enables for each register file
	// enable signals will be activated if the destination code addresses 
	// that perticular register AND if write valid signal is activated
	// complete this section for the rest of enable signals
	assign regfile0_enbl = (dst == 3'h0) & reg_wr_vld;
	assign regfile1_enbl = (dst == 3'h1) & reg_wr_vld;
	assign regfile2_enbl = (dst == 3'h2) & reg_wr_vld;
	assign regfile3_enbl = (dst == 3'h3) & reg_wr_vld;
	assign regfile4_enbl = (dst == 3'h4) & reg_wr_vld;
	assign regfile5_enbl = (dst == 3'h5) & reg_wr_vld;
	assign regfile6_enbl = (dst == 3'h6) & reg_wr_vld;
	assign regfile7_enbl = (dst == 3'h7) & reg_wr_vld;

    //define reg_mux outputs from the eight 2:1 muxs
    // the input data is calculated based on wether the instruction is  a load
	// or other data processing instructions
    assign reg_data_in = load_op ? dmdataout : rslt;
	//define the operation of the regfile
	
	
	// reset all regfiles (registers) when reset is activated
	// otherwise assign the input data (reg_data_in) to a register if its corresponding 
	// enable signal has been activated
	always @ (posedge clk or negedge rst_n)
		begin
		if (~rst_n) begin 
		   //reset all registers
			regfile0 <= 8'h00;
			regfile1 <= 8'h00;
			regfile2 <= 8'h00;
			regfile3 <= 8'h00;
			regfile4 <= 8'h00;
			regfile5 <= 8'h00;
			regfile6 <= 8'h00;
			regfile7 <= 8'h00;				
			
		end else begin 
		//when enable signal is activated pass in the data to a specific register
			if (regfile0_enbl) regfile0 <= reg_data_in;
			else if(regfile1_enbl) regfile1 <= reg_data_in;
			else if(regfile2_enbl) regfile2 <= reg_data_in;
			else if(regfile3_enbl) regfile3 <= reg_data_in;
			else if(regfile4_enbl) regfile4 <= reg_data_in;
			else if(regfile5_enbl) regfile5 <= reg_data_in;
			else if(regfile6_enbl) regfile6 <= reg_data_in;
			else if(regfile7_enbl) regfile7 <= reg_data_in;

			end
		end
	
	// in the following two always blocks we want to check which registers we must pass to
	// the output as operand a and operand b.
	
	
	// depending on opnda_addr, you must pass the required register content
	// to the oprnd_a. for example if opnda_addr=0, it mean regfile0 is operand a.
	
	always @ (opnda_addr or regfile0 or regfile1 or regfile2 or
	 regfile3 or regfile4 or regfile5 or regfile6 or
	 regfile7)
	  begin
	   case (opnda_addr)
	    3'b0: oprnd_a = regfile0;
	    3'b001: oprnd_a = regfile1;
		3'b010: oprnd_a = regfile2;
		3'b011: oprnd_a = regfile3;
		3'b100: oprnd_a = regfile4;
		3'b101: oprnd_a = regfile5;
		3'b110: oprnd_a = regfile6;
		3'b111: oprnd_a = regfile7;
		
		default: oprnd_a = 8'b0;
	 endcase
	end

	// make a simliar always block like above for operand b
	always @ (opndb_addr or regfile0 or regfile1 or regfile2 or
	 regfile3 or regfile4 or regfile5 or regfile6 or
	 regfile7)
	  begin
	   case (opndb_addr)
	    3'b0: oprnd_b = regfile0;
	    3'b001: oprnd_b = regfile1;
		3'b010: oprnd_b = regfile2;
		3'b011: oprnd_b = regfile3;
		3'b100: oprnd_b = regfile4;
		3'b101: oprnd_b = regfile5;
		3'b110: oprnd_b = regfile6;
		3'b111: oprnd_b = regfile7;
		
	  default: oprnd_b = 8'b0;
	 endcase
	end	
endmodule