---
title: "LLVM-dev'26"
date: 2026-10-27
---

# Notes and thoughts at LLVM-dev'26

### The future of compilers in the age of AI -- a personal perspective

- The elephant in the room: will compilers be needed in the era of AI?
- An interesting analogy with nuclear energy, which went from from uncontrolled to controlled: vibe coding corresponds to the nuclear bomb (uncontrolled), can the goal (controlled, non polluting energy) correspond to agentic software?
- importance of design patterns for agentic software development
- Analogy with Daniel Kahneman's *thinking fast and slow*

| thinking fast  | thinking slow |
| ----------- | ----------- |
| biological brains | maths (euclid, ishango bone), machines |
| machines simulating DNNs | software (automate system2 thinking: compilers -> deterinistic), checkers, provers, etc | 
**thesis**: in the era of AI, the value of compilers is in the deterministic "slow" thinking that can constrain the LLM "fast" hallucinating mode, hence they will be more relevant.

- Is open source dead? The role of maintainers/open source: adapting specification, have a global view of what's happening, standardisation of spec 
- Risk: agents producing changes creates software debt, which can be
	- intent debt --> goals and constraint not captured 
	- cognitive debt --> code evolves faster than undetstanding 
	- can agents help address these debts 
- Reviewers play a "contributor poker": they invest today's review effort in tomorrow's contributors (teaching a newcomer)


### When The Compiler Owns Time: Compiling For Deterministic Spatial Hardware

- For an LPU chip (LPU = vector machine, 320 bytes): compiler emits exacty a plan --> compiler knows time, and knows how many cycles things take 
- There is no hardware in the loop: program --> compiler --> cycles 
- More accurate power models!
- Compiler manages data movement: things are loaded earlier because they are closer
- Performance is compiled: fixed latency of communication between chips


### A TableGen-based DSL for InstCombine	Technical Talk	

- Giving names to things is useful --> instrumentation can be more helpful to figure out what went wrong
- The vast majority of code should not match the vast majority of rules: we need to choose smart clusters of rules 
- Some weird rules prevent us from a 10x faster InstCombine: e.g. `hasOneUse`, `phi` nodes, and things that initiate matching generic things 



### RISCV Roundtable

- I did not know most of the RISCV folks and community and getting to know them was a highlight of LLVM-dev for me for their kindness, competence and inspiration :)
- It is still unclear where and how extensions are defined, and there are operations that live in multiple, different extensions ☹️

### Formal Specification Roundtable

- New features to llubi 
- Challenge: having enough infrastructure to describe what we want to describe 
- Figure out agreement and disagreement of tooling: can we do it in CI? Especially for people that want to start somewhere 
- LLVM FP compliance issues: standards are all over the place. Do we need a higher bar to change Langref? Being more explicit about what’s wrong in the langref e.g. if we don’t know how to fix it or how the right thing looks like? 
- It should be clearer in the Langref what are the things we are sure about 
- Example: loading `i16` from `i8`: what are the extra bits? Disagreement between the load semantics and frozen poison one 
- Discrepancy between formal beliefs and assumptions against implementation: it’s useful to have a prototype and figure out which things break what 

### Vectors' semantics

- Interesting RISCV ops : `vpmerge`, `getveclength`, `zip`, `vcompress`, contration
- Splice: permutations are hard 
- Is there something like shufflevec but for scalable vector?
- Splat form of scalable vector 
- Challenge: verification of permutations --> tracking where an element moves via indices or something? Arithmetic of where the source index was living?
- Vector contraction in 2 dimension to SMM*
- In MLIR: 2D vector is by default a struct of vectors
