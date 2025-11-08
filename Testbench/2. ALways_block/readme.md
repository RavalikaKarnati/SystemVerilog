    // Generate a clock with a separate always block.   
  mopdule tb();  
    reg clk = 0;    
    always begin : generate_clock    
        forever #5 clk <= !clk;    
    end    
         // An RTL simulation finishes on its own when there are no more events  
         // to simulate. Because we use an always block to toggle the clock,   
         // there will always be events to simulate, so it the simulation will  
         // never stop on its own. We can force it to stop with either $stop or  
         // $finish.  
         // $stop pauses a simulation, usually so it can be debugged and resumed.  
         // $finish will terminate the simulation. If you are using Modelsim or  
         // Questa, $finish will ask you if you want to exit.   
         //$stop;   
        $finish;  
    end  
endmodule  
