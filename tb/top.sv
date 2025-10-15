module top;
	import uvm_pkg::*;
	import up_counter_pkg::*;
	bit clk;
	always
		#5 clk =~clk;
	up_if inf(clk);
	up_counter dut(.clk(clk),.rst_h(inf.rst_h),.out(inf.out));
	initial
		begin
			uvm_config_db#(virtual up_if)::set(null,"*","vif",inf);
			run_test("up_test");
		end
	property p_reset;
		@(posedge clk) disable iff(!inf.rst_h) 
			inf.rst_h |=> (inf.out == 4'b0);
	endproperty
	/*property reset_low;
		@(posedge clk) (!inf.rst_h)
			inf.rst |=> inf.out == inf.out + 1;
	endproperty*/
	assert property (p_reset);
	//assert property (reset_low);
endmodule
