module top;

	import uvm_pkg::*;
	import test_pkg::*;
	`include "uvm_macros.svh"

	bit clock;
		always #10 clock=~clock;

	apb_interface in0(clock);

	spi_interface in1(clock);

	top_module_spi duv(.pclk(clock),
				.presetn(in0.PRESETn),
				.paddr_i(in0.Paddr),
				.pwrite_i(in0.Pwrite),
				.psel_i(in0.Psel),
				.penable_i(in0.Penable),
				.pwdata_i(in0.Pwdata),
				.prdata_o(in0.Prdata),
				.pready_o(in0.Pready),
				.pslverr_o(in0.Pslverr),

				.miso_i(in1.MISO),
				.mosi_o(in1.MOSI),
				.sclk_o(in1.SCLK),
				.ss_o(in1.SS) );

	

	`include "uvm_macros.svh"

	initial begin

	`ifdef VCS
	$fsdbDumpvars(0,top);
	`endif

		uvm_config_db#(virtual apb_interface)::set(null,"*","apb_interface",in0);
		uvm_config_db#(virtual spi_interface)::set(null,"*","spi_interface",in1);

		run_test();
		end
endmodule
