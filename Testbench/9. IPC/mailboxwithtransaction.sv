class transaction;
  randc bit [3:0] din1, din2;
  bit [4:0] dout;  
endclass

class generator;
  transaction t;
  mailbox gen2drv_mbx; // gen2drv
  
  function new(mailbox gen2drv_mbx);
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
  mailbox drv2gen_mbx;

  function new(mailbox drv2gen_mbx);
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
  mailbox mbx;

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
