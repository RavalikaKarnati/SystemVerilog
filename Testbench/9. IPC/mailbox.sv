//  mailbox --  how to send data between classes. generator and driver, where we have a single data member that we want to send between the classes,
// mailbox is a mechanism by which we communicate data between generator and driver, and between monitor and scoreboard

class generator;
  int data = 12;
  mailbox gen2drv_mbx; // gen2drv
  task run();
    $display("[GEN] : SENT DATA before mailbox : %0d", data);
    gen2drv_mbx.put(data);
    $display("[GEN] : SENT DATA : %0d", data); //  we follow UVM-like terminology, We can add a tag
  endtask
endclass

class driver;
  int datac = 0;
  mailbox drv2gen_mbx;
  task run();
    drv2gen_mbx.get(datac);
    $display("[DRV] : RCVD DATA : %0d", datac);
  endtask
endclass

module tb;
  generator gen;
  driver drv;
  mailbox mbx;

  initial begin
    gen = new();
    drv = new();
    mbx = new();
    gen.data = 20;
    
     gen.gen2drv_mbx = mbx;  // common for both generator and driver
     drv.drv2gen_mbx = mbx;
    
    gen.run();
    drv.run();
  end
endmodule

//OUTPUT
# KERNEL: [GEN] : SENT DATA : 12
# KERNEL: [DRV] : RCVD DATA : 12
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.

//////////////////////////////////////////////////////////////////////////////////////////////////// specify mailbox with custom constructor ////////////////////
// having custom constructor for the mailbox that basically simplifies the entire process by specifying the mailbox there itself

class generator;
  int data = 12;
  mailbox gen2drv_mbx; // gen2drv
  function new(mailbox gen2drv_mbx);
    this.gen2drv_mbx = gen2drv_mbx;
  endfunction
  
  task run();
    gen2drv_mbx.put(data);
    $display("[GEN] : SENT DATA : %0d", data); //  we follow UVM-like terminology, We can add a tag
  endtask
endclass

class driver;
  int datac = 0;
  mailbox drv2gen_mbx;

  function new(mailbox drv2gen_mbx);
    this.drv2gen_mbx = drv2gen_mbx;
  endfunction
  
  task run();
    drv2gen_mbx.get(datac);
    $display("[DRV] : RCVD DATA : %0d", datac);
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

    gen.run();
    drv.run();
  end
endmodule

//OUTPUT
# KERNEL: [GEN] : SENT DATA : 12
# KERNEL: [DRV] : RCVD DATA : 12
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
