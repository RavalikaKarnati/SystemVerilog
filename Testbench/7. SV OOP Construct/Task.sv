////////////////////////////TASK WITH ARGUMENTS AND CALLING TASK WITH ARGUMENTS///////////////////////////////////
module tb ();

  // deafult direction : input
  task add ( input bit [3:0] a, input [3:0] b, output bit [4:0] y);
    y = a + b;
  endtask

  bit [3:0] a, b;
  bit [4:0] y;

  initial begin
    a = 4'h2;
    b = 4'h3;
    add(a,b,y);
    #1;
    $display ("Addition of a: %0d and b: %0d is %0d", a,b,y);
  end
endmodule

// OUTPUT
// Addition of a: 2 and b: 3 is 5

////////////////////////////TASK WITHOUT ARGUMENTS AND CALLING TASK WITHOUT ARGUMENTS///////////////////////////////////
module tb ();
  bit [3:0] a, b;
  bit [4:0] y;
  
  // default direction : input
  task add ();
    y = a + b;
  endtask

  initial begin
    a = 4'h2;
    b = 4'h3;
    add();
    #1;
    $display ("Addition of a: %0d and b: %0d is %0d", a,b,y);
  end
endmodule

// OUTPUT
// Addition of a: 2 and b: 3 is 5

////////////////////////////TASK WITHOUT ARGUMENTS AND CALLING TASK WITHOUT ARGUMENTS///////////////////////////////////
module tb ();
  bit [3:0] a, b;
  bit [4:0] y;
  
  // default direction : input
  task add ();
    y = a + b;
    $display ("Addition of a: %0d and b: %0d is %0d", a,b,y);
  endtask

  task stim_a_b();
    a = 1;
    b = 3;
    add();
    #10;
    a = 5;
    b = 6;
    add();
    #10;
    a = 7;
    b = 8;
    add();
    #10;
  endtask

  initial begin
    stim_a_b();
  end
  
endmodule

// OUTPUT
// #0 Addition of a: 1 and b: 3 is 4
// #10 Addition of a: 5 and b: 6 is 11
// #20 Addition of a: 7 and b: 8 is 15
// #30 sim is complete

////////////////////////////TASK WITHOUT ARGUMENTS AND CALLING TASK WITHOUT ARGUMENTS WITH CLOCK///////////////////////////////////
`timescale 1ns / 1ps
module tb ();
  bit [3:0] a, b;
  bit [4:0] y;
  bit clk = 0;

  // generate clk
  always #5 clk = ~clk;  // 10ns --> 100MHz  // when use a always block without sensitivity list thenit will run infinitly so we need to forcebly stop using $finish 
  
  // default direction : input
  task add ();
    y = a + b;
    $display ("Addition of a: %0d and b: %0d is %0d", a,b,y);
  endtask

  task stim_clk();
    @posedge(clk)  // check or wait on posedge of clk
    a = $urandom(); // unsigned 32bit random value
    b = $urandom();
    add();
  endtask

  initial begin
    for ( int i=0; i<11; i++); begin  // 11 random values for a and b in 110ns
      stim_clk();  
    end
  end

  initial begin
    #110;
    $finsih;
  end
  
endmodule

// OUTPUT
// #5 Addition of a: 1 and b: 3 is 4
// #15 Addition of a: 5 and b: 6 is 11
// #25 Addition of a: 7 and b: 8 is 15
// #35 Addition of a: 7 and b: 8 is 15
// #45 Addition of a: 7 and b: 8 is 15
// #55 Addition of a: 7 and b: 8 is 15
// #65 Addition of a: 7 and b: 8 is 15
// #75 Addition of a: 7 and b: 8 is 15
// #85 Addition of a: 7 and b: 8 is 15
// #95 Addition of a: 7 and b: 8 is 15
// #105 Addition of a: 7 and b: 8 is 15


////////////////////////////TASK ASSIGNMENT///////////////////////////////////

// Create a task that will generate stimulus for addr , wr, and en signal as mentioned in a waveform of the Instruction tab. 
// Assume address is 6-bit wide while en and wr both are 1-bit wide. The stimulus should be sent on a positive edge of 25 MHz clock signal.
`timescale 1ns / ps
module tb;

  bit clk = 1'b0;
  bit [5:0] addr;
  reg en, wr;
  // generate clock
  always #20 clk = ~clk // 20 MHz = 40ns;

  task stim_addr_wr_en();
  @posedge (clk)
  addr = 6'h12;
  en = 1'b1;
  wr = 1'b1;
  #40;
  addr = 6'h14;
  #40;
  addr = 6'h23;
  wr = 1'b0;
  #40;
  addr = 6'h48;
  #40;
  addr = 6'h56;
  en = 1'b0;
  endtask

  initial begin
    stim_addr_wr_en();
  end

  initial begin
    $dumpfile("dump.vcd")
    $dumpvars;
  end

  initial begin
   #250;
   $finish;
  end
endmodule























