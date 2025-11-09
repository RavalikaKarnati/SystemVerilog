

module tb;
  
  function init_arr( ref bit [3:0] arr[16]);  // 4-bit array with 16 elements
    for ( int i=0; i< $size(arr); i++) begin
      arr[i] = i;
    end
  endfunction 
  
endmodule
