---
layout: ../../layouts/BaseLayout.astro
title: dept. seminars
---
## 24.05.24 Lizy John: HW design with/for ML

- Exploit SW optimization first
- Add hard matrix multiplier blocks to FPGA → how many? trade off: small area 3-5% (“Tensor Slices”) doubles the throughput for ML applications, w\out increasing the overall area, no extra general purpose connection required, no slowdown in non-ML benchmarks
- Add compute in RAMs: improvement with +3% extra hw → reduction in data movement
- Weightless NN have potential
- ML for performance modeling: (1) calibration of power models using ML → McPAT, simulator to model machines that do not exist yet
- Interest in ML-guided HW design → Computer Architecture 2.0, e.g. ML-based branch predictors?

## 15.08.25 Joachim Breitner - Recursive Definitions in LEAN 

- cool intro: ask questions to get a feeling of who's in the audience + remember to repeat questions
- Lean = theorem proving + writing code 
- kernel: only check the proof term -> we can see these proof terms.
> the kernel does not have recursion and will reject defs that are recursive
if it supported recursion, it would break logic soundness: 
```lean
simple_def reallyBad : forall {P : Prop}, P := reallyBad
theorem pipi : 3*3 = 6 := reallyBad
```
- but of course we want recursion! so Lean provides *recursors*
- `#guard_msg` compares the output with the previous message, allows for basic testing. 
- `#reduce fun n => something n` : this is how we make the kernel accept `something` that is a recursive definition. 
we tell the kernel that we have a new type and when its logic is added to the kernel, the kernel knows it. 
- compiler perf behaves the way we write it, run time can blow up :( e.g. predecessor function 
- the `recursor` basically transforms what we write as a recursive definition into something that is 
not recursive for the kernel to digest. `.below` tracks the values defined already, and also this 
is designed such that reductions still work nicely. 
- reading suggestion: [a few constructions on constructors](https://research-portal.st-andrews.ac.uk/en/publications/a-few-constructions-on-constructors)
- [trampolines](https://hackernoon.com/on-recursion-and-trampolining-uxf3tvx)
more complex recursive functions: e.g. `ackermann` function
- well founded rec is stronger than struct, bu twhy would we use struct rec? because 
(1) it does not ask for explicit proof
(2) it enables good kernel reduction behaviour, which is useful for types definition and kernel computation (e.g. `rfl`, `bv_decide`)
-> connection to proof irrelevance?
- problem: how do we make sure that our proof means *actually* what we mean? always a problem in ITP!
```lean 
theorem sum_of_n (n : Nat):
    (List.range (n + 1)).reverse.sum = n * (n + 1) / 2 := by 
    induction n with
    | zero => rfl 
    | succ k ih => 
        rw [List.range_succ]
        simp [ih, Nat.mul_add, Nat.add_mul]
        omega 
#check sum_of_n -- shows the actual proof term
```

- questions: Knaster Tarski, proof irrelevance in the presentation, `partial_fixpoint`