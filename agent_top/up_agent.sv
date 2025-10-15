class up_agent extends uvm_agent;
`uvm_component_utils(up_agent)
up_driver drvh;
up_sequencer seqrh;
up_monitor monh;
up_config up_cfg;
extern function new(string name ="up_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass
function up_agent :: new(string name ="up_agent",uvm_component parent);
	super.new(name,parent);
endfunction
function void up_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(up_config)::get(this,"","up_config",up_cfg))
	`uvm_fatal("CONFIG","cannot get() up_cfg from uvm_config_db.Have you set() it?")
	monh = up_monitor::type_id::create("monh",this);
	if(up_cfg.is_active==UVM_ACTIVE)
		begin
			drvh = up_driver::type_id::create("drvh",this);
			seqrh = up_sequencer::type_id::create("seqrh",this);
		end
endfunction
function void up_agent::connect_phase(uvm_phase phase);
	if(up_cfg.is_active == UVM_ACTIVE)
	drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction
