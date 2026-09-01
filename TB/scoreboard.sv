class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)

	uvm_tlm_analysis_fifo#(apb_xtn) fifo_apb[];
	uvm_tlm_analysis_fifo#(spi_xtn) fifo_spi[];

	env_config e_cfg;

	apb_xtn apb_cov_data;
	spi_xtn spi_cov_data;

	apb_xtn a_xtns;
	spi_xtn s_xtns;

	apb_xtn a[$];
	spi_xtn s[$];

	int data_verified_cnt;

	//cover groups for APB Host
	covergroup apb_cover_group;
	  option.per_instance=1;

	Reset : coverpoint apb_cov_data.PRESETn{bins rst={0,1};}
	Addr  : coverpoint  apb_cov_data.Paddr{bins addr[]={0,1,2,3,5};}
	Selx  : coverpoint apb_cov_data.Psel{bins sel={0,1};}
	Enable: coverpoint apb_cov_data.Penable{bins enb={0,1};}
	Write : coverpoint apb_cov_data.Pwrite{bins wrt[]={0,1};}
	Ready : coverpoint apb_cov_data.Pready{bins rdy={0,1};}

	wdata :coverpoint apb_cov_data.Pwdata{ bins wdata_low={[8'h00:8'h0f]};
						bins wdata_high={[8'h1f:8'hff]};}

	rdata :coverpoint apb_cov_data.Prdata{ bins rdata_low={[8'h00:8'h0f]};
						bins rdata_high={[8'h1f:8'hff]};}

	//crosses
	selx_Enab : cross Selx,Enable;
	selx_Enab_Ready: cross Selx,Enable,Ready;
	endgroup


	covergroup spi_cover_group;
	  option.per_instance=1;

	slave_select : coverpoint spi_cov_data.SS{bins ss={0,1};}
	
	miso_data    : coverpoint spi_cov_data.MISO{bins miso_low={[8'h00:8'h0f]};
							bins miso_high={[8'h1f:8'hff]};}
	mosi_data    : coverpoint spi_cov_data.MOSI{bins mosi_low={[8'h00:8'h0f]};
							bins mosi_high={[8'h1f:8'hff]};}
	endgroup 

	 

	function new(string name="scoreboard",uvm_component parent);
		super.new(name,parent);
		apb_cov_data=new();
		spi_cov_data=new();

		apb_cover_group=new();
		spi_cover_group=new();

	endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
	  `uvm_fatal(get_type_name(),"in scoreboard env_cfg is not getting")

	fifo_apb=new[e_cfg.no_of_duts];
	fifo_spi=new[e_cfg.no_of_duts];

	foreach(fifo_apb[i]) begin
		fifo_apb[i]=new($sformatf("fifo_apb[%0d]",i),this);
			end

	foreach(fifo_spi[i])begin
		fifo_spi[i]=new($sformatf("fifo_spi[%0d]",i),this);
			end
endfunction


task run_phase(uvm_phase phase);
	fork
	  begin
	     forever //logic to get apb transactions from the apb monitor
		begin
	fifo_apb[0].get(a_xtns);
	apb_cov_data=a_xtns;
	apb_cover_group.sample();
	`uvm_info(get_type_name(),$sformatf("scoreboard:\n apb_xtn=\n%s",a_xtns.sprint()),UVM_MEDIUM)

	compare_data(a_xtns);
		end
	  end

	  begin
	    forever
		begin
	fifo_spi[0].get(s_xtns);
	spi_cov_data=s_xtns;
	spi_cover_group.sample();
	`uvm_info(get_type_name(),$sformatf("scoreboard:\n spi_xtn=\n%s",s_xtns.sprint()),UVM_MEDIUM)
	compare_data(a_xtns);
		end
	   end
	join
endtask



task compare_data(apb_xtn a_xtns);
	//compare MOSI data and Pwdata,that is written into spi reg(5 regs)
	wait(s_xtns!=null);
	wait(a_xtns!=null);

	  if(a_xtns.Pwrite &&(a_xtns.Paddr==3'b101))
	    begin
		if(a_xtns.Pwdata==s_xtns.MOSI)
		  begin
			$display("\n\n===============MOSI data iS coRRecT===============");
			$display("\tPwdata==%b \n\t MOSI==%b",a_xtns.Pwdata,s_xtns.MOSI);
			$display("==================cOmPariSiOn passED=================");
		`uvm_info(get_type_name(),$sformatf("scoreboard :\n apb_xtn=%s, \n spi_xtn-%s",a_xtns.sprint(),s_xtns.sprint()),UVM_MEDIUM)
		  end

		else
		   begin
			$display("\n\n===============CoMpArison failed===============");
			$display("\tPwdata==%b \n\t MOSI==%b",a_xtns.Pwdata,s_xtns.MOSI);
			$display("================== failed=================");
		`uvm_info(get_type_name(),$sformatf("scoreboard :\n apb_xtn=%s, \n spi_xtn-%s",a_xtns.sprint(),s_xtns.sprint()),UVM_MEDIUM)
		  end
	end

//-------------------->PRDATA<------------------------

	if(!a_xtns.Pwrite && (a_xtns.Paddr==3'b101))
	   begin
		if(a_xtns.Prdata==s_xtns.MISO)
		  begin
			$display("\n\n===============MISO data iS coRRecT===============");
			$display("\tPrdata==%b \n\t MISO==%b",a_xtns.Prdata,s_xtns.MISO);
			$display("==================cOmPariSiOn passED=================");
		`uvm_info(get_type_name(),$sformatf("scoreboard :\n apb_xtn=%s, \n spi_xtn-%s",a_xtns.sprint(),s_xtns.sprint()),UVM_MEDIUM)
		  end


		else
		   begin
			$display("\n\n===============CoMpArison failed===============");
			$display("\tPrdata==%b \n\t MISO==%b",a_xtns.Prdata,s_xtns.MISO);
			$display("================== failed=================");
		`uvm_info(get_type_name(),$sformatf("scoreboard :\n apb_xtn=%s, \n spi_xtn-%s",a_xtns.sprint(),s_xtns.sprint()),UVM_MEDIUM)
		  end
	end




	data_verified_cnt++;

endtask



		  


endclass
