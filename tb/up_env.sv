class up_env extends uvm_env;
`uvm_component_utils(up_env)
up_agent agth;
up_scoreboard sbh;
up_config up_cfg;
extern function new(string name = "up_env",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass
function up_env :: new(string name ="up_env",uvm_component parent);
	super.new(name,parent);
endfunction
function void up_env :: build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(up_config)::get(this,"","up_config",up_cfg))
	`uvm_fatal("CONFIG","cannot get() up_cfg from uvm_config_db.Have ypu set() it?")
	agth = up_agent::type_id::create("agth",this);
	if(up_cfg.has_scoreboard)
	sbh = up_scoreboard::type_id::create("sbh",this);
endfunction
function void up_env::connect_phase(uvm_phase phase);
	agth.monh.ap1.connect(sbh.refm.imp);
	agth.monh.ap.connect(sbh.afifo.analysis_export);
endfunction
