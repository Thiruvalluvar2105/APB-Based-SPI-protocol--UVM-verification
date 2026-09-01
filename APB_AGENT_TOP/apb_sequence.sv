class apb_sequence extends uvm_sequence#(apb_xtn);

	`uvm_object_utils(apb_sequence);

	function new(string name="apb_sequence");
		super.new(name);
	endfunction

	task body();
		req=apb_xtn::type_id::create("apb_xtn");

		start_item(req);
		assert(req.randomize());
		`uvm_info("apb_sequence",$sformatf("base sequence %s",req.sprint()),UVM_MEDIUM)
		finish_item(req);
	endtask

endclass


class reset_seq extends apb_sequence;
	`uvm_object_utils(reset_seq)

	bit[7:0]ctrl;

	function new(string name="apb_sequence");
		super.new(name);
	endfunction

task body();
//	super.body();
	if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl))
		`uvm_fatal(get_type_name(),"ctrl is not getting")
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1;Pwrite==1'b0;Paddr==3'b0;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1;Pwrite==1'b0;Paddr==3'b001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1;Pwrite==1'b0;Paddr==3'b010;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1;Pwrite==1'b0;Paddr==3'b011;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1;Pwrite==1'b0;Paddr==3'b101;});
		finish_item(req);

	req.sprint;



	end
endtask
endclass
//------------------------------->cpol0cpa0<------------------------------------------
class cpol0_cpha0 extends apb_sequence;

	`uvm_object_utils(cpol0_cpha0)

	bit[7:0] ctrl;

	function new(string name="cpol0_cpha0");
		super.new(name);
	endfunction

	
	task body();
		if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl))
		  `uvm_fatal(get_type_name(),"cant get ctrl")

		req=apb_xtn::type_id::create("req");
		//CR1

		start_item(req);
		assert(req.randomize with {Paddr==3'd0; Pwrite==1'b1; Pwdata==8'b0001_0011;} );
		`uvm_info("apb_sequence",$sformatf("sequence geberated in CR1 %s",req.sprint()),UVM_MEDIUM)//string id,string message,int verbosity
		finish_item(req);

		//CR2
		start_item(req);
		assert(req.randomize with {Paddr==3'd1; Pwrite==1'b1; Pwdata==8'b000_0001;} );//5th bit is modfen
		`uvm_info("apb_sequence",$sformatf("sequence geberated in CR2 %s",req.sprint()),UVM_MEDIUM)
		
		finish_item(req);

		//BR
		start_item(req);
		assert(req.randomize with {Paddr==3'd2; Pwrite==1'b1; Pwdata==8'b0110_0000;} );
		`uvm_info("apb_sequence",$sformatf("sequence geberated in BR %s",req.sprint()),UVM_MEDIUM)
		
		finish_item(req);
		
		//DR
		start_item(req);
		assert(req.randomize with {Paddr==3'd5; Pwrite==1'b1;} );
		`uvm_info("apb_sequence",$sformatf("sequence geberated in DR %s",req.sprint()),UVM_MEDIUM)
		
		finish_item(req);



	endtask
endclass


class cpol0_cpha1 extends apb_sequence;

	`uvm_object_utils(cpol0_cpha1)

	bit[7:0] ctrl;

	function new(string name="cpol0_cpha1");
		super.new(name);
	endfunction

	
	task body();
		if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl))
		  `uvm_fatal(get_type_name(),"cant get ctrl")

		req=apb_xtn::type_id::create("req");
		//CR1

		start_item(req);
		assert(req.randomize with {Paddr==3'd0; Pwrite==1; Pwdata==8'b1011_1011;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR1 is %s",req.sprint()),UVM_MEDIUM)
		finish_item(req);

		//CR2
		start_item(req);
		assert(req.randomize with {Paddr==3'd1; Pwrite==1; Pwdata==8'b0000_1001;} );//5th bit is modfen
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR2 is %s",req.sprint()),UVM_MEDIUM)
		finish_item(req);

		//BR
		start_item(req);
		assert(req.randomize with {Paddr==3'd2; Pwrite==1; Pwdata==8'b0010_0000;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in BR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);
		
		//DR
		start_item(req);
		assert(req.randomize with {Paddr==3'd5; Pwrite==1;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in DR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);



	endtask
endclass


class cpol1_cpha0 extends apb_sequence;

	`uvm_object_utils(cpol1_cpha0)

	bit[7:0] ctrl;

	function new(string name="cpol1_cpha0");
		super.new(name);
	endfunction

	
	task body();
		if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl))
		  `uvm_fatal(get_type_name(),"cant get ctrl")

		req=apb_xtn::type_id::create("req");
		//CR1

		start_item(req);
		assert(req.randomize with {Paddr==3'd0; Pwrite==1; Pwdata==8'b0011_0101;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR1 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//CR2
		start_item(req);
		assert(req.randomize with {Paddr==3'd1; Pwrite==1; Pwdata==8'b0001_1001;} );//5th bit is modfen
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR2 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//BR
		start_item(req);
		assert(req.randomize with {Paddr==3'd2; Pwrite==1; Pwdata==8'b0100_0000;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in BR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);
		
		//DR
		start_item(req);
		assert(req.randomize with {Paddr==3'd5; Pwrite==1;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in DR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);



	endtask
endclass


class cpol1_cpha1 extends apb_sequence;

	`uvm_object_utils(cpol1_cpha1)

	bit [7:0] ctrl;

	function new(string name="cpol1_cpha1");
		super.new(name);
	endfunction

	
	task body();
		if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl))
		  `uvm_fatal(get_type_name(),"cant get ctrl")

		req=apb_xtn::type_id::create("req");
		//CR1

		start_item(req);
		assert(req.randomize with {Paddr==3'd0; Pwrite==1; Pwdata==ctrl;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR1 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//CR2
		start_item(req);
		assert(req.randomize with {Paddr==3'd1; Pwrite==1; Pwdata==8'b0001_0000;} );//5th bit is modfen
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR2 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//BR
		start_item(req);
		assert(req.randomize with {Paddr==3'd2; Pwrite==1; Pwdata==8'b0001_1000;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in BR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);
		
		//DR
		start_item(req);
		assert(req.randomize with {Paddr==3'd5; Pwrite==1;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in DR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);



	endtask
endclass

//------------>MSB<--------------------------

class mcpol0_cpha0 extends apb_sequence;

	`uvm_object_utils(mcpol0_cpha0)
	
	bit[7:0] ctrl;

	function new(string name="mcpol0_cpha0");
		super.new(name);
	endfunction

	
	task body();
		if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl))
		  `uvm_fatal(get_type_name(),"cant get ctrl")

		req=apb_xtn::type_id::create("req");
		//CR1

		start_item(req);
		assert(req.randomize with {Paddr==3'd0; Pwrite==1; Pwdata==8'b1111_0000;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR1 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//CR2
		start_item(req);
		assert(req.randomize with {Paddr==3'd1; Pwrite==1; Pwdata==8'b0001_0000;} );//5th bit is modfen
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR2 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//BR
		start_item(req);
		assert(req.randomize with {Paddr==3'd2; Pwrite==1; Pwdata==8'b0011_0010;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in BR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);
		
		//DR
		start_item(req);
		assert(req.randomize with {Paddr==3'd5; Pwrite==1;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in DR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);



	endtask
endclass



class mcpol0_cpha1 extends apb_sequence;

	`uvm_object_utils(mcpol0_cpha1)

	bit[7:0] ctrl; 

	function new(string name="mcpol0_cpha1");
		super.new(name);
	endfunction

	
	task body();
		if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl))
		  `uvm_fatal(get_type_name(),"cant get ctrl")

		req=apb_xtn::type_id::create("req");
		//CR1

		start_item(req);
		assert(req.randomize with {Paddr==3'd0; Pwrite==1; Pwdata==8'b0101_1010;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR1 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//CR2
		start_item(req);
		assert(req.randomize with {Paddr==3'd1; Pwrite==1; Pwdata==8'b0001_1001;} );//5th bit is modfen
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR2 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//BR
		start_item(req);
		assert(req.randomize with {Paddr==3'd2; Pwrite==1; Pwdata==8'b0010_0001;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in BR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);
		
		//DR
		start_item(req);
		assert(req.randomize with {Paddr==3'd5; Pwrite==1; } );
		`uvm_info("apb_sequence",$sformatf("sequence generated in DR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);



	endtask
endclass



class mcpol1_cpha0 extends apb_sequence;

	`uvm_object_utils(mcpol1_cpha0)

	bit [7:0] ctrl;

	function new(string name="mcpol1_cpha0");
		super.new(name);
	endfunction

	
	task body();
		if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl))
		  `uvm_fatal(get_type_name(),"cant get ctrl")

		req=apb_xtn::type_id::create("req");
		//CR1

		start_item(req);
		assert(req.randomize with {Paddr==3'd0; Pwrite==1; Pwdata==8'b0011_0110;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR1 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//CR2
		start_item(req);
		assert(req.randomize with {Paddr==3'd1; Pwrite==1; Pwdata==8'b0001_1001;} );//5th bit is modfen
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR2 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//BR
		start_item(req);
		assert(req.randomize with {Paddr==3'd2; Pwrite==1; Pwdata==8'b0100_0000;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in BR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);
		
		//DR
		start_item(req);
		assert(req.randomize with {Paddr==3'd5; Pwrite==1; } );
		`uvm_info("apb_sequence",$sformatf("sequence generated in DR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);



	endtask
endclass



class mcpol1_cpha1 extends apb_sequence;

	`uvm_object_utils(mcpol1_cpha1)

	bit [7:0] ctrl;

	function new(string name="mcpol1_cpha1");
		super.new(name);
	endfunction

	
	task body();
		if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl))
		  `uvm_fatal(get_type_name(),"cant get ctrl")

		req=apb_xtn::type_id::create("req");
		//CR1

		start_item(req);
		assert(req.randomize with {Paddr==3'd0; Pwrite==1; Pwdata==ctrl;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR1 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//CR2
		start_item(req);
		assert(req.randomize with {Paddr==3'd1; Pwrite==1; Pwdata==8'b0001_1001;} );//5th bit is modfen
		`uvm_info("apb_sequence",$sformatf("sequence generated in CR2 is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);

		//BR
		start_item(req);
		assert(req.randomize with {Paddr==3'd2; Pwrite==1; Pwdata==8'b0001_0010;} );
		`uvm_info("apb_sequence",$sformatf("sequence generated in BR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);
		
		//DR
		start_item(req);
		assert(req.randomize with {Paddr==3'd5; Pwrite==1; } );
		`uvm_info("apb_sequence",$sformatf("sequence generated in DR is %s",req.sprint()),UVM_MEDIUM)

		finish_item(req);



	endtask
endclass

