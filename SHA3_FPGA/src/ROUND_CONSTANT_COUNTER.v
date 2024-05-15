`define Z_WIDTH 64

module ROUND_CONSTANT_COUNTER (
	input CLK,
	input A_RST,
	output [0:`Z_WIDTH-1] OUT,
	output FIRST_ROUND
	);

reg [0:`Z_WIDTH-1] out_reg;
reg first_round_reg;
reg [0:4] twenty_four_counter;


always @(posedge CLK or posedge A_RST)
begin
	if (A_RST)
	   twenty_four_counter	<=	0;
	else 
		if(CLK) begin
			twenty_four_counter	<=	(twenty_four_counter == 5'h17) ? 0 : twenty_four_counter + 1;
		end
end

always @(posedge CLK or posedge A_RST)
begin
	if (A_RST) begin
	   out_reg			<=	{`Z_WIDTH{1'b0}};
	   first_round_reg 	<=	1'b0;
	end else 
		if(CLK) begin
			first_round_reg		<=	twenty_four_counter == 0 ? 1'b1 : 1'b0;
			case(twenty_four_counter)
				5'b00000 : out_reg	<=	`Z_WIDTH'h0000000000000001;	
				5'b00001 : out_reg	<=	`Z_WIDTH'h0000000000008082;
				5'b00010 : out_reg	<=	`Z_WIDTH'h800000000000808a;
				5'b00011 : out_reg	<=	`Z_WIDTH'h8000000080008000;
				5'b00100 : out_reg	<=	`Z_WIDTH'h000000000000808b;
				5'b00101 : out_reg	<=	`Z_WIDTH'h0000000080000001;
				5'b00110 : out_reg	<=	`Z_WIDTH'h8000000080008081;
				5'b00111 : out_reg	<=	`Z_WIDTH'h8000000000008009;
				5'b01000 : out_reg	<=	`Z_WIDTH'h000000000000008a;
				5'b01001 : out_reg	<=	`Z_WIDTH'h0000000000000088;                    
				5'b01010 : out_reg	<=	`Z_WIDTH'h0000000080008009;                     
				5'b01011 : out_reg	<=	`Z_WIDTH'h000000008000000a;                    
				5'b01100 : out_reg	<=	`Z_WIDTH'h000000008000808b;                     
				5'b01101 : out_reg	<=	`Z_WIDTH'h800000000000008b;                     
				5'b01110 : out_reg	<=  `Z_WIDTH'h8000000000008089;                     
				5'b01111 : out_reg  <=	`Z_WIDTH'h8000000000008003;
				5'b10000 : out_reg	<=	`Z_WIDTH'h8000000000008002;	
				5'b10001 : out_reg	<=	`Z_WIDTH'h8000000000000080;
				5'b10010 : out_reg	<=	`Z_WIDTH'h000000000000800a;
				5'b10011 : out_reg	<=	`Z_WIDTH'h800000008000000a;
				5'b10100 : out_reg	<=	`Z_WIDTH'h8000000080008081;
				5'b10101 : out_reg	<=	`Z_WIDTH'h8000000000008080;
				5'b10110 : out_reg	<=	`Z_WIDTH'h0000000080000001;
				5'b10111 : out_reg	<=	`Z_WIDTH'h8000000080008008;
				default  : out_reg	<=	`Z_WIDTH'h0000000000000000;		
			endcase
		end
end

assign OUT = out_reg;
assign FIRST_ROUND = first_round_reg;

endmodule


