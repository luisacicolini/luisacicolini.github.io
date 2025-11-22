---
layout: ../../layouts/BaseLayout.astro
title: "the essence of bluespec"
date: "03.20.2024"
---

# [the essence of bluespec](https://dl.acm.org/doi/pdf/10.1145/3385412.3385965)
a paper by t. bourgeat, c. pit-claudel, a. chlipala, arvind

A work so beautiful and clean that I somehow wish I had written it!

- The commercial BSV compiler relies on a static analysis to do ORAAT-preserving concurrent scheduling of rules. Its static analysis, combined with user-provided annotations (e.g. descending urgency and execution order), generally creates excellent circuits. This approach, however, is not sat- isfactory for two reasons. (1) The static analysis should be an abstraction of the dynamic semantics of a program. BSV’s dynamic semantics applies only to one-rule-at-a-time execu- tions, and the cycle-level semantics necessarily depends on the static analysis of rules. (2) BSV programmers often think deliberately about static-analysis details and even change their code to nudge the compiler in the right direction to achieve the desired degree of concurrency.
- Traditional HDLs like Verilog and VHDL are structural in the sense that they describe interconnections of boxes, i.e., Boolean gates and registers. The main problem with such languages is that they provide inadequate type checking and lack precise semantics, which makes verification and design refinement a Herculean task.
- A cycle-accurate description is essential to understand the performance of a hardware circuit. Such descriptions, how- ever, often complicate reasoning about functional proper- ties of the hardware. 

insight: very useful related work section, gives tons of interesting facts about pros and cons of different approaches and highlights their shortcomings. 
idea: abstract interpretation for more efficient simulation and verification starting from the definition of circt dialects' semantics. in lean4. 
