---
layout: ../../layouts/BaseLayout.astro
title: "what are the semantics of hardware"
date: "10.30.2023"

---
# [what are the semantics of hardware](https://capra.cs.cornell.edu/latte21/paper/19.pdf)
- We propose an endeavor to formalize and relate each level of semantics using abstract interpretation.
- There are at least three major points of view on implementing interpreters/simulators. If the language resembles sequential code (e.g. HLS), then the host software-language semantics are often appealed to. In functional HDLs, some dataflow interpretation[ 15 ] is commonly used. Verilog itself uses a form of event-based simu- lation that resembles dataflow[ 1 ]. Lastly, many high-performance simulators flatten module hierarchy, eliminate loops by breaking the circuit at registers, and compile a single transition function for updating the state at each synchronous clock.
- the dataflow point of view (which is the most similar to our proposal) does not handle combinational loops and other lower-level aspects of hardware simulation
- Our idea is to use the theoretical framework of Abstract Interpre- tation [7] to define semantics, and therefore reference interpreters, for HDLs at multiple levels of Abstraction
- New “just-in-time” [19 ] or distributed simulation methods pro-pose to separately compile parts of circuits that must then “synchro-nize” or converge via communication. The fix-point formulationof semantics clarifies the conditions under which such simulationsconverge to a unique solution.
