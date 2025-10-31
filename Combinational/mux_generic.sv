`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2025 09:04:01 PM
// Design Name: 
// Module Name: mux_generic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Generic N-bit, M-to-1 Multiplexer
// fully synthesizable, parameterized implementation of an M-to-1 multiplexer for N-bit-wide data
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_generic
 #( parameter NUM_OF_INPUTS = 5,
    parameter INPUT_WIDTH = 4
  )
  (
    input logic [INPUT_WIDTH-1:0] a [NUM_OF_INPUTS-1:0],  // N-BIT WIDE VECTOR WITH DEPTH N
    input logic [$clog2(NUM_OF_INPUTS)-1:0] sel,
    output logic [INPUT_WIDTH-1:0] f  
  );

 // assign f = a[sel];   // synthesized as Mx1 mux - picture1 in mux_generic.md

 // Sythesized using 2x1 muxes - picture2 in mux_generic.md
  integer i;
  always @(*)  begin
    f = {INPUT_WIDTH{1'b0}};
    for (i=0; i< NUM_OF_INPUTS; i=i+1) begin
       if ( sel==i)
          f = a[i];
    end   
  end  
endmodule
