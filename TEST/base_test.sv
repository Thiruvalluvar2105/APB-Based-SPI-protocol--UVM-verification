class base_test extends uvm_test;

	`uvm_component_utils(base_test)

	env envh;

	env_config e_cfg;
	
	spi_agent_config spi_cfg[];
	apb_agent_config apb_cfg[];

	
	int no_of_duts=1;
	bit has_spi_agent=1;
	bit has_apb_agent=1;

	bit [7:0] ctrl;

	extern function new(string name="base_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass


	function base_test::new(string name="base_test",uvm_component parent);
		super.new(name,parent);
	endfunction


	function void base_test::build_phase(uvm_phase phase);
		e_cfg=env_config::type_id::create("e_cfg");

//--------------------->spi_cfg <-------------------------------------------------------------------------------	
		if(has_spi_agent)begin
			e_cfg.spi_cfg=new[no_of_duts];
			spi_cfg=new[no_of_duts];

		foreach(spi_cfg[i])begin
			spi_cfg[i]=spi_agent_config::type_id::create($sformatf("spi_cfg[%0d]*",i),this);

				if(!uvm_config_db#(virtual spi_interface)::get(this,"","spi_interface",spi_cfg[i].spi_vif))
					`uvm_fatal("in test",$sformatf("spi_vif is not getting for spi_cfg[%0d]",i))

			  e_cfg.spi_cfg[i]=spi_cfg[i];
			end
		end

//--------------------->apd_cfg <-------------------------------------------------------------------------------		
		if(has_apb_agent)begin
			e_cfg.apb_cfg=new[no_of_duts];
			apb_cfg=new[no_of_duts];

		foreach(apb_cfg[i])begin
			apb_cfg[i]=apb_agent_config::type_id::create($sformatf("apb_cfg[%0d]*",i),this);

				if(!uvm_config_db#(virtual apb_interface)::get(this,"","apb_interface",apb_cfg[i].apb_vif))
					`uvm_fatal("in test",$sformatf("apb_vif is not getting apb_vif[%0d]",i))

		       	  e_cfg.apb_cfg[i]=apb_cfg[i];
			end
		end


		uvm_config_db#(env_config)::set(this,"*","env_config",e_cfg);

			super.build_phase(phase);

		envh=env::type_id::create("envh",this);


		e_cfg.no_of_duts=no_of_duts;
		e_cfg.has_spi_agent=has_spi_agent;
		e_cfg.has_apb_agent=has_apb_agent;

		
		uvm_config_db#(bit[7:0])::set(this,"*","bit[7:0]",ctrl);
			
	endfunction


//=============================LSB TEST STARTS================================


class cpol0_cpha0_test extends base_test;

	`uvm_component_utils(cpol0_cpha0_test)

	cpol0_cpha0 c00_seqh;
	spi_ext_seq spi_seqh;
  
	bit [7:0] ctrl;

function new(string name="cpol0_cpha0_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
		ctrl=8'b0001_0011;
		uvm_config_db#(bit[7:0])::set(this,"*","bit[7:0]",ctrl);

			c00_seqh=cpol0_cpha0::type_id::create("c00_seqh");
		spi_seqh=spi_ext_seq::type_id::create("spi_seqh");



	endfunction

task run_phase(uvm_phase phase);
	

	phase.raise_objection(this);
			fork
		c00_seqh.start(envh.apb_top[0].a_agnth.a_seqrh);
		spi_seqh.start(envh.spi_top[0].s_agnth.s_seqrh);
		join
		#500;
	phase.drop_objection(this);

endtask

endclass



class cpol0_cpha1_test extends base_test;

	`uvm_component_utils(cpol0_cpha1_test)

	cpol0_cpha1 c01_seqh;
		spi_ext_seq spi_seqh;

	bit [7:0] ctrl;  

function new(string name="cpol0_cpha1_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
			ctrl=8'b1011_1001;
		uvm_config_db#(bit[7:0])::set(this,"*","bit[7:0]",ctrl);

	c01_seqh=cpol0_cpha1::type_id::create("c01_seqh");
		spi_seqh=spi_ext_seq::type_id::create("spi_seqh");

endfunction

task run_phase(uvm_phase phase);
	

	phase.raise_objection(this);

	fork
		 c01_seqh.start(envh.apb_top[0].a_agnth.a_seqrh);
		spi_seqh.start(envh.spi_top[0].s_agnth.s_seqrh);
	join

	phase.drop_objection(this);
	
	
endtask

endclass



class cpol1_cpha0_test extends base_test;

	`uvm_component_utils(cpol1_cpha0_test)

	cpol1_cpha0 c10_seqh;
		spi_ext_seq spi_seqh;

	bit[7:0]ctrl;  

function new(string name="cpol1_cpha0_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
		ctrl=8'b1111_0111;
		uvm_config_db#(bit[7:0])::set(this,"*","bit[7:0]",ctrl);

	c10_seqh=cpol1_cpha0::type_id::create("c10_seqh");
		spi_seqh=spi_ext_seq::type_id::create("spi_seqh");

endfunction

task run_phase(uvm_phase phase);
	

	phase.raise_objection(this);

	fork
		 c10_seqh.start(envh.apb_top[0].a_agnth.a_seqrh);
		spi_seqh.start(envh.spi_top[0].s_agnth.s_seqrh);
	join

	phase.drop_objection(this);
	
	
endtask

endclass



class cpol1_cpha1_test extends base_test;

	`uvm_component_utils(cpol1_cpha1_test)

	cpol1_cpha1 c11_seqh;
		spi_ext_seq spi_seqh;

	bit[7:0]ctrl;  

function new(string name="cpol1_cpha1_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
		ctrl=8'b1111_1111;
		uvm_config_db#(bit[7:0])::set(this,"*","bit[7:0]",ctrl);

	c11_seqh=cpol1_cpha1::type_id::create("c11_seqh");
		spi_seqh=spi_ext_seq::type_id::create("spi_seqh");

endfunction

task run_phase(uvm_phase phase);
	

	phase.raise_objection(this);
	
	fork
		 c11_seqh.start(envh.apb_top[0].a_agnth.a_seqrh);
		spi_seqh.start(envh.spi_top[0].s_agnth.s_seqrh);
	join

	phase.drop_objection(this);
	
	
endtask

endclass


//======================================================>from here extended tests( MSB)<===========================================================

class mcpol0_cpha0_test extends base_test;

	`uvm_component_utils(mcpol0_cpha0_test)

	mcpol0_cpha0 c00_seqh;
		spi_ext_seq spi_seqh;
	bit[7:0] ctrl;

function new(string name="mcpol0_cpha0_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
		
	super.build_phase(phase);
	ctrl=8'b1111_0000;
	uvm_config_db#(bit[7:0])::set(this,"*","bit[7:0]",ctrl);

		  c00_seqh=mcpol0_cpha0::type_id::create("c00_seqh");
	spi_seqh=spi_ext_seq::type_id::create("spi_seqh");
endfunction

task run_phase(uvm_phase phase);
	 
	phase.raise_objection(this);
		
	fork
	 c00_seqh.start(envh.apb_top[0].a_agnth.a_seqrh);
	spi_seqh.start(envh.spi_top[0].s_agnth.s_seqrh);
	join

	phase.drop_objection(this);
	
	
endtask

endclass



class mcpol0_cpha1_test extends base_test;

	`uvm_component_utils(mcpol0_cpha1_test)

	mcpol0_cpha1 c01_seqh;
		spi_ext_seq spi_seqh;
		
	bit[7:0]ctrl;


function new(string name="mcpol0_cpha1_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	ctrl=8'b0101_1010;
	uvm_config_db#(bit[7:0])::set(this,"*","bit[7:0]",ctrl);

	c01_seqh=mcpol0_cpha1::type_id::create("c01_seqh");
		spi_seqh=spi_ext_seq::type_id::create("spi_seqh");

endfunction

task run_phase(uvm_phase phase);

	phase.raise_objection(this);

	fork
	 c01_seqh.start(envh.apb_top[0].a_agnth.a_seqrh);
	spi_seqh.start(envh.spi_top[0].s_agnth.s_seqrh);
	join

	phase.drop_objection(this);
	endtask

endclass



class mcpol1_cpha0_test extends base_test;

	`uvm_component_utils(mcpol1_cpha0_test)

	mcpol1_cpha0 c10_seqh;
		spi_ext_seq spi_seqh;

	bit[7:0]ctrl;

function new(string name="mcpol1_cpha0_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	ctrl=8'b0011_0110;
	uvm_config_db#(bit[7:0])::set(this,"*","bit[7:0]",ctrl);

	c10_seqh=mcpol1_cpha0::type_id::create("c10_seqh");
		spi_seqh=spi_ext_seq::type_id::create("spi_seqh");

endfunction

task run_phase(uvm_phase phase);
	

	phase.raise_objection(this);
	
	fork
	 c10_seqh.start(envh.apb_top[0].a_agnth.a_seqrh);
	spi_seqh.start(envh.spi_top[0].s_agnth.s_seqrh);
	join

	phase.drop_objection(this);
	
	
endtask

endclass



class mcpol1_cpha1_test extends base_test;

	`uvm_component_utils(mcpol1_cpha1_test)

	mcpol1_cpha1 c11_seqh;
		spi_ext_seq spi_seqh;

	bit[7:0]ctrl;

function new(string name="mcpol1_cpha1_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	ctrl=8'b0101_1100;
	uvm_config_db#(bit[7:0])::set(this,"*","bit[7:0]",ctrl);

	c11_seqh=mcpol1_cpha1::type_id::create("c11_seqh");
		spi_seqh=spi_ext_seq::type_id::create("spi_seqh");

endfunction

task run_phase(uvm_phase phase);
	

	phase.raise_objection(this);

	fork	
	 c11_seqh.start(envh.apb_top[0].a_agnth.a_seqrh);
	spi_seqh.start(envh.spi_top[0].s_agnth.s_seqrh);
	join

	phase.drop_objection(this);
	
	
endtask

endclass
