class up_ref_model extends uvm_component;
`uvm_component_utils(up_ref_model)
uvm_analysis_imp#(up_txn,up_ref_model) imp;
int ref_count=0;
up_txn t;
extern function new(string name ="up_ref_model",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void write(up_txn tx);
endclass
function up_ref_model :: new(string name ="up_ref_model",uvm_component parent);
	super.new(name,parent);
	imp = new("imp",this);
endfunction
function void up_ref_model :: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction
function void up_ref_model ::write(up_txn tx);
	if(tx.rst_h)
			ref_count <= 4'd0;
		else 
			ref_count <= (ref_count + 1)%16;
	t = tx;
endfunction
