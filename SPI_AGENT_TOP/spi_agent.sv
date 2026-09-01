class spi_agent extends uvm_agent;

	`uvm_component_utils(spi_agent)

	spi_agent_config spi_cfg;

	spi_driver s_drvh;
	spi_monitor s_monh;
	spi_sequencer s_seqrh;

	function new(string name="spi_agent",uvm_component parent);
		super.new(name,parent);
	endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(spi_agent_config)::get(this,"","spi_agent_config",spi_cfg))
			`uvm_fatal("spi agent","is not getting")

	s_monh=spi_monitor::type_id::create("s_monh",this);

		if(spi_cfg.is_active==UVM_ACTIVE)begin
	   s_drvh=spi_driver::type_id::create("s_drvh",this);
	   s_seqrh=spi_sequencer::type_id::create("s_seqrh",this);
		end
	endfunction


	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		s_drvh.seq_item_port.connect(s_seqrh.seq_item_export);
	endfunction


endclass
