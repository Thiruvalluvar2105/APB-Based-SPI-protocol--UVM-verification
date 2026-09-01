class env extends uvm_env;

	`uvm_component_utils(env)

	spi_agent_top spi_top[];
	apb_agent_top apb_top[];

	scoreboard sb;

	env_config e_cfg;

	function new(string name="env",uvm_component parent);
		super.new(name,parent);
	endfunction

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
			`uvm_fatal("in env","cfg is not getting")

		if(e_cfg.has_apb_agent)begin
		   apb_top=new[e_cfg.no_of_duts];

		foreach(apb_top[i]) begin
		   uvm_config_db#(apb_agent_config)::set(this,$sformatf("apb_top[%0d]*",i),"apb_agent_config",e_cfg.apb_cfg[i]);
			apb_top[i]=apb_agent_top::type_id::create($sformatf("apb_top[%0d]",i),this);
			end
		      end


		if(e_cfg.has_spi_agent) begin
		   spi_top=new[e_cfg.no_of_duts];

		foreach(spi_top[i]) begin
		  uvm_config_db#(spi_agent_config)::set(this,$sformatf("spi_top[%0d]*",i),"spi_agent_config",e_cfg.spi_cfg[i]);
			spi_top[i]=spi_agent_top::type_id::create($sformatf("spi_top[%0d]",i),this);
			end
		      end


				
		if(e_cfg.has_scoreboard) begin
			sb=scoreboard::type_id::create("sb",this);
			end
	endfunction


function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	if(e_cfg.has_scoreboard) 
			begin
		apb_top[0].a_agnth.a_monh.ap.connect(sb.fifo_apb[0].analysis_export);
		spi_top[0].s_agnth.s_monh.monitor_port.connect(sb.fifo_spi[0].analysis_export);
			end
endfunction


endclass
	
