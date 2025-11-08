/////////////////////////////////////////// Method-1 : generating Clock ///////////////////////////////////////
`timescale 1ns / 1ps
 
module tb();
  reg clk = 0; 
  reg clk2 = 0;  
  real phase_diff = 10;
  real ton = 5;
  real toff = 5; 
 
  always #5 clk = ~clk; //100 MHz --> 10ns
 
  initial begin 
    #phase_diff;
    while(1) begin
      clk2 = 1;  
      #ton;
      clk2 = 0;
      #toff;
     end
  end
 
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end 
 
  initial begin
    #200;
    $finish();
  end
endmodule

/////////////////////////////////////////// Method-2 : generating Clock ///////////////////////////////////////
`timescale 1ns / 1ps
 
module tb();
  reg clk = 0; 
  reg clk50 = 0;
  real phase_diff = 10;
  real ton = 5;
  real toff = 5; 
 
  always #5 clk = ~clk; //100 MHz --> 10ns
 
  task clkgen(input real phase, input real ton, input real toff);  
    #phase_diff;
    while(1) begin
    clk50 = 1;
    #ton;
    clk50 = 0;
    #toff;
    end
  endtask

  initial begin
    clkgen(phase, ton, toff);
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end 
  initial begin
    #200;
    $finish();
  end
endmodule

/////////////////////////////////////////// Method-3 : generating Clock ///////////////////////////////////////
 
`timescale 1ns / 1ps
module tb();
 
  
  reg clk = 0; 
  reg clk50 = 0;
  real phase;
  real ton;
  real toff;
 
  always #5 clk = ~clk; //100 MHz 
 
  task calc (input real freq_hz, input real duty_cycle, input real phase, output real pout, output real ton, output real toff);
    pout = phase;
    ton = (1.0 / freq_hz) * duty_cycle * 1000_000_000;
    toff =  (1000_000_000 / freq_hz) - ton;
  endtask
  
  task clkgen(input real phase, input real ton, input real toff);  
    @(posedge clk);
    #phase;
    while(1) begin
    clk50 = 1;
    #ton;
    clk50 = 0;
    #toff;
    end
  endtask 
 
initial begin
calc(100_000_000, 0.1, 2, phase, ton, toff);
clkgen(phase, ton, toff);
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
end

initial begin
    #200;
    $finish();
end
  
endmodule
