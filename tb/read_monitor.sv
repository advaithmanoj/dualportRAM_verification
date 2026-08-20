class read_monitor;
  //1
  trxn txn, t1, t2;
  mailbox #(trxn) mb1, mb2;
  virtual interf.read_mon vinterface;
  
  //2
  function new( mailbox #(trxn) mb1, mb2, virtual interf.read_mon vinterface)
    	this.mb1 = mb1; //reference_module
    	this.mb2 = mb2; //scoreboard
    	this.vinterface = vinterface;    
        txn = new();
  endfunction
  
  //3
  task run();
    forever begin
      
      repeat(2)@(vinterface.r_mon_cb);
      
      wait(vinterface.r_mon_cb.read_en);
      txn.read_addr  = vinterface.r_mon_cb.read_addr;
      txn.read_data  = vinterface.r_mon_cb.read_data;
     
      repeat(2)@(vinterface.r_mon_cb);
      
      t1 = new txn;
      t2 = new txn;
      
      mb1.put(t1);  //reference 
      mb2.put(t2);  //to scoreboard
    end 
  endtask
  
  
endclass
 //read monitor func
//wait for few cycles of read monitor and read enable goes high
// then get the addr and data values from dut through interface to txn packet
  
// make 2 copies of this and send to score board and ref module
  
  