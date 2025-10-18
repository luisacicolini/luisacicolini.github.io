---
layout: ../../layouts/BaseLayout.astro
title: "semantics for hardware design"
date: "02.28.2024"
---
example of how hardware abstractons' semantics is extracted.

- Design2Vec, a deep architecture that learns emantic abstractions of hardware designs
- RTL designs are typically simulated using an RTL design simulator, which does not suffice for the design goals of our analysis. For use with machine learning, we choose to represent RTL as a control data flow graph (CDFG). The CDFG we construct for each Verilog RTL program encodes the program’s simulation semantics, so that our models may make inferences about the their behavior

