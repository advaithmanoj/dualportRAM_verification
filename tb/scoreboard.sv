class sb;
  
trxn t1, t2;
mailbox #(trxn) mb1, mb2;
  
  
  function new(mailbox #(trxn) mb1, mb2);
    this.mb1 = mb1;//from ref model
    this.mb2 = mb2; // from rd mon
  endfunction
  

  task run();
    
    forever begin

      fork 
      mb1.get(t1);
      mb2.get(t2);
      join
      
      if(t1.read_addr != t2.read_addr)
        $display("address mismatch");
      else if (t1.read_data != t2.read_data)
        $display("data mismatch");
      else
        $display("transaction successfully Verified!!");  
      
    end
    
    
  endtask
endclass










//sb will have 2 trxn handles cos need to pkts to compare from ref and rd mon
/*    
declaration and mapping

functionality of scoreboard
get pkts from 2 mailboxes parallely,then check for addr mismtach,data mismatch.
if all same then print trxn verified

*/