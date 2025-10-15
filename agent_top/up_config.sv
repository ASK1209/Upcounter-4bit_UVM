class up_config extends uvm_object;
`uvm_object_utils(up_config)
virtual up_if vif;
bit has_scoreboard;
uvm_active_passive_enum is_active;
extern function new(string name = "up_config");
endclass
function up_config ::new(string name ="up_config");
	super.new(name);
endfunction
