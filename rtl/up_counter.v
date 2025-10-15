module up_counter(out,clk,rst_h);
	input clk,rst_h;
	output reg[3:0] out = 4'd0;
	always @(posedge clk)
		begin
		       if(rst_h==1)
		       	out <= 4'd0;
 			else 
			out <= out + 1;
		end
endmodule
