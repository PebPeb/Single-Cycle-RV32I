.. ------- Meta Data ------------

:github_url: https://github.com/PebPeb/Single-Cycle-RV32I

.. ------------------------------


===============
1. Introduction
===============

The Single-Cycle-RV32I is designed to be a staring point for people interested in getting into computer architecture. 
This project is one of my first attempt at designing a CPU with the intent to build off of it. This design is meant 
to build a better understanding of the RISC-V ISA and lead into more complicated designs.

This project assumes that the reader has a base line understanding of digital design. Familiarity with different 
hardware description languages specifically Verilog for this project would be helpful for the reader. 

This project implements majority of the instructions from the base integer instruction set from the RISC-V ISA. The project 
name follows the standard naming convention outlined in the RISC-V ISA. The RV stands for RISC-V followed by the width of 
the integer registers making this the 32-bit implementations of the base integer extension (I).

.. note::
   This project is under active development.

--------------
What to Expect
--------------

What should you expect when reading this documentation? I plan to outline the functionality of my specific implementation 
of the RISC-V instruction set. There are many different ways to do this, but I did it the easiest way I could thing of. 
Hints why I recommend this just as a beginner project. 


.. figure:: assets/Single_Cycle_RV32I_v0.0.3.png
   
   RISC-V Single Cycle Datapath


Another goal of this project is for me to get a lot more experience with writing. Not only on the technical side of 
writing but also the educational side as well. As it is important to me that this project be used by beginners.