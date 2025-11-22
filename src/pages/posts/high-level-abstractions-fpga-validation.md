---
layout: ../../layouts/BaseLayout.astro
title: "high-level abstractions and modular debugging for FPGA design validation"
date: "11.30.2023"
---
# [high-level abstractions and modular debugging for fpga design validation](https://dl.acm.org/doi/pdf/10.1145/2567662)
a paper by y. iskander, c. patterson, s. craven

The developed approach provides two means of directly validating synthesized hardware designs.
The first allows the original high-level model written in C or C++ to be directly coupled to the synthesized hardware, abstracting away the traditional gate-level view of designs. 
A high-level programmatic interface allows the synthesized design to be validated directly by the software reference model. 
The second approach provides an alternative view to FPGAs within the scope of a traditional software debugger. 
This debug framework leverages partially reconfigurable regions to accelerate the modification of dynamic, software-like breakpoints for low-level analysis and provides a automatable, scriptable, command-line interface directly to a running design on an FPGA.
