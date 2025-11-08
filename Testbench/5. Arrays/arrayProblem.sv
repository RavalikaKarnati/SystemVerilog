//Create a dynamic array capable of storing 7 elements. add a value of multiple of 7 starting from 7 in the array (7, 14, 21 ....49). After 20 nsec Update the size of the dynamic array to 20.   
//Keep existing values of the array as it is and update the rest 13 elements to a multiple of 5 starting from 5. Print Value of the dynamic array after updating all the elements.  
//Expected result : 7, 14, 21, 28 ..... 49, 5, 10, 15 ..... 65 .

`timescale 1ns / 1ps;
module tb;
  int arr7[]; 

  initial begin
    arr7 = new [7];
    for ( int i=0; i<7; i++)begin
      arr7[i] = 7*(i+1);
    end
    $display("dynamic array with 7 elements: %0p", arr7);
    #20;
    arr7 = new [20] (arr7);  // Keeping existing values of the array as it is by adding (arr7)
    $display("dynamic array with new memory of 20 elements: %0p", arr7); 
    
    for ( int i=7; i<20; i++) begin
    arr7[i] = 5*(i-6);
    end
    $display("dynamic array with 20 elements: %0p", arr7);   
  end
  
endmodule

//output:
//dynamic array with 7 elements: 7 14 21 28 .... 49
//dynamic array with new memory of 20 elements: 7 14 21 28 35 42 49 0 0 0 0 0 0 0 0 0 0 0 0
//dynamic array with 20 elements: 7 14 21 28 35 42 49 5 10 15 20 25 . . .. .. 65
