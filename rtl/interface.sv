interface up_if(input bit clk);
	logic rst_h;
	logic [3:0] out;
clocking drv_cb@(posedge clk);
	output rst_h;
endclocking
clocking mon_cb@(posedge clk);
	input rst_h;
 	input out;
endclocking
modport DRV (clocking drv_cb);
modport MON (clocking mon_cb);
endinterface
