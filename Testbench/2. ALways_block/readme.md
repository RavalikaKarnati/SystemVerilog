Types of always block    
1. Design:    
     1. always_comb --> to implement combinational circuits  
     2. alwyas_ff --> to implement sequential circuits  
     3. alwyas_latch --> to implement latch
        
2. Testbench:
   we ignore the sensivity list in tb because our agenda in a testbench code will primarily be to generate a stimulus.  
   So, whenever we use an always block, for generating a stimulus, we will simply ignore the sensitivity list.  

    always   statement;  

    always begin   
    ........................  
    ........................  
    ........................  
    end

Usage of Always Block:
1. generating a clock signal,  
2. generating a data signal, and  
3. generating a reset signal.  
   
So, in most above cases, we prefer using the initial and always blocks when generating stimulus for global signals  
