//trxn class contains pins to DUT,constraints,pre,post randomize defintions or any methods to be used throught out the testbench

class trxn;
  //creating packets
  rand bit write_en;
  rand bit [7:0] write_addr;
  rand bit [31:0] write_data;
  rand bit read_en;
  rand bit [7:0] read_addr;
  bit [31:0] read_data;    //output not to be randomized
  
  
  //constraints
  constraint valid_en{{write_en, read_en} != 2'b0;}
  constraint valid_addr{write_addr != read_addr;}
  constraint valid_data{write_data inside {[0:43]};}
  
  
    function void post_randomize();
    $display(" WRITE SIGNALS");
    $display("write_en = %0b, write_addr = %0d, write_data = %0h", write_en, write_addr, write_data);
     $display("-------------------------");
    $display(" READ SIGNALS");
    $display("read_en = %0b, read_addr = %0d, read_data = %0h",
          read_en, read_addr, read_data);
     $display("-------------------------");
      
  endfunction
  
  
endclass