---
layout: ../../layouts/BaseLayout.astro
title: "recursive definitions in lean - joachim breitner"
date: "08.15.2025"
---

# recursive definitions in lean

*the kernel does not have recursion and will reject defs that are recursive*

if the kernel supported recursion, it would break logic soundness: 
```lean
simple_def reallyBad : forall {P : Prop}, P := reallyBad
theorem pipi : 3*3 = 6 := reallyBad
```
but of course we want recursion! so Lean provides *recursors*\
The `recursor` transforms what we write as a recursive definition into something that is 
*not* recursive for the kernel to digest. It tracks the values defined already, and 
is designed such that reductions still work nicely. 

We make the kernel accept `something` that is a recursive definition using `#reduce fun n => something n`. 

Well founded recursion is stronger than structural, we use structural recursion because
1. it does not ask for explicit proof
2. it enables good kernel reduction behaviour, which is useful for types definition and kernel computation (e.g. `rfl`, `bv_decide`)

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

### misc 
- at the beginning of a talk it's cool to ask questions to get a feeling of who's in the audience.
- `#guard_msg` compares the output with the previous message, allows for basic testing. 
- [a few constructions on constructors](https://research-portal.st-andrews.ac.uk/en/publications/a-few-constructions-on-constructors)
- [trampolines](https://hackernoon.com/on-recursion-and-trampolining-uxf3tvx)
- how do we make sure that our proof means *actually* what we mean? always a problem in ITP!
