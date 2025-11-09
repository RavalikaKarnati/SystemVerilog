**Layered Testbench Architetcure**
<img width="1210" height="666" alt="image" src="https://github.com/user-attachments/assets/71f900b4-637b-449f-acee-4da9ede3dc23" />

**Layer1: Signal Layer** : Containes signals or ports that are coming from DUT --> TB and from TB to DUT   

We have two paths from here. Path1. Applying stimuli to DUT    
                             Path2. Receive response from DUT and compare with the golden data ( when we consider the DUT, we have a set of data that we are expecting for a given set of stimuli. This is what we refer                                            to as golden data. So, once we apply stimuli, our agenda will also be to receive the response from the DUT and then compare it with the golden data) 
                             
**Layer2: Command Layer**:   Path1. convert an individual command received from upper layer into specific signals the DUT understands.  
                             Path2. convert the response from DUT to individual command that upper layer understands  

**Layer3: Functional Layer**: Path1. This layer will receive multiple commands (stimuli) and schedule which command (stimuli) to be sent to the DUT or the next layer based on the specific feature we are verifiying or                                             testing 
                              Path2: it receives individual commands from a lower layer and then combines them as multiple commands to generate the sequence that could be sent to the next layer, where we will be comparing                                        it with golden data  

**Layer4: Scenerio layer**: Generate sequences to be sent as stimuli to DUT + check the response we get from DUT against golden data   

**Layer5: Test Layer**: Hold/control simulation until we apply all the stimuli to the DUT for verifying a specific feature and also verify the data or responses that we receive from the DUT against the golden data 

![IMG_2057](https://github.com/user-attachments/assets/8e3b3665-583f-44bb-991d-b9e51da1ff64)


