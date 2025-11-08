
when we are generating clock where we get the floating number for the half clock period, you need to have a good time precision  to generate that kind of period.    
 
 `timescale __timeunit________ / _____timeprecision_____                               
 
 `timescale 1ns / 1ps   --> 1ns --> TimeUnit      
                         --> 1ps --> TimePrecison       

Eg1: `timescale 1ns / 1ns = 1 = 10^0 = 0 so here "0" is the power for a ten that represent the number of precision digit     
        #10.1   --> 10    
        #10.11  --> 10    
        #10.111 --> 10    
        #10.6   --> 11 
        
Eg2:  `timescale 1ns / 1ps --> T. U / T.P = 1 ns/ 1ps = 10^-9/ 10^-12 = 1000 = 10^3 , so here "3" is the power for a ten that represent the number of precision digit          
        #10.1   --> 10.1     
        #10.23  --> 10.23     
        #10.331 --> 10.331      
        #10.3314   --> 10.331   
        #10.3316   --> 10.332     
