class up_test extends uvm_test;
`uvm_component_utils(up_test)
virtual up_if vif;
up_config up_cfg;
up_env envh;
up_seqs seqh;
extern function new(string name = "up_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
endclass
function up_test :: new(string name ="up_test",uvm_component parent);
	super.new(name,parent);
endfunction
function void up_test::build_phase(uvm_phase phase);
	up_cfg = up_config::type_id::create("up_cfg");
	up_cfg.is_active = UVM_ACTIVE;
	up_cfg.has_scoreboard = 1;
	if(!uvm_config_db#(virtual up_if)::get(this,"*","vif",up_cfg.vif))
        `uvm_fatal("INTERFACE","cannot get() vif from uvm_config_db.Have you set() it?")
	super.build_phase(phase);
	uvm_config_db#(up_config)::set(this,"*","up_config",up_cfg);
	envh = up_env::type_id::create("envh",this);
endfunction
task up_test :: run_phase(uvm_phase phase);
	phase.raise_objection(this);
	seqh = up_seqs::type_id::create("seqh");
	seqh.start(envh.agth.seqrh);
	phase.drop_objection(this);
endtask
function void up_test :: end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
endfunction
