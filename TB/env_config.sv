class env_config extends uvm_object;

	`uvm_object_utils(env_config);

	bit has_functional_coverage=0;

	bit has_scoreboard=1;
	bit has_spi_agent=1;
	bit has_apb_agent=1;

	apb_agent_config apb_cfg[];
	spi_agent_config spi_cfg[];

	int no_of_duts=1;


	function new (string name="env_config");
		super.new(name);
	endfunction

endclass
