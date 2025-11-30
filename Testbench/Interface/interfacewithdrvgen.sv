// we create a deep copy for transaction to have an independent object in each iteration and to have a single history,  or a single space for an object
// adding a constructor for a transaction inside the constructor of a generator, And when we send an object, we'll send a copy of
// the object and not the original transaction object,
// ADvs: 1. No reptition of the values means have a history
//       2. has independent space or object


//instruction rules
// 1. add transaction constructor in generator custom constructor
//2. send deep copy of transaction between generator and driver

///////////////////////////////////////////////////////////////// DESIGN //////////////////////////////////////////////////////////////////////
module add ( 
  input clk,
  input [3:0] a, b,
  output reg [4:0] sum 
);
  always @( posedge clk) begin
     sum <= a+b;
  end
endmodule

///////////////////////////////////////////////////////////////// testbench //////////////////////////////////////////////////////////////////////

class transaction;
  randc bit [3:0] a, b;
  bit [4:0] sum;
  function void display();
    $display("value of a : %0d \t b: %0d \t sum: %0d", a , b, sum);
  endfunction

  function transaction copy();
    copy = new();
    copy.a = this.a;
    copy.b = this.b;
  endfunction
endclass

interface add_if;
  logic [3:0] a, b;
  logic [4:0] sum;  //  using logic is that it supports both procedural and continuous assignments, so we do not need to worry about those scenarios like use of reg or wire
                    //  if we use reg or wire, we need to consider whether the design uses procedural or continuous assignments, but since logic supports both, it automatically adapts to the specific situation. 
  logic clk;
  modport DRV (        //One of the constructs is a modport used to specify the direction, it may help us to prevent wiring errors
    output a, b,
    input sum, clk
  );
endinterface

class generator;
  transaction t;
  mailbox #(transaction) gen2drv_mbx;
  event done;
  event next;
  
  function new(mailbox #(transaction) gen2drv_mbx);   // custom constrcutor for generator to connect mailboxfrom tb top
    this.gen2drv_mbx = gen2drv_mbx;
    t = new();  // adding a constructor for a transaction inside the constructor of a generator, And when we send an object, we'll send a copy of
                // the object and not the original transaction object,
  endfunction
  
  task run();
//    t = new();       // this cover all the possible values, we won't see the repetition of a value but when we send a single object throughout the test bench path 
                     //sometimes it might happen that it consumes more time than the time we have in the generator class.
    int status = 0;
    for(int i=0; i<10; i++) begin
//      t = new();          //  we are calling randc, So this basically means,until and unless we cover all the possible values, we won't see the repetition of a value. But when
                         // we add a new object over here since we have added a new object for each iteration, we simply do not get a history. So for each independent object, we get a new history or a new
                         // space, and for that reason, you could see an immediate repetition of a value, even though we have utilized the randc.
     status = t.randomize();
     assert(status)
      else $display("[GEN] randomization Failed");
      $display("[GEN]: data send to driver");
      t.display();
      gen2drv_mbx.put(t.copy); // send the copy of the data
      #10;
      wait(next.triggered);  // As soon as the generator receives the trigger for an event, it will send the next sample
                            // This trigger is doing a handshake between the generator and the driver  
    end  
  endtask
   -> done; // This event will convey the end of a simulation
endclass

class driver;
  transaction dc;
  mailbox #(transaction) drv2gen_mbx;
  event next;
  
  function new(mailbox #(transaction) drv2gen_mbx);
    this.drv2gen_mbx = drv2gen_mbx;
  endfunction

  task main();
    forever begin
      //     dc = new();    // this is not needed as get(); method creates objects automatically
      drv2gen_mbx.get(dc);  //  we do not need to add the new method for So we just need to specify the data container, and this will automatically create an object where we have data
      $display("[DRV] data RCVD from generartor");
      @(posedge aif.clk)
      aif.a <= t.a;
      aif.b <= t.b; 
      dc.display();
      #10;
      ->next;   // triggering an event "next" to let the geneartor know that receiver received the data and ask to generate the next stimulus
    end
  endtask
  
  virtual add_if.DRV aif;  // Virtual -- definition of an interface is defined outside the class
endclass

module tb;
  
  add_if aif();     // instantiate interface
  add dut(          // instantiate DUT and connect with interface
    .a(aif.a),       // Once this connection is done, anything applied to the variables of the interface will automatically go into the DUT, and  see a response.
    .b(aif.b),
    .sum(aif.sum),
    .clk(aif.clk)
  );

  initial begin
    aif.clk = 0;
  end
  always #10 aif.clk = ~aif.clk;

  driver drv;
  generator gen;
   mailbox #(transaction) mbx;
  event done;
  event next;
  
  initial begin
    mbx = new();
    gen = new(mbx);
    drv = new(mbx);
    done = gen.done;
    drv.aif = aif; // connecting interface from inside class aif to the interface outside the class // this will allow to send stimulus from driver to DUT
  end

  task wait_event();
    wait(done.triggered);  // once all the 10 random values are generated, done is triggered. This indicates that all the stimulus are generated and ready to call finish
    $display("Completed Sending all Stimulus");
    $finish();
  endtask
  
  initial begin
    fork 
      gen.run();
      drv.main();
    join
    wait_event();
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;  // add all variable values to vcd file
  end
endmodule
