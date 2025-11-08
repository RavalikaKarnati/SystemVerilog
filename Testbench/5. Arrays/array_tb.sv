/////////////////////////////////// How to declare an array ////////////////////////////////////////////


`timescale 1ns/1ps

module tb();
  
  
  // declearing/initializing a fixed array 
  bit array_1[4];
  bit array_2[] = {1,0,1,1,1,0,0};
  
  
  initial begin 
    // accessing size of an array 
    $display("size of arrays : %0d, %0d", $size(array_1), $size(array_2));
    
    array_1[1] = 1;
    $display("array elements: %0d", array_1[1]);
    
    //printing/ accessing all elements of an array :
    
    // 1) By Indexing method
    for(int i =0; i < $size(array_2) ; i++) begin
      $display("elements: %0d", array_2[i]);
    end 
    
    // 2) By Format specifier method = %0p - prints all elements in array
    
    $display("elements: %0p", array_2);
    
  end 
endmodule



////////////////////////////////////////////////////// Different ways to initialize an array/////////////////////////////////////////




`timescale 1ns/1ps

module tb();
  
  
  // type-1 declaring unique initial values for fixed array
  int array_1[4] = '{20,30,40,80};
  
  // type-2 declaring repititive initial values for fixed array
  int array_2[4] = '{ 4{20} };
  
  // type-3 declaring default initial values for fixed array
  int array_3[8] = '{ default: 2 };
  
  
  // type-4 declearing un initialized fixed array 
  bit array_4_1[5];
  logic array_4_2[6] ;
  
  initial begin 
  
    //has all valuesa as 20 
    $display(" elements of type initialized repititive : %0p", array_2);
    //has all values as 2
    $display(" elements of type initialized default : %0p", array_3);
     // has default value as 0's due to bit
    $display(" elements of type unitialized: %0p", array_4_1);
    // has default values as X's due to logic 
    $display(" elements of type unitialized: %0p", array_4_2);
    
    
  end 
endmodule



///////////////////////////////////////////ARRAY OPERATIONS : 1) COPY 2) COMPARE /////////////////////////////////////////////////////////////////////


/////////////////          COPY           /////////////////


module tb;
  
  
  int arr_1[6];
  int arr_2[6];// arr_2 is of Same data type and size as arr_1. No issues
  
  int arr_3[8]; // using this will create an error while copying since number of elements in arr_1 is different than arr_3
  
  shortint arr_4[6]; //using this will create an error while copying since data type of arr_1 and arr_4 is different
  
  initial begin 
    
  for ( int i =0; i <5; i ++) begin 
    arr_1[i] = 10*i;
    arr_2[i] = arr_1[i];  // copying contents of arr_1 into arr_2
  end 
    //(or) arr_2 = arr_1;  // copying contents of arr_1 into arr_2- this also works
    //    arr_3[8] = arr_1[6]; // using this will create an compile error while copying since number of elements in arr_1 is different than arr_3
    //    arr_4[6] = arr_1[6]; //using this will create an compile error while copying since data type of arr_1 and arr_4 is different
    $display("arr_2 elements are %0p", arr_2);
  end 
endmodule 


////////////////       COMPARE    /////////////

module tb;
  
  
  int arr_1[6] = '{1,2,3,4,5,6};
  int arr_2[6] = '{7,8,9,10,11,12};
  int arr_3[6] = '{7,8,9,10,11,12};
  
  bit status_1;
  bit status_2;
  
  initial begin 
    
    status_1 = (arr_1 == arr_2);
    status_2 = (arr_1 != arr_3);
    
    $display("status %0b:", status_1);   // it returns '0'
    $display("status %0b:", status_2);   // it returns '1'
  end 
endmodule 
