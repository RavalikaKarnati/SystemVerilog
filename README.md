 **DESIGN:**      
_GUIDELINES FOR DESIGN:_    

**TESTBENCH:**     
_GUIDELINES FOR TESTBENCHES:_  
1. DUT inputs should always driven with **non-blocking assignments**. It is very common to assign an input in one process and monitor it another. If the assignment is blocking, then the monitor's behavior will vary depending on which process executes first.
2. when one process reads a value that a another process writes, and those processes are synchronized by a common event (e.g., a clock edge), the write should use a non-blocking assignment to avoid race conditions.
