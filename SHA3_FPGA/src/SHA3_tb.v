


module SHA3_TB();

localparam STATE_SIZE = 1600;

reg [STATE_SIZE-1:0] in, in_conv, out_theta, out_theta_conv, out_rho, out_rho_conv,out_pi,out_pi_conv, out_chi, out_chi_conv; 
int i,j;
function [STATE_SIZE-1:0] ConvertDataToCorrectFormat; 
	input [STATE_SIZE-1:0] in_f;
	for (i = 0; i < STATE_SIZE/8; i++) begin
		for (j = 0; j < 8; j++) begin
			ConvertDataToCorrectFormat[i*8+j] = in_f[(i+1)*8-j-1];
		end
	end
endfunction


THETA UUT1(
	.IN(in_conv),
	.OUT(out_theta_conv)
);

RHO UU2(
	.IN(out_theta_conv),
	.OUT(out_rho_conv)
);

PI UU3 (
	.IN(out_rho_conv),
	.OUT(out_pi_conv)
);


CHI UU4(
	.IN(out_pi_conv),
	.OUT(out_chi_conv)
);


assign in_conv = ConvertDataToCorrectFormat(in);
assign out_theta = ConvertDataToCorrectFormat(out_theta_conv);
assign out_rho = ConvertDataToCorrectFormat(out_rho_conv);
assign out_pi =  ConvertDataToCorrectFormat(out_pi_conv);
assign out_chi = ConvertDataToCorrectFormat(out_chi_conv);   

initial begin
	#0 $monitor("TIME = %0t \n in = %h \n out_theta = %h, \n out_rho = %h \n out_pi = %h \n out_chi = %h",$time, in, out_theta, out_rho, out_pi, out_chi);
	#5 in	<= {{40'h53587B9901},{1104{1'b0}},{8'h80},{448{1'b0}}};

end

endmodule