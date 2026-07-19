---
title: "it's a long way to automata if you want to coinduct"
date: 2026-02-16
---

# [It's a long way](https://www.youtube.com/watch?v=vj_rvLVpqg8) to automata if you want to coinduct
## Very random notes on my journey to learn coinduction. 

One of the most conceptually challenging things I've learned recently are the coinduction and corecursion, 
and in particular their connection to the theory of automata. 

### Intuition
We want to represent an infinite stream of objects in a *finite* way. We can do this in two ways: 
1. we use an automaton to describe how the objects in the stream are constructed: very concretely, 
    each transition of the automaton corresponds to an element existing in the stream at a certain 
    position. 
2. we think about a function that takes a certain input and does _something_ with it, taking some of 
    its results as a new input: this is a corecursive definition. 
    
### Corecursion To Define Sequential Logic 
Corecursion is useful to describe the behavior of sequential logic hardware components, such as registers. 
For example:
```lean4
/--
  A register wrapper enabling the description of components with feedback loops.
  We expect the feedback loop to satisfy some laws that will be helpful in proofs.
  · `input` is the the stream of inputs
  · `init_regs` contains the initial values of inputs obtained from the feedback loop
  · `update_fun` is the function computing the output of the component, given all the inputs

  In this model, we are inspired by trace monoidal category theory, by which
  we model a feedback loop as a function with a-many inputs and x-many inputs,
  producing b-many outputs and x-many outputs that are re-fed as inputs to the function
  (inputs, inputs from feedback, outputs, outputs to be fed-back)
-/
def register_wrapper
    (inputs : Stream' (Vector α m))
    -- we set the `init_regs` to `none` after using the values for the first iteration
    (init_regs : Vector α nfeed)
    -- inputs- and outputs- that are feedback-looped are canceled
    (update_fun : (Vector α m × Vector α nfeed) → (Vector α r × Vector α nfeed))
      : Stream' (Vector α r) :=
  /-
    The state-space β is the product of the input stream (Stream' (Vector α m)),
    the values we store because they're part of the feedback loop (Vector α nfeed),
    the initial values for the very first iteration, where no values are stored (Option (Vector α nfeed))
  -/
  let β := Stream' (Vector α m) × (Vector α nfeed) × Option (Vector α nfeed)
  /-
    `f` computes the output
  -/
  let f : β → Vector α r :=
    fun (input_stream, current_regs_opt, init_regs) =>
      /-
        `init_regs` is different than none only at the very first iteration.
      -/
      match init_regs with
      | some iv =>
                  /-
                    We apply `update_fun` and only extract the output that is not fed back to the loop.
                    At the first iteration, we use the initial values `iv` as arguments for `update_fun`
                  -/
                  let (output, _) := update_fun (input_stream.head, iv)
                  output
      | _ =>  /-
                We apply `update_fun` and only extract the output that is not fed back to the loop.
                After the first iteration, we use the stored values `current_regs_opt` as arguments for `update_fun`
              -/
              let (output, _) := update_fun (input_stream.head, current_regs_opt)
              output
  /-
    `g` computes the next state
  -/
  let g : β → β :=
    fun (input_stream, current_regs_opt, init_regs) =>
/-
  At every iteration we update the state as follows:
  · `input_stream` is updated to `input_stream.tail`
  · `current_regs_opt` is updated to store the portion of the result of `update_fun` that is
                       used as input (fed-back) at the next cycle
  · `init_regs` remains `none`, as it is only different than `none` at the very first call
-/
    match init_regs with
    | some iv =>
                /-
                  We apply `update_fun` and use the output that is fed back to the loop in the next iteration.
                  At the first iteration, we use the initial value `iv` as input for `update_fun`
                -/
                let (_, output_feedback) := update_fun (input_stream.head, iv)
                (input_stream.tail, output_feedback, none)
    | _ =>  /-
              We apply `update_fun` and use the output that is fed back to the loop in the next iteration.
              After the first iteration, we use the stored value `current_regs_opt` as input for `update_fun`
            -/
            let (_, output_feedback) := update_fun (input_stream.head, current_regs_opt)
            (input_stream.tail, output_feedback, none)
  Stream'.corec f g (inputs, init_regs, none)
```

### Coinduction To Define Relations 
We can use the coinduction principle to reason about these definitions, and prove properties around them. 
For example, we can use coinduction to define a relation between these infinite streams: 
```lean
/-- Two streams are considered equivalent if they contain the same `some _` messages,
  in the same order. That is, any finite sequence of `none`s may be ignored. -/
coinductive Bisim : Stream α → Stream α → Prop where
| step {a b : Stream α} {n m : Nat} : Bisim (a.drop (n + 1)) (b.drop (m+1))
    → a.get n = b.get m
    → (∀ i < n, a.get i = none)
    → (∀ j < m, b.get j = none)
    → Bisim a b
```
In this case, the bisimilarity checks that the infinite sequences contain the same objects, 
in the same order, potentially separated by an arbitrary number of `none` (a.k.a. `tau`) elements. 
For example, the following streams:
```
... a _ _ b _ _ c d ...
... _ _ a b _ c _ d ...
``` 
are bisimilar, modulo the `_` terms. 
In automata terms: two automata produce bisimilar sequences of _things_ if the states outputting valid elements 
in both automata are connected by transitions in the same order modulo a finite number of `none` elements, such that 
the ordering of the output elements is preserved. 

### Coinduction in Proofs 
When we want to prove that a coinductively-defined property `~` holds, e.g. between two infinite streams 
`a` and `b`, we need to prove that:
1. the coiinductive predicate is closed under the relation, i.e.,  there exists two indices `n` and `m` such that:
- `a[n] = b[m]`: the `n`-th element of `a` is equal to the `m`-th element of `b`
- `a.drop n ~ b.drop m`: dropping all elements until those two indices respectively yields bisimilar sub-sequences 
- `(∀ i < n, a.get i = none)` and `(∀ j < m, b.get j = none)`, i.e., there is no non-valid (non-`none`) element in the dropped sub-sequence
2. the two streams satisfy the chosen predicate.
