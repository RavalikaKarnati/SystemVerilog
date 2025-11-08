How we use arrays in SystemVerilog?

<img width="411" height="286" alt="image" src="https://github.com/user-attachments/assets/6d524cfc-ba39-483b-b129-7de5fa97feb7" />

For testing the DUT, we will be generating a number of stimuli (Generator), that will be sent to the driver and then finally applied to the DUT. Then the monitor will collect the response from the DUT, and all the responses that we have for all the multiple stimuli that the generator generates will be collected in a scoreboard.  

So for each unique transaction in the generator will be applied to the DUT, and then it will be stored in a scoreboard, which could be further compared with golden data
To collect the multiple transactions of the same type, we need to have an array,
