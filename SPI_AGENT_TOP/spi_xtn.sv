class spi_xtn extends uvm_sequence_item;

	`uvm_object_utils(spi_xtn)

	logic SCLK;
	logic SS;
	logic [7:0]MOSI;
   rand bit [7:0] MISO;  //it is rcv from low peripheral device so,rand(if logic was taken it will consider x and z als0(4-type DT))

function new(string name="spi_xtn");
	super.new(name);
endfunction


function void do_print(uvm_printer printer);
	printer.print_field("SS",this.SS,1,UVM_BIN);
	printer.print_field("MOSI",this.MOSI,8,UVM_BIN);
	printer.print_field("MISO",this.MISO,8,UVM_BIN);
endfunction


endclass
