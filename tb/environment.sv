class environment;
  gen  gen;
  read_driver    r_d;
  read_monitor   r_m;
  write_driver   w_d;
  write_monitor  w_m;
  ref_model  ref_mod;
  sb sb;
  
  
  virtual interf.write_drv vif1;
  virtual interf.read_drv  vif2;
  virtual interf.write_mon vif3;
  virtual interf.read_mon  vif4;
  
  mailbox #(trxn) mb1, mb2, mb3, mb4, mb5, mb6;
  
  function new(virtual ram_if.write_drv vif1,virtual interf.read_drv vif2,virtual interf.write_mon vif3,virtual interf.read_mon  vif4);
    this.vif1 = vif1;
    this.vif2 = vif2;
    this.vif3 = vif3;
  	this.vif4 = vif4;
    
    mb1 = new();
    mb2 = new();
    mb3 = new();
    mb4 = new();
    mb5 = new();
    mb6 = new();
    
  endfunction
  
  
task build(); 
    gen 	  = new(mb1, mb2);
    r_d 	  = new(mb2, vif2);
    w_d 	  = new(mb1, vif1);
    w_m 	  = new(mb3, vif3);
    r_m 	  = new(mb4, mb5, vif4);
    ref_mod   = new(mb3, mb4, mb6);
    sb 		  = new(mb6, mb5);
endtask
  
  
  task run();
    fork
      gen.run();
      r_d.run();
      w_d.run();
      w_m.run();
      r_m.run();
      ref_mod.run();
      sb.run();
    join
  endtask
  
endclass