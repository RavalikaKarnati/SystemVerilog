// when using multiple process with initial -- begin blocks, there may be situations with Race Condfitions and data received and sent is not in synchronization, to avopid this , we use fork --join
module tb;
  
  int data1,data2;
  event done;
  
  int i =0;
  
  ////Generator
  initial begin
    for(i =0; i< 10; i++) begin
      data1 = $urandom(); 
      $display("Data Sent : %0d", data1);
      #10;
    end
   -> done;
  end
  
  ///////Driver
  
  initial begin
    forever begin
     #10;
     data2 = data1;
     $display("Data RCVD : %0d", data2);
    end
  end
  /////////////
  
  initial begin
    wait(done.triggered);
    $finish();
  end
  
endmodule

//output
# KERNEL: Data Sent : -1866196019  // data sent is twice , no synchronization
# KERNEL: Data Sent : 1497363586
# KERNEL: Data RCVD : 1497363586
# KERNEL: Data Sent : -323839875
# KERNEL: Data RCVD : -323839875
# KERNEL: Data Sent : 484274802
# KERNEL: Data RCVD : 484274802
# KERNEL: Data Sent : 1697558877
# KERNEL: Data RCVD : 1697558877
# KERNEL: Data Sent : -1150633903
# KERNEL: Data RCVD : -1150633903
# KERNEL: Data Sent : -1621255588
# KERNEL: Data RCVD : -1621255588
# KERNEL: Data Sent : 200096136
# KERNEL: Data RCVD : 200096136
# KERNEL: Data Sent : -1608882576
# KERNEL: Data RCVD : -1608882576
# KERNEL: Data Sent : -491775510
# KERNEL: Data RCVD : -491775510
# KERNEL: Data RCVD : -491775510 // data received is twice , no synchronization
