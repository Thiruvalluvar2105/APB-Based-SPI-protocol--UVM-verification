class apb_driver extends uvm_driver#(apb_xtn);

	`uvm_component_utils(apb_driver)

	apb_agent_config  apb_cfg;

	virtual apb_interface.apb_driver_mp  apb_vif;

	function new(string name="apb_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
			`uvm_fatal("APB_AGT_CFG","IS NOT GETTING")
	endfunction

	function void connect_phase(uvm_phase phase);
		apb_vif=apb_cfg.apb_vif;
	endfunction


task run_phase(uvm_phase phase);
	reset_dut();
	req=apb_xtn::type_id::create("req");

	forever begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
		end
endtask


task reset_dut();
	@(apb_vif.apb_drv_cb);
		apb_vif.apb_drv_cb.PRESETn<=1'b0;
	@(apb_vif.apb_drv_cb);
		apb_vif.apb_drv_cb.PRESETn<=1'b1;
endtask


task send_to_dut(apb_xtn xtn);

	@(apb_vif.apb_drv_cb);
	//setup phase
	apb_vif.apb_drv_cb.Psel<=1'b1;
	apb_vif.apb_drv_cb.Penable<=1'b0;	
	apb_vif.apb_drv_cb.Paddr<=xtn.Paddr;	
	apb_vif.apb_drv_cb.Pwrite<=xtn.Pwrite;

	@(apb_vif.apb_drv_cb);
	//access phase
	if(xtn.Pwrite) begin
		apb_vif.apb_drv_cb.Pwdata<=xtn.Pwdata;
		apb_vif.apb_drv_cb.Penable<=1'b1;
		   wait(apb_vif.apb_drv_cb.Pready)
			if(xtn.Pwrite==0)
				begin
				xtn.Prdata=apb_vif.apb_drv_cb.Prdata;
				end
			end
	@(apb_vif.apb_drv_cb);
	apb_vif.apb_drv_cb.Psel<=1'b0;
	apb_vif.apb_drv_cb.Penable<=1'b0;
	`uvm_info("apb_driver",$sformatf("data inside apb driver %s",xtn.sprint()),UVM_LOW)
endtask			
	
			
	
	

endclass
