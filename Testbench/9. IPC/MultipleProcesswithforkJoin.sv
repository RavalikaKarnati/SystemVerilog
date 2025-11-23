module tb;
  int i =0;
  bit [7:0] data1,data2;
  event done;
  event next;
  
  task generator();   
   for(i = 0; i<10; i++) begin  
      data1 = $urandom();
      $display("Data Sent : %0d", data1);
     #10; 
     wait(next.triggered);  // As soon as the generator receives the trigger for an event, it will send the next sample
                            // This trigger is doing a handshake between the generator and the driver    
    end
    
   -> done; // This event will convey the end of a simulation
  endtask
  
  task receiver();
     forever begin
       #10;
      data2 = data1;
      $display("Data RCVD : %0d",data2);
      ->next;   // triggering an event "next" to let the geneartor know that receiver received the data and ask to generate the next stimulus
    end
  endtask
    

  task wait_event();
    wait(done.triggered);  // once all the 10 random values are generated, done is triggered. This indicates that all the stimulus are generated and ready to call finish
    $display("Completed Sending all Stimulus");
     $finish();
  endtask

// If initial begin blocks are used without fork--join, we may have the possibility of facing a race condition when we have multiple initial begin blocks because we do not know exactly which
// process will get priority. That may sometimes lead to a race condition. But when we consider the fork-- join, we can be sure that all the processes will be executed in parallel, and the system
// perfectly handles the synchronization between the processes.
// fork -- join  is used to execute all the process in parallel to avoid race condition and to achieve perfect synchronization.
  
 initial begin
    fork
      generator();
      receiver();
      wait_event();
    join  
   /// // fork join will hold the simulation. Iff there is any statement after a join, we won't be able to execute it unless all of this completes its execution. 
  end  
endmodule
