class apb_xtn extends uvm_sequence_item;
	`uvm_object_utils(apb_xtn)

   	bit PRESETn;
	bit Pclk;
   rand	bit Pwrite;
	bit Penable;
	bit Psel;
   rand	bit [2:0]Paddr;
   rand	bit [7:0]Pwdata;
	bit [7:0]Prdata;
	bit Pready;
	bit Pslverr;


	constraint c1{if(Pwrite)
			Paddr inside {0,1,2,5};
			  else 
			Paddr inside {0,1,2,3,5} ;}
		
	extern function new (string name="apb_xtn");
	extern function void do_print(uvm_printer printer);
	

endclass

	function apb_xtn::new(string name="apb_xtn");
		super.new("apb_xtn");
	endfunction

	function void apb_xtn:: do_print(uvm_printer printer);
		printer.print_field("PRESETn",this.PRESETn,1,UVM_BIN);
		printer.print_field("Penable",this.Penable,1,UVM_BIN);
		printer.print_field("Pwrite",this.Pwrite,1,UVM_BIN);
		printer.print_field("Psel",this.Psel,1,UVM_BIN);
		printer.print_field("Paddr",this.Paddr,3,UVM_BIN);
		printer.print_field("Pwdata",this.Pwdata,8,UVM_BIN);
		printer.print_field("Prdata",this.Prdata,8,UVM_BIN);
		printer.print_field("Pready",this.Pready,1,UVM_BIN);
	endfunction

