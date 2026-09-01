class spi_agent_top extends uvm_env;

	`uvm_component_utils(spi_agent_top)

	spi_agent s_agnth;

	function new(string name="spi_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction


	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		s_agnth=spi_agent::type_id::create("s_agnth",this);
	endfunction


	task run_phase(uvm_phase phase);
		uvm_top.print_topology;
	endtask


endclass
