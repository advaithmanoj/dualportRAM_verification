`include "gen.sv"
`include "trxn.sv"
`include "write_driver.sv"
`include "read_driver.sv"
`include "write_monitor.sv"
`include "read_monitor.sv"
`include "ref_model.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"

module top;
    bit clock=0;

  interf interf(clock);
  
  dual_port_ram DUT(
    .clock(interf.clock),
    .write_en(interf.write_en),
    .write_addr(interf.write_addr),
    .write_data(interf.write_data),
    .read_en(interf.read_en),
    .read_addr(interf.read_addr),
    .read_data(interf.read_data));
  
  test test;  
    
  always  #5 clock = ~clock;  
  initial
    begin
      test = new(interf, interf, interf, interf);
      test.run();
    end
  
   initial begin
  	#500;
  	$finish;
  end
  
endmodule
  
 
