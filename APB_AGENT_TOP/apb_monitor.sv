class apb_monitor extends uvm_monitor;

	`uvm_component_utils(apb_monitor)
	
	virtual apb_interface.apb_monitor_mp  apb_vif;

	uvm_analysis_port#(apb_xtn) ap;	
	
	apb_agent_config apb_cfg;

	function new(string name="apb_monitor",uvm_component parent);
		super.new(name,parent);
		ap=new("ap",this);
	endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#( apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
			`uvm_fatal("IN MONITOR","CFG IS NOT GETTING")
	endfunction

	function void connect_phase(uvm_phase phase);
		apb_vif=apb_cfg.apb_vif;
	endfunction

task run_phase(uvm_phase phase);
	forever
		begin
			collect_data();
		end
endtask


task collect_data();
	apb_xtn xtn;
	  xtn=apb_xtn::type_id::create("xtn");

	@(apb_vif.apb_mon_cb);
		wait(apb_vif.apb_mon_cb.Penable && apb_vif.apb_mon_cb.Pready)
		xtn.Psel = apb_vif.apb_mon_cb.Psel;
		xtn.Penable = apb_vif.apb_mon_cb.Penable;
		xtn.Paddr = apb_vif.apb_mon_cb.Paddr;
		xtn.Pwrite = apb_vif.apb_mon_cb.Pwrite;
		xtn.Pready = apb_vif.apb_mon_cb.Pready;
	@(apb_vif.apb_mon_cb);
		if(xtn.Pwrite)
			xtn.Pwdata=apb_vif.apb_mon_cb.Pwdata;
		else
			xtn.Prdata=apb_vif.apb_mon_cb.Prdata;
	`uvm_info("apb_monitor",$sformatf("monitor apb data %s",xtn.sprint()),UVM_MEDIUM)

	ap.write(xtn);

endtask	
		
		
			

endclass
