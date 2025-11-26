//WARNING VCP2947 "Default parameter values used for class std::mailbox specialization." "testbench.sv" 8  22
//WARNING VCP2947 "Default parameter values used for class std::mailbox specialization." "testbench.sv" 10  35
//WARNING VCP2947 "Default parameter values used for class std::mailbox specialization." "testbench.sv" 30  22
//WARNING VCP2947 "Default parameter values used for class std::mailbox specialization." "testbench.sv" 32  35
//WARNING VCP2947 "Default parameter values used for class std::mailbox specialization." "testbench.sv" 49  14

// to avoid above warnings we parameterize the mailboxes using the keyword #(transaction class name)
// it will not just remove a warning, but if you mistakenly try to send other data type values, it will simply throw an error.

class transaction;
  randc bit [3:0] din1, din2;
  bit [4:0] dout;  
endclass

class generator;
  transaction t;
  mailbox #(transaction) gen2drv_mbx; // gen2drv
  int status = 0;
  function new(mailbox #(transaction) gen2drv_mbx);
    this.gen2drv_mbx = gen2drv_mbx;
  endfunction
  
  task main();   
    for (int i=0; i< 10; i++) begin
      t = new();
      status = t.randomize();
      assert(status)
      else
        $display("Randomization failed");
      $display("[GEN] data sent din1: %0d, din2: %0d", t.din1, t.din2);
      gen2drv_mbx.put(t);
      #10;
    end 
  endtask
endclass

class driver;
  transaction dc;
  mailbox #(transaction) drv2gen_mbx;

  function new(mailbox #(transaction) drv2gen_mbx);
    this.drv2gen_mbx = drv2gen_mbx;
  endfunction
  
  task main();
    forever begin
      //     dc = new();    // this is not needed as get(); method creates objects automatically
      drv2gen_mbx.get(dc);  //  we do not need to add the new method for So we just need to specify the data container, and this will automatically create an object where we have data
      $display("[DRV] data RCVD din1: %0d, din2: %0d", dc.din1, dc.din2);
      #10;
    end
  endtask
endclass

module tb;
  generator gen;
  driver drv;
  mailbox #(transaction) mbx;

  initial begin
    mbx = new();
    gen = new(mbx);  // having custom constructor for the mailbox that basically simplifies the entire process by specifying the mailbox there itself
    drv = new(mbx);  // having custom constructor for the mailbox that basically simplifies the entire process by specifying the mailbox there itself
  fork
    gen.main();
    drv.main();
  join
  end
endmodule

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class transaction;
  
  bit [7:0] data;
  
endclass
 
 
class generator;
  
  int data = 12;
  transaction t;
  
  mailbox #(transaction)  mbx;
  
  logic [7:0] temp = 3;
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  
  task run();
    t = new();
    t.data = 45;
    mbx.put(temp);         // error mismatch datatype
    $display("[GEN] : Data Send from Gen : %0d ",t.data);
  endtask
  
endclass
 
class driver;
  mailbox #(transaction) mbx;
  transaction data;
  
  function new(mailbox #(transaction)  mbx);
    this.mbx = mbx;
  endfunction
    
  task run();
    mbx.get(data);
    $display("[DRV] : DATA rcvd : %0d",data.data);
  endtask  
endclass
  
module tb;
  generator gen;
  driver drv;
  mailbox #(transaction) mbx;
  
  initial begin
 
    mbx = new();
    gen = new(mbx);
    drv = new(mbx); 
    fork
    gen.run();
    drv.run();
    join
  end
  
endmodule

//output
ERROR VCP2821 "Incompatible types in function/task call: 'this.temp' of type 'logic[7:0]' does not match '~\generator _vstruct\.mbx.put.message' of type 'transaction'." "testbench.sv" 25  18
FAILURE "Compile failure 1 Errors 0 Warnings  Analysis time: 1[s]."
Exit code expected: 0, received: 255
