class ref_model;
  
  trxn txn,t1,t2;
  mailbox #(trxn) mb1,mb2,mb3;  

  int mem[int]; //memory
  
  function new( mailbox #(trxn) mb1,mb2,mb3);
    this.mb1=mb1;  //from write mon
    this.mb2=mb2;  //from rd mon
    this.mb3=mb3;  //to scoreboard
  endfunction
  
  
  task run();
    
    forever begin
      
      fork 
        
        //write
        begin
          mb1.get(t1);
          mem[t1.write_addr] = t1.write_data;
        end
        
         //read
        begin
          mb2.get(t2);
          if(mem.exists(t2.read_addr))  //1 if data exists
          t2.read_data = mem[t2.read_addr]; //expected data
          else
            $display("No value is found in this address %d",t2.read_addr);
          mb3.put(t2);
        end
        
      join
    end
  endtask
endclass








//ref model  declare mapp functionality
/*    
declaring - trxn class with 3 /2 handles? 3 mailbox-from wr_mon,rd_mon ,scoreboard
and memmory here
mapping -  these 3 mailboxs from arguments to handles inside
functionality
2 parallel statements in a runtask
write- get packet from wr_mon mb, write the data into the addr
read- get packet from rd_mon, check if mem exists, 
Y - drive data from the address to a pkt
N - display ("its emptyy")
After this, we should sent the pkt to the scoreboard

*/