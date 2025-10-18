---
layout: ../../layouts/BaseLayout.astro
title: "big spec 2025"
---

## Sandrine Blazy - Some challenges and work in progress in verified compilation of realistic languages

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
- question: why do we have to write induction by hand?

## Alastair Reid - Engineering large, multipurpose microprocessor specifications (using the x86-64 architecture as a case study)

- Reid, Who guards the guards (oopsla 2017)

## Anna Slobodova, Micro-architectural modelling and verification of an x86 micro-processor

- actual microarchitecture → parallel decoding, reordering, parallel exec, speculation, deep pipeline, several levels of caches, multiple copies of state elements, complicated power management, focus: verification of execution clusters
- goal: complete verification of all micro ops in EXE (int, log, vec, fp) with minimal assumptions, power management, deep pipelining, design-for-test features
- ACL2 with built-in automation tools, $\subset$ LISP, open source, executable, efficient, well documented, versatile, extensible, experts available
- requirements: formalism that allows fast model build → SV to FSM, extensibility, easy decomposition → CIRCT has them all (claim on easy decomposition → implement product and such)
- systemVerilog → SVEX + SVTV → framework to define, unroll, evaluate FSMs, translate everything into FSMs and then use that
- specialized rewriter for multipliers

# (my own) random thoughts and ideas 

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
