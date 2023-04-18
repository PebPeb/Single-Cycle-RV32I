.. Single-Cycle-RV32I documentation master file, created by
   sphinx-quickstart on Sun Apr  9 09:28:01 2023.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Introduction
============

The Single-Cycle-RV32I is designed to be a staring point for people interested in getting into computer architecture. This project is one of my first attempt at designing a CPU with the intent to build off of it. This design is meant to build a better understanding of the RISC-V ISA and lead into more complicated designs.

This project assumes that the reader has a base line understanding of digital design. Familiarity with different hardware description languages specifically Verilog for this project would be helpful for the reader. 

This project implements majority of the instructions from the base integer instruction set from the RISC-V ISA. The project name follows the standard naming convention outlined in the RISC-V ISA. The RV stands for RISC-V followed by the width of the integer registers making this the 32-bit implementations of the base integer extension (I).

.. note::
   This project is under active development.

.. toctree::
   :maxdepth: 2
   :caption: Table of Contents

   Chapters/Chapter1