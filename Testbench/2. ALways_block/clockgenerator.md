<img width="1061" height="407" alt="image" src="https://github.com/user-attachments/assets/05e8d639-7d01-4dd4-a152-4b7b773a5cd3" />

Duty cycle =    Ton  / Ton + Toff  --> clock period   

if user specify Frequency and Duty Cycle --> two parameters which are utilized to generate clock
third parameter is phase difference if there are two or more clocks.

Clock Period (S) = 1 / Frequency ( Hz) --> convert to ns based on `timescale 1ns/1ns
 real period --> nsec
 real Dutycycle --> 0.5, 0.6 
 real Ton = period * Duty Cycle
 real Toff = period - Ton
