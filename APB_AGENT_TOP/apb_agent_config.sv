class apb_agent_config extends uvm_object;

	`uvm_object_utils(apb_agent_config)

	virtual apb_interface apb_vif;

	uvm_active_passive_enum is_active=UVM_ACTIVE;

	static int mon_rcvd_data_cnt=0;
	static int drv_sent_data_cnt=0;

	function new(string name="apb_agent_config");
		super.new(name);
	endfunction

endclass
