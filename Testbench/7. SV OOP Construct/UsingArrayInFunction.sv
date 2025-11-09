

module tb;

  bit [3:0] res_arr[16];
  function automatic void init_arr( ref bit [3:0] arr[16]);  // 4-bit array with 16 elements
    for ( int i=0; i< $size(arr); i++) begin
      arr[i] = i;
    end
  endfunction 

  initial begin
    init_arr(res_arr);
    for (int i=0; i< $size(res_arr), i++) begin
      $display("res_arr[%0d] : %0d", i,res_arr[i]);
    end
  end
  
endmodule
