class spi_driver extends uvm_driver#(spi_xtn);
  `uvm_component_utils(spi_driver)

  virtual spi_interface.spi_driver_mp spi_vif;
  spi_agent_config spi_cfg;

  bit [7:0] ctrl;
  bit lsbfe;
  bit cpol;
  bit cphase;
  int bit_idx;

  function new(string name = "spi_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(spi_agent_config)::get(this, "", "spi_agent_config", spi_cfg))
      `uvm_fatal("driver", "spi_agent_config is not getting")
  endfunction

  function void connect_phase(uvm_phase phase);
    spi_vif = spi_cfg.spi_vif;
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      send_to_dut(req);
      seq_item_port.item_done();
    end
  endtask

  task send_to_dut(spi_xtn duv_xtn);
    if (!uvm_config_db#(bit[7:0])::get(this, "", "bit[7:0]", ctrl))
      `uvm_fatal(get_type_name(), "ctrl is not getting")

    cphase = ctrl[2];
    cpol   = ctrl[3];
    lsbfe  = ctrl[0];

    wait(!spi_vif.spi_drv_cb.SS)

	if(!cphase)
		spi_vif.spi_drv_cb.MISO<=duv_xtn.MISO[lsbfe ? 0:7];
	for(int i=(cphase? 0:1);i<8;i++) begin
		if(cphase^cpol)
		@(negedge spi_vif.spi_drv_cb.SCLK);
			else
		@(posedge spi_vif.spi_drv_cb.SCLK);
		  spi_vif.spi_drv_cb.MISO<=duv_xtn.MISO[lsbfe? i:(7-i)];
			end


    `uvm_info("spi_driver", $sformatf("spi driver sent: %s", duv_xtn.sprint()), UVM_MEDIUM)
    spi_cfg.drv_sent_data_cnt++;

   // wait(spi_vif.spi_drv_cb.SS);
  endtask

endclass
