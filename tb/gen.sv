
class gen;
  //1
  trxn t0,t1; //2 handles of trxn class
  mailbox #(trxn)mb1, mb2; //mailbox mb1 & mb2 ready to trnsfr packets of type trxn
  
  //2
  function new (mailbox #(trxn)mb1, mb2);
   this.mb1 = mb1; //For write_drv
   this.mb2 = mb2; //For Read_drv
   t0 = new();   
    
  endfunction
  
  //3
  task run();
    repeat(10) begin
      t0.randomize();
      t1 = new t0; //shallow copying randomized t0 before putting it into mailbox
      mb1.put(t1);  //to write driver
      mb2.put(t1);  //read driver      
    end
  endtask
  
  
endclass
















////3 step to follow
//   1.declaration  2.mapping  3.functionality