class write_monitor;
  
  trxn t1;
  mailbox #(trxn) mb1;
  virtual interf.write_mon vinterface;
  
  function new(mailbox #(trxn) mb1,virtual interf.write_mon vinterface);
    this.mb1 = mb1;
    this.vinterface = vinterface;
    t1 = new();
  endfunction
  
  task run();
    
    forever begin
      repeat(2) @(vinterface.w_mon_cb);
      
      wait(vinterface.write_mon.write_en);
      
      t1.write_addr <= vinterface.write_mon.write_addr;//should i use mon or cb
      t1.write_data <= vinterface.write_mon.write_data;
      
      repeat(2) @(vinterface.w_mon_cb);
      
      mb1.put(t1);
    end
  endtask

endclass













//functionality of write monitor
//wait for few cycles of write monitor so that grabage value gets cleared out
//wait till write en goes high from the interface
//drive data and address from interface to a trxn object
//wait few cycles before putting it into a mailbox