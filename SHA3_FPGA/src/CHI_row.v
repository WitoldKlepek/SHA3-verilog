`define ROW_SIZE 5

module CHI_row (
	input [0:`ROW_SIZE-1] IN,
	output [0:`ROW_SIZE-1] OUT
	);

reg [0:`ROW_SIZE-1] out_reg;	

always_comb
begin
	out_reg[0] = IN[0] ^ (!IN[1] & IN[2]);
	out_reg[1] = IN[1] ^ (!IN[2] & IN[3]);	
	out_reg[2] = IN[2] ^ (!IN[3] & IN[4]);
	out_reg[3] = IN[3] ^ (!IN[4] & IN[0]);	
	out_reg[4] = IN[4] ^ (!IN[0] & IN[1]);	
end

assign OUT = out_reg;

endmodule