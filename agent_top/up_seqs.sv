class up_seqs extends uvm_sequence#(up_txn);
`uvm_object_utils(up_seqs)
extern function new(string name = "up_seqs");
extern task body();
endclass
function up_seqs :: new(string name  ="up_seqs");
	super.new(name);
endfunction
task up_seqs :: body();
up_txn tx;
repeat(20)
	begin
		tx = up_txn::type_id::create("tx");
		start_item(tx);
		tx.randomize() with {rst_h inside {[0:1]};};
		finish_item(tx);
	end
endtask
