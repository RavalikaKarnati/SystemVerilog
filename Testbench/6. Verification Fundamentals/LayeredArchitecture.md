**Layered Testbench Architetcure**
<img width="1210" height="666" alt="image" src="https://github.com/user-attachments/assets/71f900b4-637b-449f-acee-4da9ede3dc23" />

**Layer1: Signal Layer** : Containes signals or ports that are coming from DUT --> TB and from TB to DUT   

We have two paths from here. 
- Path1. Applying stimuli to DUT    
- Path2. Receive response from DUT and compare with the golden data ( when we consider the DUT, we have a set of data that we are expecting for a given set of stimuli. This is what we refer                                            to as golden data. So, once we apply stimuli, our agenda will also be to receive the response from the DUT and then compare it with the golden data) 
                             
**Layer2: Command Layer**:  
- Path1. convert an individual command received from upper layer into specific signals the DUT understands. 
       - Eg: Driver : Driver represents one of the classes from TB and DUT has series of signals. How class --> signals communicate? Using Interface, **driver applies stimuli to the DUT is with the help of an                          interface**. The interface provides us access to the signals of a DUT for the class-based component  
- Path2. convert the response from DUT to individual command that upper layer understands  
       - Eg: Monitor: Monitor represents one of the classes from TB and DUT has series of signals. How class --> signals communicate? Using Interface, **Monitor recives the response from the DUT with the help of an                    interface**. The interface provides us access to the signals of a DUT for the class-based component  

**Layer3: Functional Layer**: 
- Path1. This layer will receive multiple commands (stimuli) and schedule which command (stimuli) to be sent to the DUT or the next layer based on the specific feature we are verifiying or testing 
- Path2: it receives individual commands from a lower layer and then combines them as multiple commands to generate the sequence that could be sent to the next layer, where we will be comparing it with golden data  
                              

**Layer4: Scenerio layer**: Generate sequences to be sent as stimuli to DUT + check the response we get from DUT against golden data   

**Layer5: Test or TB_TOP Layer**: Hold/control simulation until we apply all the stimuli to the DUT for verifying a specific feature and also verify the data or responses that we receive from the DUT against the golden data 


<img width="411" height="286" alt="image" src="https://github.com/user-attachments/assets/ce91f9d1-676d-4b72-9c19-b49bbfc7d926" />


**INTERFACE**: Interface provides access to the signals of a DUT for the class-based component  
**INTER PROCESS COMMUNICATION (IPC)**: Interprocess communication allows us to communicate the data between the classes   
                                   Eg: SEMAPHORE, MAILBOXES, EVENTS   

**ENVIRONMENT**: Instead of having all of these components in a testbench top, we will utilize the environment class as a container where we add the generator, driver, scoreboard, and monitor and then we will finally utilize the environment object in the testbench top. Then, at the top, we just need to create an instance of the environment class and execute the process that we have in the environment class.

![IMG_2057](https://github.com/user-attachments/assets/8e3b3665-583f-44bb-991d-b9e51da1ff64)

![IMG_2058](https://github.com/user-attachments/assets/8e400f42-83ee-40c0-8127-674bd120ce87)




