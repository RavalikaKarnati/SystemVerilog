//  mailbox --  how to send data between classes. generator and driver, where we have a single data member that we want to send between the classes,
// mailbox is a mechanism by which we communicate data between generator and driver, and between monitor and scoreboard

class generator;
  int data = 12;
  mailbox gen2drv_mbx; // gen2drv
  task run();
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
    gen.gen2drv_mbx = mbx;  // common for both generator and driver
    drv.drv2gen_mbx = mbx;
    gen.run();
    drv.run();
  end
endmodule
