`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2025 10:09:35 PM
// Design Name: 
// Module Name: mux_generic_1bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_generic_1bit
  #(parameter NUM_OF_INPUTS = 5)
  (
    input logic [NUM_OF_INPUTS-1:0] a,
    input logic [$clog2(NUM_OF_INPUTS)-1:0] sel,
    output logic  f
  );
  
  
  integer i;
  always @(a,sel)  begin
    f = 1'bx;
    for (i=0; i< NUM_OF_INPUTS; i=i+1) begin
       if ( i==sel)
          f = a[i];
    end   
  end  
endmodule
