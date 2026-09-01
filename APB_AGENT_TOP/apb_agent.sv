class apb_agent extends uvm_agent;

	`uvm_component_utils(apb_agent)

	apb_agent_config apb_cfg;

	apb_driver a_drvh;
	apb_monitor a_monh;
	apb_sequencer a_seqrh;

	function new(string name="apb_agent",uvm_component parent);
		super.new (name,parent);
	endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
			`uvm_fatal("APB AGENT","CFG IS NOT GETTING")

			a_monh=apb_monitor::type_id::create("a_monh",this);

		if(apb_cfg.is_active==UVM_ACTIVE) begin
			a_drvh=apb_driver::type_id::create("a_drvh",this);
			a_seqrh=apb_sequencer::type_id::create("a_seqrh",this);
			end
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		a_drvh.seq_item_port.connect(a_seqrh.seq_item_export);
	endfunction

endclass
