class spi_monitor extends uvm_monitor;

	`uvm_component_utils(spi_monitor)

	spi_agent_config spi_cfg;
	uvm_analysis_port#(spi_xtn)monitor_port;
	virtual spi_interface.spi_monitor_mp spi_vif;

	bit [7:0] ctrl;
	bit cphase,cpol,lsb;
	int bit_index;

function new(string name="spi_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port=new("monitor_port",this);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(spi_agent_config)::get(this,"","spi_agent_config",spi_cfg))
		`uvm_fatal(get_type_name(), "Cannot get spi_cfg from uvm_config_db. Have you set it?")

endfunction


function void connect_phase(uvm_phase phase);
	spi_vif=spi_cfg.spi_vif;
endfunction


task run_phase(uvm_phase phase);
	forever 
		begin
		collect_data();
		end
endtask


task collect_data();
	spi_xtn xtn;
	xtn=spi_xtn::type_id::create("xtn");
	
	if(!uvm_config_db#(bit[7:0])::get(this,"","bit[7:0]",ctrl))
	  `uvm_fatal(get_type_name(), "Cannot get ctrl from uvm_config_db. Have you set it?")

	`uvm_info(get_type_name(),$sformatf("SPI slave monitor:ctrl value is %0b",ctrl),UVM_LOW)

	cphase=ctrl[2];
	cpol=ctrl[3];
	lsb=ctrl[0];

	wait(!spi_vif.spi_mon_cb.SS)
		for(int i=0;i<8;i++) begin
	bit_index=lsb ? i:(7-i);
		//sampling edge
		if((cphase && !cpol) || (!cphase && cpol))
	@(negedge spi_vif.spi_mon_cb.SCLK);
		else
	@(posedge spi_vif.spi_mon_cb.SCLK);
		xtn.MISO[bit_index]=spi_vif.spi_mon_cb.MISO;
		xtn.MOSI[bit_index]=spi_vif.spi_mon_cb.MOSI;
		xtn.SS=spi_vif.spi_mon_cb.SS;
	//	`uvm_info(get_type_name(),$sformatf("bit index data is [%0d]",bit_index.sprint()),UVM_LOW)
			end


		`uvm_info(get_type_name(),$sformatf("transaction received from SPI slave:\n %s",xtn.sprint()),UVM_MEDIUM)
	  monitor_port.write(xtn);
	    spi_cfg.mon_rcvd_data_cnt++;
//		@(spi_vif.spi_mon_cb);
endtask

								

 function void report_phase(uvm_phase phase);
   `uvm_info(get_type_name(), $sformatf("SPI MONITOR: The no of transaction received in spi monitor : %0d", spi_cfg.mon_rcvd_data_cnt), UVM_LOW)
 endfunction

endclass
