---
layout: ../../layouts/BaseLayout.astro
title: "omega tactic in lean4"
date: "01.28.2024"
---
# omega tactic in lean

`omega` is a lean tactic that solvec linear optimization problems. It's one of the first tactics I used and learning how it works helped me 
understanding how to better express the boundaries of the problems I want to solve (in my case most of my constraints had to do with the boundedness of bitvectors' values).
Some examples: 

1. Given the following hypotheses on `a` and `b`, it's impossible for their sum to be greater than `20`. 
    ```lean4
    example {a b : Nat} (ha : a < 10) (hb : b < 10) :
        a + b > 20 := by omega 
    /- omega could not prove the goal:
        a possible counterexample may satisfy the constraints
          0 ≤ d ≤ 9
          0 ≤ c ≤ 9
          c + d ≤ 20
        where
         c := ↑a
         d := ↑b
    -/

2. For any values of `a` and `b` their sum will be greater than `20`: 
    ```lean4
    example {a b : Nat} (ha : a > 10) (hb : b > 10) :
        a + b > 20 := by omega ✅


Now if we consider non-linear functions, `omega` won't work e.g. :

3. Even though we know that in maths `a * b` with `a > 10` and `b > 10` will necessarily be greater than `10`, `omega` can't reason about non-linear operations such as non-constant multiplication:
    ```lean4 
    example {a b : Nat} (ha : a > 10) (hb : b > 10) :
        a * b + b > 20 := by omega

    /- omega could not prove the goal:
        a possible counterexample may satisfy the constraints
        e ≥ 0
        d ≥ 11
        d + e ≤ 20
        c ≥ 11
        where
        c := ↑a
        d := ↑b
        e := ↑a * ↑b
4. In these cases, `omega` will try to shadow the operands it can't recognize, treating them as a variable whose constraints are unknown, and reason about whatever else remains in the expression. 
    The example below is *true* regardless of whatever value `a * b` can have!
    ```lean4 
    example {a b : Nat} (ha : a > 10) (hb : b > 10) :
        a * b + b + a > 20 := by omega ✅
