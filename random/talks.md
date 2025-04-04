
# CGO 2024

## CGO, 020324, M. O’Boyle Keynote, CC

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

## CGO, 030324, Albert Cohen Keynote, CC

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

## CGO, 030324, Panel: Compilers and ML, CC

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

## CGO24, Amir Shaikhha - A Tensor Algebra Compiler for Sparse Differentiation

- Program = bottleneck between data and hardware
- Challenges for sparse differentiation: require control-flow constructs and are complicated
- There are a lot of sparse storage format
- Two levels of abstractions: logical (AD) + physical (compressed formats: expressive enough for the conversion)
- Semi-rings are cool and compositional → can be used as dictionaries to represent sparse matrices

## CGO24, Katsumi Okuda - AskIt: Unified Programming Interface for Programming with Large Language Models

- Communication: program <- function call → program, human <-programming language → program, human <-natural language→ LLM-based system
- Question: program <-?→ LLM → use DSL to:
    - LLM as part of a program
    - ???
- Emergent abilities of LLMs = directly answerable questions
- GPT-4 as a parser: make prompt → send prompt → extract result
- AskIt: define type → define function → call function
- Intersection of directly answerable tasks and codable tasks
- Programming interface to have LLMs and programmers interact easily with the program
- Does generated code improve performance? (GSM8K benchmark)? Yes
- Verification of results: no (AST), the generated programs are tested for correctness (test cases)

## CGO24 Volker Seeker - Revealing Compiler Heuristic through Automated Discovery and Optimisation

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

## CGO24 SLaDe

- Decompilation → considerable manual work and code is often mangled (e.g. Ghidra: produces hard to read code)
- Neural Decompilation: automated, trained on human-written code → readable
- BTC: code is plausible but incorrect, no correctness evaluation
- ChatGPT: readable, but incorrect
- Tradeoff: correctness vs. Readability → SLaDe is both
- small, specialised transformers have potential

## CGO24 Jean-Michel G.

- preserve properties across automata transformations
- translation validation throughout the compilation flow
- verifying that hw is consistent with initial hypotheses

## CGO24 Retargeting and Respecializing GPU Workloads for Performance Portability

- GPU optimisation → parallel semantics
- Synchronisation interaction → preserve barriers semantics → divergent control flow?
- thread coarsening → no barriers in divergent control flow → recursive interleaving→ always legal here
- Granularity of coarsening factor → finer granularity yields better results

## CGO24 Computing Systems for the Foundation Model Era

- Provide scale and efficiency + achieve performance and programmability → vertically integrated solution: ML algorithms + dataflow compilers + reconfigurable dataflow architecture
- General purpose monolithic model vs. Hundreds of specialist models with automatic routing → smaller fine-tuned models are cheaper and sometimes better than large, generalist ones
- challenge: sparse training with accuracy and HW efficiency
- dataflow compilers: dataflow graph analysis is important → dataflow programming → optimisation by scheduling in space and time: fusion, tiling, pipelining → lower representation closer to hw (e.g. DSL called spatial, PLDI)
- reconfigurable dataflow architecture

# Dept. Seminars

## 240524 Lizy John HW design with/for ML

- Exploit SW optimization first
- Add hard matrix multiplier blocks to FPGA → how many? trade off: small area 3-5% (“Tensor Slices”) doubles the throughput for ML applications, w\out increasing the overall area, no extra general purpose connection required, no slowdown in non-ML benchmarks
- Add compute in RAMs: improvement with +3% extra hw → reduction in data movement
- Weightless NN have potential
- ML for performance modeling: (1) calibration of power models using ML → McPAT, simulator to model machines that do not exist yet
- Interest in ML-guided HW design → Computer Architecture 2.0, e.g. ML-based branch predictors?

# PLDI 2024

## SOAP24 Recent Advances in Floating-point (Static) Analyses

## PLDI24 SpEQ: Translation of Sparse Codes using Equivalences

- Nasa Parallel Benchmarks!!
- verify sparsity → equivalence check between dense and compressed = precondition for sparsity over input data → stuttering bisimulation
- semantics is important and can be an interesting proxy for optimizations

## PLDI24 Compiling with Abstract Interpretation

- ai framework for compilation + use comp result to improve ai
- ai = combine multiple analyses to collaborate/increase precision → can it be used for transformations?
- free algebra domains generate programs as analysis result + domain functors for comp passes + online comp to SSA
- ai: propagate analysis until fixed point

## PLDI24 Towards Trustworthy Automated Program Verifiers: Formally Validating Translations into an Intermediate Verification Language

- soundness of intermediate verification language program = frontend + backend
- frontend soundness: ivl correct ⇒ backend correct
- pb: no formal guarantees on implementations in practice + nontrivial implementations
- cont: simulation methodology for source and ivl + certifying adaptation of viper-to-boogie translation
- very interesting choice of ordering: first cont + results then challenges
- ch1: semantic gap viper-boogie
- ch2: diversity
- ch3: non locality
- pb: relating viper method and boogie procedure → p simulates m = decompose simulation into small semantic concerns + tactics for simulation of resulting concerns

## PLDI24 Verified Extraction from Coq to OCaml

- hand writing = control of optimization + bugs
- solution: high level languages
- pb: verifying aggressively opt compilers is very hard
- first work: 2 stage compiler for hig level func lang + combinators to tinker with lowerl level details = verified
- now the lowering algo is verified
- reshape operators (invertible) → rewrite framework exploiting verified equivalences

## PLDI24 Yann

- compcert -drtl
- vericert -dgblpar -dgblseq

## PLDI24 Hyper Hoare Logic: (Dis-)Proving Program Hyperproperties
https://pldi24.sigplan.org/program/program-pldi-2024?past=Show%20upcoming%20events%20only#

## PLDI24

- demanded abstract interpretation graph

# Big Specification

## BigSpec24

- christopher pulte, ben simner, catalin hritcu, michael sammler
- what’s special about hypervisors verification?
- back to the building blocks (white house paper?)

## BigSpec24 Sandrine Blazy - Some challenges and work in progress in verified compilation of realistic languages

- many intermediate languages (IRs) necessary to verify compilers (eg compcert) → IR design is important
- simulation diagram = standard technique, target program has less behaviors
- stutterings??
- pb: define invariants and measures between source and target → no standard procedure, depends on the languages
- small step semantics → model diverging executions
- with continuations : using induction in Cocq
- mechanized operational semantics
- rtl verification backends: compcert gsa, vericert icl, fm jit, chamois uga
- interesting related projects: verasco abstract interpreter, vst separation logic (gillian-c, verifast), certicoq, compcerto, l2c, velus, probcompcert
- Q: how do you test semantics?
- IR design: testing semantics → compcert has an interpreter for the source lang to test semantics on some programs → eg functions shared by semantics and intepreters
- open projects:
    - IR for Catala (DSL to describe law)
    - IR for dataflow circuits (Tony Law) → intermediate languages (one for compiler toolchain: graph with components + one for inductively defined lang to reasone more easily and show determinacy of circuit executions → semantically equivalent)
        - component: independent CU, consumes/produces tokens, async connection, may be stateful
        - channel,: transfer token, unbounded queue
        - semantics: execute anything that has enough inputs, scheduling is implementation dependent → semantics is independent of scheduling, dynamic scheduling = execution only constrained by availability of input data
- why do we have to write induction by hand?

## BigSpec24 Alastair Reid - Engineering large, multipurpose microprocessor specifications (using the x86-64 architecture as a case study)

- Reid, Who guards the guards (oopsla 2017)

## BigSpec24 Anna Slobodova, Micro-architectural modelling and verification of an x86 micro-processor

- actual microarchitecture → parallel decoding, reordering, parallel exec, speculation, deep pipeline, several levels of caches, multiple copies of state elements, complicated power management, focus: verification of execution clusters
- goal: complete verification of all micro ops in EXE (int, log, vec, fp) with minimal assumptions, power management, deep pipelining, design-for-test features
- ACL2 with built-in automation tools, $\subset$ LISP, open source, executable, efficient, well documented, versatile, extensible, experts available
- requirements: formalism that allows fast model build → SV to FSM, extensibility, easy decomposition → CIRCT has them all (claim on easy decomposition → implement product and such)
- systemVerilog → SVEX + SVTV → framework to define, unroll, evaluate FSMs, translate everything into FSMs and then use that
- specialized rewriter for multipliers

# random thoughts and ideas

- a compositional approach to hardware verification exploiting high level abstractions (dialects) for progressive and verified lowering, using fsms as a proxy to represent dialects' semantics, based on the assumption that the automata-theoretic approach is better than the logic one (in this specific case? in general? based on what?).
- so for example a problem with logic representation is that it scales quite poorly with the number of variables involved
- a decision procedure such as the one we have already is easily extensible to multiple variables? 
- the key difference between the two approaches is that for the logic formulae we need to use smt solvers, which are typically very good under very constrained circumstances (e.g. fsm x chc), instead when we have an automaton we can "just" explore the automaton and use some heuristics to optimize its exploration and prune the state space. which solvers do too so idk if there's a real benefit in there. but certainly representing things as automata is easier than massaging an smt formula. 
- in theory we can use automatic structures on domains that are broader than bool, although i suppose their complexity scales quite poorly. 
- Things we want to say and do over the three years: 
    (1) formalize high level abstractions as FSMs (papers on how to use FSMs to represent dataflow? requires representing actual handshake)
    (2) extend fsm dialect to represent buechi automata 
    (3) reason about designs in terms of omega-languages, ltl and ctl
    (4) make verification of designs modular and prpogressive as the design becomes more complex.
- there are three fundamentally equivalent ways to analyze a program and verify it: automata-theoretic approach, logic approach, abstract interpretation. we can move between the three, but beign able to exploit their characteristics and differences to perform and optimize different analyses could make our life esier. automata are good for (1) temporal logic stuff and (2) concurrent designs etc, so how am i planning to use this in a compiler thingy? in hardware modeling ltl stuff is useful! but here we're talking about compilers? 
- can fsms help in modeling the gray area between dataflow and rtl?
- fsms are good for LTL and temporal logic. we already have smt for model checking. for temporal properties (which, crucially, are very important for hw) buechi automata are our best shot. integrating BA in circt would give us another very powerful tool for verification, complementing the work that is currently being done with smt but with a focus on temporal (modal?) logics. having this in a framework that is by design modular and reusability oriented is a great comb because we can exploit all the algorithms that enable to easily manipulate automata (a well scope and known problem) and this would make our life easier. furthermore, if we encode the so-obtained automata in an it such as lean, we might even get the additional benefit that we can reason about it, write theorems,  prove the lowering correct. 
- dialects semantics is just a sequence of operations really. can we encode that in some sort of automaton like the ones we have for bitvectors? 
- itps can be a game changer in (1) the progressive verificat on of hw designs and (2) the verification of lowerings and optimization sin compilers
- buechi automata as an easier interface to reason about ltl properties on the design?
- does it make sense to use buechi automata to reason about ?


