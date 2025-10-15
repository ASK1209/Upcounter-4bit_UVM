class up_scoreboard extends uvm_scoreboard;
`uvm_component_utils(up_scoreboard)
uvm_tlm_analysis_fifo#(int) afifo;
up_txn tx;
up_ref_model refm;
up_config up_cfg;
int no_of_comp=0;
covergroup up_cg;
 option.per_instance = 1;
 rst_h_cp : coverpoint tx.rst_h;
endgroup
extern function new(string name ="up_scoreboard",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern function void report_phase(uvm_phase phase);
endclass
function up_scoreboard ::new(string name ="up_scoreboard",uvm_component parent);
 super.new(name,parent);
 afifo = new("afifo",this);
 up_cg = new();
endfunction
function void up_scoreboard :: build_phase(uvm_phase phase);
 super.build_phase(phase);
 refm = up_ref_model::type_id::create("refm",this);
 if(!uvm_config_db#(up_config)::get(this,"","up_config",up_cfg))
 `uvm_fatal("CONFIG","cannot get() up_cfg from uvm_config_db.Have you set() it?")
endfunction
task up_scoreboard :: run_phase(uvm_phase phase);
 int count;
 	forever 
  		begin
   			
   			afifo.get(count);
   			$display("count from dut =%0d",count);
   			$display("ref_count =%0d",refm.ref_count);
   			tx = refm.t;
                        up_cg.sample();

   			if(count == refm.ref_count[3:0])
			begin
    				`uvm_info("SCOREBOARD","compared successful",UVM_LOW)
				no_of_comp++;
   			end
			else
    				`uvm_error("SCOREBOARD","comparison unsuccessful")
 		 end
endtask
function void up_scoreboard::report_phase(uvm_phase phase);
	$display("No of Successful comparisons =%0d",no_of_comp);
endfunction
