class up_monitor extends uvm_monitor;
`uvm_component_utils(up_monitor)
virtual up_if.MON vif;
up_config up_cfg;
uvm_analysis_port#(int) ap;
uvm_analysis_port#(up_txn) ap1;
extern function new(string name ="up_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass
function up_monitor::new(string name ="up_monitor",uvm_component parent);
	super.new(name,parent);
	ap = new("ap",this);
	ap1 = new("ap1",this);
endfunction
function void up_monitor :: build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(up_config)::get(this,"","up_config",up_cfg))
	`uvm_fatal("CONFIG","cannot get() up_cfg from uvm_config_db.Have you set() it?")
endfunction
function void up_monitor::connect_phase(uvm_phase phase);
	vif = up_cfg.vif;
endfunction
task up_monitor::run_phase(uvm_phase phase);
	up_txn  tx;
	forever
		begin
			@(vif.mon_cb);
			tx = up_txn::type_id::create("tx");
			tx.rst_h = vif.mon_cb.rst_h;
			ap1.write(tx);
			ap.write(vif.mon_cb.out);
		end
endtask
