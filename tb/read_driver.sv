//declaration mapping functionality

class read_driver;
  //1
  trxn t1;
  mailbox #(trxn) mb2;
  virtual interf.read_drv vinterface;
  
  //2
  function new(mailbox #(trxn) mb2,virtual interf.read_drv vinterface);
    $display("[INFO]@ %0t:Creating read_driver",$time);
    this.mb2 = mb2;
    this.vinterface = vinterface;
  endfunction
  
  //3
  task run();
    forever begin
      mb2.get(t1);
      vinterface.r_drv_cb.read_en <= 1'b1;
      
      repeat(2)@(vinterface.r_drv_cb)
        
      vinterface.r_drv_cb.read_addr <= t1.read_addr;
      
      repeat(2)@(vinterface.r_drv_cb)
      vinterface.r_drv_cb.read_en <= 1'b0;
    end
  endtask
endclass

  
//get packet from mb, drive rd enable ,wait then drive read adress wait then rd disable
 
