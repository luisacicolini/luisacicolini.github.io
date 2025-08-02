---
layout: ../../layouts/BaseLayout.astro
title: formal verification at higher levels of abstraction - d. kroening et al., 2007
---
- Algorithms that operate at the bit-level are unable to exploit the structure provided by the higher abstraction levels, and thus, are less scalable $\rightarrow$ high level models: (1) word-level verification with predicate abstraction and smt solvers, (2) term-level modeling and their combination for scalable verification 
- Abstraction techniques reduce the state space by mapping the set of states of the actual, concrete system to an abstract, and smaller, set of states in a way that preserves the relevant behaviors of the system $\rightarrow$ might be nice to have hierarchy in this?
- Capacity is the main challenge for formal verification tools. Given a high-level model, word-level reasoning can increase the capacity of formal verification tools significantly when compared to a net-list level tool. We discuss decision procedures (SMT solvers) for bit-vector arithmetic, and give an overview of predicate abstraction, a word-level assertion checking technique.
