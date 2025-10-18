---
layout: ../../layouts/BaseLayout.astro
title: "my research"
date: "12.28.2024"
---
# Research ideas 

Formal verification is well known to be an intense task in the hardware design pipeline, taking up to 50% of the total design time (cite here).
In particular, the verification and testing of designs is a task typically taking place at the end of the compilation, with compiled designs consisting of
very big, detailed and low-level representations.
The size of these low-level representations make it hard to properly exploit formal methods for these tasks, as they tend to not scale well
with the size and complexity of modern hardware designs.
As hardware compilers shift towards the use of multiple IRs and lowering to compile a design (e.g. CIRCT), compilers generate
various representations after different lowering lowerings, representations which are immediately discarded.
We propose using these pieces of information to improve the scalability and usability of formal verification tooling for modern hardware design.

In particular, to make formal methods fully accessible from and embedded with the hardware design process, I will work on two complementary approaches.
*distributing the verification efforts along the compilation pipeline*w
We propose building a mapping between the semantics of the IRs
modern compilers rely on and formal verification tooling, e.g. by representing an IR operation as an operation on Bitvectors and transforming
the problem of verifying a property at a certain IR into a bitvector problem.
At this stage, it is very important to make sure that the semantics of the IRs is correctly encoded as something the formal verification tool can
easily digest, to make the verification effactive. In fact, if this mapping is naive, the solver might not be able to be efficient, as
our previous work on the verification of FSMs suggested.
*improving the efficiency and effectiveness of formal verification tooling*
Given the complexity of modern hardware designs and compilation toolchains, it is important to make sure that the solvers are effective and support numerous
data structures and decision procedures, to be capable of effectively reason about IRs representing different abstractions.

Overall, by tackling these two aspects, we will be able to (1) verify the correctness of the compiler, by reasoning about the semantics of different IRs,
(2) distribute the verification overhead along the entire compilation toolchain, making sure that properties are checked as the design is compiled,
exploiting the data the compiler would produce anyways, (3) decrease the overhead of bottom-line verification tooling, as the compiled design is partially
verified already.
