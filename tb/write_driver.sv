//1.declaration 2.Mapping 3.Functionality

class write_driver;
   //1
  trxn t1;
  mailbox #(trxn) mb1;
  virtual interf.write_drv vinterface; //making a virtual interface with name "vinterface" by selecting interface "interf",then modport named "write_drv"
  
  //2
  function new(mailbox #(trxn) mb1,virtual interf.write_drv vinterface);
    this.mb1 = mb1;
    this.vinterface = vinterface;  
  endfunction
  
  //3
  task run();
    forever begin
      mb1.get(t1);
      vinterface.w_drv_cb.write_en <= 1'b1;
      
      repeat(2) @(vinterface.w_drv_cb); //?
      
      vinterface.w_drv_cb.write_addr <= t1.write_addr;
      vinterface.w_drv_cb.write_data <= t1.write_data;
      
      repeat(2) @(vinterface.w_drv_cb); //?
       vinterface.w_drv_cb.write_en <= 1'b0;
    end
  endtask 
  
endclass







//write driver functionality -  get the values from mb, wait,wr enable, drive it into DUT through interface