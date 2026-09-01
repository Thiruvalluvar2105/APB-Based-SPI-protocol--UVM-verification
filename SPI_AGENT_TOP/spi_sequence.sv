class spi_sequence extends uvm_sequence#(spi_xtn);
	
	`uvm_object_utils(spi_sequence)

	function new(string name="spi_sequence");
		super.new(name);
	endfunction

endclass


class spi_ext_seq extends spi_sequence;
	`uvm_object_utils(spi_ext_seq)

	function new(string name="spi_ext_seq");
		super.new(name);
	endfunction

	task body();
		
		req=spi_xtn::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {MISO==8'b1101_1110;});
			`uvm_info("spi_sequence",$sformatf("spi sequence is %s",req.sprint()),UVM_MEDIUM)
			finish_item(req);
		end
	endtask
endclass
