


module SHA3_TB();

localparam STATE_SIZE = 1600;

reg [STATE_SIZE-1:0] in, in_conv, out_theta, out_theta_conv, out_rho, out_rho_conv,out_pi,out_pi_conv, out_chi, out_chi_conv, out_iota, out_iota_conv;
reg [0:63] rc_const;
int i,j;
function [STATE_SIZE-1:0] ConvertDataToCorrectFormat; 
	input [STATE_SIZE-1:0] in_f;
	for (i = 0; i < STATE_SIZE/8; i++) begin
		for (j = 0; j < 8; j++) begin
			ConvertDataToCorrectFormat[i*8+j] = in_f[(i+1)*8-j-1];
		end
	end
endfunction

assign rc_const = 64'h0000000000000001;

//THETA UUT1(
//	.IN(in_conv),
//	.OUT(out_theta_conv)
//);
//
//RHO UU2(
//	.IN(out_theta_conv),
//	.OUT(out_rho_conv)
//);
//
//PI UU3 (
//	.IN(out_rho_conv),
//	.OUT(out_pi_conv)
//);
//
//
//CHI UU4(
//	.IN(out_pi_conv),
//	.OUT(out_chi_conv)
//);
//
//IOTA UU5(
//	.IN(out_chi_conv),
//	.OUT(out_iota_conv),
//	.RC_CONSTANT(rc_const)
//);					 
//
//
assign in_conv = ConvertDataToCorrectFormat(in);
//assign out_theta = ConvertDataToCorrectFormat(out_theta_conv);
//assign out_rho = ConvertDataToCorrectFormat(out_rho_conv);
//assign out_pi =  ConvertDataToCorrectFormat(out_pi_conv);
//assign out_chi = ConvertDataToCorrectFormat(out_chi_conv);   
assign out_iota = ConvertDataToCorrectFormat(out_iota_conv);   

RND UUT(
	.IN(in_conv),
	.OUT(out_iota_conv),
	.RND_CONST(rc_const)
);

initial begin
	#0 $monitor("TIME = %0t \n in = %h  out_iota = %h",$time, in, out_iota);
	#5 in	<= {{40'h53587B9901},{1104{1'b0}},{8'h80},{448{1'b0}}};

end

endmodule