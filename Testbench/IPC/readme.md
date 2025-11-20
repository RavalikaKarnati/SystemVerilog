**INTER PROCESS COMMUNICATION:**     

**EVENT:** Used to convey a message between different classes. For Instance, thera is a generator class, and then a user has requested to generate end stimulus, after generation of an end stimulus is finished, we want to send the message that we have finished
generating the stimulus, and now the class could forcefully stop the simulation. In that case, we could use an event.    
1. Trigger an event (-->)   
2. Edge Operator (@)   
3. Level operation (wait)    

**SEMAPHORE:** used to access certain resources in a SystemVerilog testbench top. So the most common example of a semaphore is to access an interface. Another example you have one data source where multiple classes want to add the data. In that case, you could also use a semaphore,
Mostly, we use it for sharing an interface between multiple classes.     
1. get    
2. put    
The "get method" specifies how a specific class receives a semaphore so that it can access a resource, and then once it completes its operation, how you put back or release the semaphore, for that, we have a put method

**MAILBOX:** the primary purpose is to send data, specifically transaction data, between classes. For instance, When a generator will be generating transaction data, which will be sent to a driver, and then finally, the driver will apply it to the DUT with the help of an interface. To communicate the data of a transaction between the generator and driver, we use a mailbox.    
Similarly, when we receive the response of a DUT in a monitor, we send it to a scoreboard. the data between the monitor and scoreboard is also sent with the help of a mailbox.     
1. Blocking methods: This means if we use the put method, until we successfully send the data, we won’t proceed to the next statement. Similarly, get means until we receive the data from a class, we won’t move on to the next statement  
2. Non-Blocking Methods: try_get and try_put
