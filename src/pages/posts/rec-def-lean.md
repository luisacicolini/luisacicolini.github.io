---
layout: ../../layouts/BaseLayout.astro
title: "recursive definitions in lean - joachim breitner"
date: "08.15.2025"
---

- cool intro trick: ask questions to get a feeling of who's in the audience + remember to repeat questions
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

- Q: Knaster Tarski, proof irrelevance in the presentation, `partial_fixpoint`, monad