class up_sequencer extends uvm_sequencer#(up_txn);
`uvm_component_utils(up_sequencer)
extern function new(string name = "up_sequencer",uvm_component parent);
endclass
function up_sequencer::new(string name ="up_sequencer",uvm_component parent);
	super.new(name,parent);
endfunction
