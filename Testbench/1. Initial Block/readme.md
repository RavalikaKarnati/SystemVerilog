There are three types of signals that will be present in our design. 
The first one is the global signal, which includes reset and clock.
The second one is the control signal, which controls the operation of our design. (wr_en, rd_en, out_en, raddr, waddr)
The third one is the data signal. ( Eg: Memory with rdata, wdata)

For control and data signals, we’ll be generating stimulus from SystemVerilog, while for global signals, specifically for clocksignals, we won’t be generating random signals.
The stimulus for a global signal (clk, rst) will mostly be generated in the testbench top, and for the control and data signals, we will be utilizing our verification environment to generate the
stimulus as well as to analyze the response from a DUT.

Two fundamental SystemVerilog Constructs which we need to know for generation of clock.
1. Initial Block
2. Always Block

we can have multiple initial begin blocks in the testbench top code. There is no restriction on how many initial blocks you have in your testbench code, 
and all of them will start executing at 0ns

Usauge of Initial begin statements:  
1. Initialize a global signals clk, rst  
    reg clk;  
    reg rst;  
    initial begin  
      clk = 1'b0;  
      rst = 1'b0;  
    end
   
2. Generating random signals for data/ control or generate clk or rst  
   initial begin  
    rst = 1'b0;\
    #30;\
    rst = 1'b1;\
   end
   
   reg [3:0] temp;\
   initial begin\
     temp = 4'b0100;\
     #10;\
     temp = 4'b1100;\
     #10;\
     temp = 4'b1101\
   end
   
4. Waveform viewer // run system task at the start of simulation\
    initial begin\
       $dumpfile("dump.vcd");\
       $dumpvars;\
    end
5. Analyize variable values on console\
   $monitor("Temp: %0d at time: %0t", temp, $time);\
   $display();
6. Finish or stop simulation by forcefully calling $finish or $stop // call finish system task\
   initial begin\
   #200;\
   $finsh;\
   end
