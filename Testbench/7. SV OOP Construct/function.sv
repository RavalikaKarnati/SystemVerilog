// for an argument that you want to add to a function it is mandatory that you specify the direction and type 
// it is also mandatory that you specify the return type for a function 
//
//
//
//
///////////////////////////////////////////////////////////// FUNCTION definition WITH RETURN TYPE and ARUGUMENTS, function call WIth arguments////////////////////////////////////////////////
module tb;

  function bit[4:0] add(input bit [3:0] a, b);
    return a+b;     
  endfunction

  bit [4:0] result; 
  bit [3:0] ain = 4'b0011;
  bit [3:0] bin = 4'b0111;
  initial begin
    result = add(4'b0010,4'b0100);  // 2+4 = 6
//    #10;  // when you try to use timing coontrols then we get compile error becuase function do not support any timing control functions so No delays #, @, $
    $disaply("Method1: Result from addition : %0d", result);

    /////////////// method2 /////////////
    result = add(ain, bin); 
    $disaply("Method2: Result from addition : %0d", result);
    
  end
endmodule
// OUTPUT
// KERNEL: Method1: Result from addition : 6
// KERNEL: Method2: Result from addition : 10


///////////////////////////////////////////////////////////// FUNCTION definition WITH RETURN TYPE and ARUGUMENTS, function call Without arguments////////////////////////////////////////////////
module tb;

  function bit[4:0] add(input bit [3:0] a, b);
    return a+b;     
  endfunction

  bit [4:0] result; 
  bit [3:0] ain = 4'b0011;
  bit [3:0] bin = 4'b0111;
  initial begin
    result = add();   // gives an error as fucntion expects arguments. But if a , b values are initialized to some default values then we don't an error
                      // Eg: function bit[4:0] add(input bit [3:0] a = 4'b0010, b = 4'b0011); if we initilaized deafult values to a and b in function then it will show result as "5"
    $disaply("Method3: Result from addition : %0d", result); 
    
  end
endmodule

// OUTPUT
// For method3 , it gives error because we did not include arguments "unspecified argument is used dfor an argument that does not have a default value"
// Method3: Result from addition : 5 // if initilaized deafult values to a and b in function as function bit[4:0] add(input bit [3:0] a = 4'b0010, b = 4'b0011);


///////////////////////////////////////////////////////////// FUNCTION definition WITH RETURN TYPE But function definition and function call WIthout arguments////////////////////////////////////////////////
module tb;

  bit [4:0] result; 
  bit [3:0] ain = 4'b0011;
  bit [3:0] bin = 4'b0111;
  
  function bit[4:0] add();
    return ain+bin;     
  endfunction

  initial begin
    result = add();  // 3+7 = 10
    $disaply("FUNCTION2: Result from addition : %0d", result); 
    
  end
endmodule

// OUTPUT
// KERNEL: FUNCTION2: Result from addition : 10

///////////////////////////////////////////////////////////// FUNCTION definition WITH VOID TYPE But function definition and function call WIthout arguments////////////////////////////////////////////////
module tb;

  bit [4:0] result; 
  bit [3:0] ain = 4'b0011;
  bit [3:0] bin = 4'b0111;
  
  function void display_ain_bin();
    $display(" ain : %0d and bin : %0d", ain, bin);   
  endfunction

  initial begin
    display_ain_bin();
  end
endmodule

// OUTPUT
// KERNEL: ain : 3 and bin : 7

///////////////////////////////////////////////////////////// FUNCTION definition WITH ////////////////////////////////////////////////
module tb;

  bit [4:0] result; 
  bit [3:0] ain = 4'b0011;
  bit [3:0] bin = 4'b0111;
  
  function void display_ain_bin();
    $display(" ain : %0d and bin : %0d", ain, bin);   
  endfunction

  initial begin
    display_ain_bin();
  end
endmodule

// OUTPUT
// KERNEL: ain : 3 and bin : 7

