class up_txn extends uvm_sequence_item;
`uvm_object_utils(up_txn)
rand bit rst_h;
extern function new(string name ="up_txn");
extern function void do_copy(uvm_object rhs);
extern function void do_print(uvm_printer printer);
endclass
function up_txn :: new(string name ="up_txn");
	super.new(name);
endfunction
function void up_txn :: do_copy(uvm_object rhs);
	up_txn tx;
	$cast(tx,rhs);
	this.rst_h = tx.rst_h;
endfunction
function void up_txn::do_print(uvm_printer printer);
	super.do_print(printer);
	printer.print_field("rst_h",this.rst_h,1,UVM_HEX);
endfunction
