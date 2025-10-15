class up_driver extends uvm_driver#(up_txn);
`uvm_component_utils(up_driver)
up_config up_cfg;
virtual up_if.DRV vif;
extern function new(string name ="up_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass
function up_driver::new(string name ="up_driver",uvm_component parent);
	super.new(name,parent);
endfunction
function void up_driver :: build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(up_config)::get(this,"","up_config",up_cfg))
	`uvm_fatal("CONFIG","cannot get() up_cfg from uvm_config_db.Have you set() it?")
endfunction
function void up_driver::connect_phase(uvm_phase phase);
	vif = up_cfg.vif;
endfunction
task up_driver::run_phase(uvm_phase phase);
	up_txn tx;
	forever
		begin
			seq_item_port.get_next_item(tx);
			vif.drv_cb.rst_h <= tx.rst_h;
			@(vif.drv_cb);
			seq_item_port.item_done();
		end
endtask
