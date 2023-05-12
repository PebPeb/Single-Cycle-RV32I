.. ------- Meta Data ------------

:github_url: https://github.com/PebPeb/Single-Cycle-RV32I

.. ------------------------------


=================
2. Design Choices
=================

This chapter plans to cover the design choices of the CPU. There are many different variables to take into account when 
approaching this project. I hope to explain why I made my decisions, and the attended outcome of the design.

.. note::
   This project is under active development.

----------
2.1 RISC-V
----------

Why RISC-V? I did a lot of research on different ISAs before staring this project, and RISC-V seemed to be the most 
optimal choice. 

^^^^^^^^^^^^^^^^^^^^
2.1.1 RISC Over CISC
^^^^^^^^^^^^^^^^^^^^

A reduced instruction set computer or RISC for short is a computer that is designed to take a simplified set of individual 
instruction rather than a large set of instructions. Opting for more code in some cases to accomplish a task rather than 
having a specific instruction for that task. This can lead to a vastly more simple ISAs with RISC-V only having 47 
instructions apart of the base 32-bit integer extension.

Before talking about why selecting a RISC ISA for this project we need to talk about the alternative option. A complex 
instruction set computer or CISC for short is a computer that is designed to minimize the number of instructions required to 
perform a task. This leads to a more robust ISA that includes more highly specific instructions, just the original x86 
processor itself had about 117 instructions. Since the first x86 computer the instruction set has grown significantly 
adding over a few hundred instruction to the instruction set.

This makes it a pretty clear option as an independent developer a RISC architecture is the way to go if I have any 
hope of implementing the full functionality of the ISA. Keeping the instruction set minimum will help lower the 
complexity over all.

^^^^^^^^^^^^^^^^^
2.1.2 Open Source
^^^^^^^^^^^^^^^^^

In my research one of the most important points was that the ISA had to be open source. As I indent on building off of 
this platform and seeing were this grows I did not want to have to worry about limiting my exploration because some 
company is angry I am using there IP. 

I am a big advocated to open source projects, and i believe a lot of competition and innovation come from such projects. 
Though in the world of computer architecture there seems to be a steep entry cost for anyone looking to get into it. 
I think an ISA like RISC-V is what the open source community needs to lower the entry point for innovation outside of 
industry for computer architecture.

^^^^^^^^^^^^^^^
2.1.3 Relevance
^^^^^^^^^^^^^^^

One of the biggest things that irks me today is the use of irrelevant instruction sets for teaching. I understand many 
of these instruction sets have been around for very long and we can learn a lot from them. Though to the average 
engineer you are not going to have to dive deep into the understanding of the ISA. Using an instruction set that is 
still relevant in industry is killing two birds with one stone.

A 8-bit architecture would probably be a lot easier than starting with an 32-bit though in todays day an age it is 
hard to find a relevant 8-bit architecture outside of the embedded realm. With the release of new RISC-V single board 
computers running linux it is proof that the technology has a chance. Making RISC-V more relevant than ever and 
not a waste to learn. 

---------------------
2.2 Microarchitecture
---------------------

For this project I opted for a Harvard architecture to simplify the states of my computer. Though a Von Neumann 
architecture is a more accurate representation of modern day computers. I thing conceptually limiting the number 
of states of the computer helps easy the learning experience. 

^^^^^^^^^^^^^^^^^^
2.2.1 Single Cycle
^^^^^^^^^^^^^^^^^^

My design is an implementation of a single cycle CPU. Combined with the Harvard architecture I am able to limit 
my states of my computer to just one. Overall making starting out processing instructions a lot simpler. 

Another reason I selected the the single cycle CPU as my microarchitecture is how directional the flow of the 
processor is. It is very easy to conceptualize the design like reading a book with the data flowing from left 
to right. This concept seems a little easier to grasp than different states having to share a bus (this is just 
my opinion starting out). 

Below is datapath for my CPU. Looking at the diagram you can conceptually see the direction of data flow. Starting 
at the left and slowly making its way to the right of the design eventually looping back.

.. figure:: ../assets/Single_Cycle_RV32I_v0.0.3.png

    RISC-V Single Cycle Datapath