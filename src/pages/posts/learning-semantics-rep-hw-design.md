---
layout: ../../layouts/BaseLayout.astro
title: "learning semantic representations to verify hardware designs"
date: "02.28.2024"
---
# [learning semantic representations to verify hardware designs](https://proceedings.neurips.cc/paper/2021/hash/c5aa65949d20f6b20e1a922c13d974e7-Abstract.html)
### a paper by s. vasudevan, w.j. jiang, d. bieber, r. singh, c.r. ho, c. sutton

- example of how hardware abstractons' semantics is extracted.
- Design2Vec, a deep architecture that learns emantic abstractions of hardware designs
- RTL designs are typically simulated using an RTL design simulator, which does not suffice for the design goals of our analysis. For use with machine learning, we choose to represent RTL as a control data flow graph (CDFG). The CDFG we construct for each Verilog RTL program encodes the program’s simulation semantics, so that our models may make inferences about the their behavior

