


module SHA3_TB();

localparam STATE_SIZE = 1600;
localparam R_BLOCK_SIZE = 1152;
//reg [0:STATE_SIZE-1] rnd_in, s_reg, out;
reg [0:STATE_SIZE-1] out, out_conv; 
//wire [0:STATE_SIZE-1] rnd_out;
//wire [0:63] round_constant;
reg [0:R_BLOCK_SIZE-1] in,in_conv;
reg CLK, A_RST;
reg first_rnd;

int i,j;
function [STATE_SIZE-1:0] ConvertData1600; 
	input [STATE_SIZE-1:0] in_f;
	for (i = 0; i < STATE_SIZE/8; i++) begin
		for (j = 0; j < 8; j++) begin
			ConvertData1600[i*8+j] = in_f[(i+1)*8-j-1];
		end
	end
endfunction

function [R_BLOCK_SIZE-1:0] ConvertDataRBlock; 
	input [R_BLOCK_SIZE-1:0] in_f;
	for (i = 0; i < R_BLOCK_SIZE/8; i++) begin
		for (j = 0; j < 8; j++) begin
			ConvertDataRBlock[i*8+j] = in_f[(i+1)*8-j-1];
		end
	end
endfunction


PERMUTATION_MODULE #(
	.R_BLOCK_SIZE(1152)
	) UUT1 (
	.IN(in_conv),
	.OUT(out_conv),
	.CLK(CLK),
	.A_RST(A_RST)
);
	

assign in_conv = ConvertDataRBlock(in);
assign out = ConvertData1600(out_conv);
	
initial begin
	#0 $monitor("TIME = %0t \n in = %h \n in_conv = %h \n out = %h ",$time, in, in_conv, out);
	#5 in	<= {{40'h53587B9901},{1104{1'b0}},{8'h80}};

end

initial begin
	CLK = 1'b1;
	forever 
	#5 CLK = ~CLK;
end

initial begin
	A_RST = 1'b1;
	#50 A_RST = 1'b0;
end 

endmodule