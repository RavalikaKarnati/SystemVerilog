 **DESIGN:**      
_GUIDELINES FOR DESIGN:_  
1. Ideally, we have to write Verilog/SystemVerilog code whose behavior remains consistent, regardless of the simulation order
2. // SYNTHESIS GUIDELINE FOR COMBINATIONAL LOGIC: Make sure that every path through the block defines every output and internal signal.
3. Only use blocking assignments for combinational logic.

**TESTBENCH:**     
_GUIDELINES FOR TESTBENCHES:_  
1. When writing a testbench, all assignments to the DUT inputs should always driven with **non-blocking assignments**. It is very common to assign an input in one process and monitor it another. If the assignment is blocking, then the monitor's behavior will vary depending on which process executes first. If non-blocking asiignments are used, Although the simulator may execute the assignments at different times, their values are only applied at the end of the time step. Therefore, within a single time step, all processes will read the same value, regardless of the simulation order.     
2. when one process reads a value that a another process writes, and those processes are synchronized by a common event (e.g., a clock edge), the write should use a non-blocking assignment to avoid race conditions.
3. Reference from :   https://stitt-hub.com/race-conditions-the-root-of-all-verilog-evil/ 

