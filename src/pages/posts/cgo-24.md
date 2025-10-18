---
layout: ../../layouts/BaseLayout.astro
title: "cgo 2024"
date: "03.20.2024"
---
# CGO 2024

## M. O’Boyle Keynote, CC
- Compilers redux vs. End of Moore’s law, rough ~3.6% improvement
- Architecture can’t do it alone
- Idea: using FSM for compiler verification only? All dialects have lowering to FSM
- Compiler ~ Jenga
- HW-SW contract is breaking down → SW cant fit on new (heterogeneous) HW → rethink the contract
- Can compilers help as a DSL would? Without having programmers learn all DSL/manage translation etc→ ✨ABSTRACTION✨ → eg shift up x86 → openCL → clBLAS/Halide/…
- Target: nearer to algorithm, will always perform well BUT target is complex and changeable → solutions must work for all APIs → AUTOMATION
- IDEA: Lift code to API/DSL and THEN to HW
- Learn HW accelerator (grey-box program synthesis/infer program behaviour) and match SW
- Match libraries to legacy code automatically (neural classifier)
- Further: exploit domain knowledge with higher level abstractions (MLIR), multi-level tactics
- Neural decompilation
- Idea: generate a FSM testbench automatically with neural network/LLM?
- Inductive Oracle/Program Synthesis?
- Challenges: Scalability, Data, Accuracy (verification?), Explanation
- Idea: represent dataflow/control flow with FSMs?
- Semantic-based check can be very useful especially between IRs

## Albert Cohen Keynote, CC

- Abstractions are key for performances → lift the abstractions until sth we know (domain-wise) and enjoy the ride
- Reflective Programming must be domesticated → JAX
- Multi-stage programming: useful when we know the domain very well/have a plan/know optimisations in advance (AnyDSL, OOPSLA 2018) → manage partial evaluation (Cohen, SCP 2006) → Cross-stage persistence + macro expansion
- Autotuning on top of existing compilers (A flexible approach to autotuning, PACT 2021)
- Beyond: reinforcement learning for register allocation → open up compiler interface to make it suitable for production
- Guided metaprogramming → scheduling languages, split compilation
- IRDL
- Rethink/Reevaluate correctness requirements
- Idea: find problems FSMs can describe efficiently
- Testing methodologies → verification?

## Panel: Compilers and ML, CC

- Saman: compilers haven’t changed much in the last ~30y, although we have more computing power, better/faster algorithms and more data, neither of which we actually use. We should have:
    - CaaS: Compilation as a Service (processing power/accelerators/memory and storage)
    - Can we naively use ML? → Neural Machine Translation BUT no correctness guarantee
    - Centrally Collected Data for Continuous Improvement exploiting the usage information retrieved by CaaS (real data)
- Tobias: ML has a transformative impact on compilers, true or false? Compilers are pervasive across multiple domains → can we enable reuse? MLIR enables this → Multi-level rewriting: we broke compilers to pieces → bigger surface to retrieve data/information. Prolific areas for ML in compilers:
    - CompCERT → local verification of lowerings
    - Peephole Rewrites/Proof Synthesis?
    - ML-written automation support
    - Integrate performance models with ML?
- Hyesoon: before → lot of pre/post processing, today → chatGPT
- Fabrice: compilers for ML → yes, ML for compilers → lots of paper, but what about production compilers? Extend to:
    - Scientific computing
    - Generic compilers: pattern-spec embedded libraries
- Xipeng: LLM bridge semantic gap for compilers: high-level semantics is key → correctness challenges.
    - LLM: good at high-level code semantics, but lacks precision/scalability/detailed compiler knowledge
    - Compiler: precise, detailed transformations, but lacks high-level understanding and is easily blocked by ambiguities
    - LLM-compiler synergy: compiler-assisted LLM + LLM-assisted compiler → potential = find new optimisations/rewritings via math formulae
- Q: ML interpretability for correctness
- Q: security of cloud compilation?
- Q: avoid black-box → improve interaction with the compiler + need for safety → expose bigger surface? → no clear answer: embrace the dark side

## Amir Shaikhha - A Tensor Algebra Compiler for Sparse Differentiation

- Program = bottleneck between data and hardware
- Challenges for sparse differentiation: require control-flow constructs and are complicated
- There are a lot of sparse storage format
- Two levels of abstractions: logical (AD) + physical (compressed formats: expressive enough for the conversion)
- Semi-rings are cool and compositional → can be used as dictionaries to represent sparse matrices

## Katsumi Okuda - AskIt: Unified Programming Interface for Programming with Large Language Models

- Communication: program <- function call → program, human <-programming language → program, human <-natural language→ LLM-based system
- Question: program <-?→ LLM → use DSL for LLM as part of a program
- Emergent abilities of LLMs = directly answerable questions
- GPT-4 as a parser: make prompt → send prompt → extract result
- AskIt: define type → define function → call function
- Intersection of directly answerable tasks and codable tasks
- Programming interface to have LLMs and programmers interact easily with the program
- Does generated code improve performance? (GSM8K benchmark)? Yes
- Verification of results: no (AST), the generated programs are tested for correctness (test cases)

## Volker Seeker - Revealing Compiler Heuristic through Automated Discovery and Optimisation

- Motivation: compilers are great, but difficult to optimize → heuristics guide code optimizations, there are default optimizations settings
- Tuning heuristics is beneficial → ML-guided heuristic tuning
- impossible to find/tune manually everything, especially in large code bases which are constantly updated etc → automation: what to optimise wrt objectives → existing approaches:
    - iterative compilation
    - promising: RL, but only for exposed heuristics
- what they do: automatically find heuristics and expose them to attach tuning
- how to find heuristics: try to find one that validates the output, then explore the output semantics → possibly improved → differential testing
- both application and compiler optimization
- NAS, Polybench benchmark suite → identified different tuning targets for each benchmark (only individual) → Q: what is a tuning target/why some benchmarks have more?
- core: enable fine-grained ML tuning for compiler heuristics → not only compilers

## SLaDe

- Decompilation → considerable manual work and code is often mangled (e.g. Ghidra: produces hard to read code)
- Neural Decompilation: automated, trained on human-written code → readable
- BTC: code is plausible but incorrect, no correctness evaluation
- ChatGPT: readable, but incorrect
- Tradeoff: correctness vs. Readability → SLaDe is both
- small, specialised transformers have potential

## Jean-Michel Gorius - FSM verification

- preserve properties across automata transformations
- translation validation throughout the compilation flow
- verifying that hw is consistent with initial hypotheses

## Retargeting and Respecializing GPU Workloads for Performance Portability

- GPU optimisation → parallel semantics
- Synchronisation interaction → preserve barriers semantics → divergent control flow?
- thread coarsening → no barriers in divergent control flow → recursive interleaving→ always legal here
- Granularity of coarsening factor → finer granularity yields better results

## Computing Systems for the Foundation Model Era

- Provide scale and efficiency + achieve performance and programmability → vertically integrated solution: ML algorithms + dataflow compilers + reconfigurable dataflow architecture
- General purpose monolithic model vs. Hundreds of specialist models with automatic routing → smaller fine-tuned models are cheaper and sometimes better than large, generalist ones
- challenge: sparse training with accuracy and HW efficiency
- dataflow compilers: dataflow graph analysis is important → dataflow programming → optimisation by scheduling in space and time: fusion, tiling, pipelining → lower representation closer to hw (e.g. DSL called spatial, PLDI)
- reconfigurable dataflow architecture
