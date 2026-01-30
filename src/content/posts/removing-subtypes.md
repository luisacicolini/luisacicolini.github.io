---
title: "who subtypes subtyped definitions?"
date: 2026-01-06
--- 

# Who subtypes subtyped definitions?
### a.k.a. removing subtypes if you've subtyped too hard

When writing the popcount circuit I ended up massively using subtypes:
during the early design and development it was easier to always carry the proofs around. 

However, when the time came to polish my definitions and get them in a reviewable state,
I needed to get rid of subtypes.
It was supposed to be a mechanical task, but I got lost in the sauce -
and here I am writing about it.

Let's start with a simple example (as usual, thanks [bollu](https://pixel-druid.com/) for the help).

First of all: what are subtypes?
Subtypes in lean are a succint way to say that a definition builds an object of a certain *type*
that satisfies a certain *property*.

### A simple example
Suppose we have a definition returning a natural number `y` satisfying a property `PROP`, 
we will write it as:
```lean4
def PROP (n : Nat) : Prop := n > 4

def multiplyByTwo_with_subtype (x : Nat) (hx : PROP x) : { y : Nat // PROP y} :=
  let val := x * 2
  have prop : PROP val := by
    simp only [PROP, gt_iff_lt, val] at ⊢ hx
    omega
  ⟨val, prop⟩
```
Given a natural `x` and an hypothesis `hx` (telling us that `PROP x` holds),
`multiplyByTwoPROP` returns a natural `val := x*2` equipped with a proof `prop` that `PROP val` holds.

Suppose we now want to split `multiplyByTwoPROP` into a definition without subtyping *and* a lemma
characterizing its behaviour (i.e., a lemma proving that the output of `multiplyByTwoPROP` satisfies `PROP`).
We start by writing the same exact `def` without subtypes:
```lean4
def multiplyByTwo_without_subtype (x : Nat) : Nat := x * 2
```
And secondly, we state and prove a lemma proving that the output of `multiplyByTwo_without_subtype` 
satisfies `PROP`:
```lean4
theorem multiplyByTwo_property (hx : PROP x): PROP (multiplyByTwo_without_subtype x) := by
  unfold multiplyByTwo_without_subtype
  simp only [PROP, gt_iff_lt] at ⊢ hx
  omega
```
We note two things:
1. the lemma takes the same hypotheses we required at `multiplyByTwoPROP`,
  without which we could never prove `PROP`.
  This was the source of my confusion: the subtype I was dealing with was rather complex,
  and the hypothesis I required on the subtyped definition was, too.
  Because the hypothesis was so complex I found it very counter-intuitive to require it, 
  and was trying to get rid of it!
2. the proof strategy we used in the subtyped version is basically the same we can use in the lemma,
  as long as we appropriately unfold the non-subtyped definition.

### A more complex example with recursion 
Let's build a definition that, given an input list of naturals
`l : List Nat`, filters the odd numbers out and returns a list `l'`only containing even numbers.
In the subtyped definition, we equip the result with a proof that every element in the
output list is in fact even.
```lean4
def filterList_with_subtype (lin : List Nat) :
    {ls : List Nat // ∀ i (hi : i < ls.length), ls[i] % 2 = 0} :=
  match lin with
  | [] => ⟨[], by simp⟩
  | head :: tail =>
      if hcons : head % 2 = 0 then
        /- only add the element to the output list if it's even (`hcons`) -/
        let ⟨lout, loutproof⟩ := (filterList_with_subtype tail)
        let lout' := head :: lout
        /- prove that the new list only contains even numbers -/
        have proof' : ∀ (i : Nat) (hi : i < lout'.length), lout'[i] % 2 = 0 := by
          intros j hj
          simp [lout']
          by_cases hj : j = 0
          · /- the newly-added element is even by `hcons` -/
            simp [List.getElem_cons, hj, hcons]
          · /- the rest of the list already satisfies this property, by `loutproof` -/
            simp [List.getElem_cons, show ¬ j = 0 by omega]
            apply loutproof
        ⟨lout', proof'⟩
      else
        filterList_with_subtype tail
```
Now if we try and remove the subtype we first build a definition:
```lean4
def filterList_without_subtype (lin : List Nat) : List Nat :=
  match lin with
  | [] => []
  | cons :: ls =>
      if _hcons : cons % 2 = 0 then
        let lout := (filterList_without_subtype ls)
        let lout' := cons :: lout
        lout'
      else
        filterList_without_subtype ls
```
Then, we want to equip this definition with a lemma guaranteeing that the output list only contains only even numbers.
One such lemma could look like:
```lean4
theorem filterList_property (lin : List Nat)
  (hlout : lout = filterList_without_subtype lin) :
      ∀ i (hi : i < (lout).length), lout[i] % 2 = 0 := by
  subst hlout
  intros i hi
  induction lin generalizing i
  · case nil =>
    simp [filterList_without_subtype] at hi
  · case cons c t tih =>
    unfold filterList_without_subtype
    split
    · case _ ht =>
      by_cases hi : i = 0
      · simp [hi, ht]
      · simp [List.getElem_cons, show ¬ i = 0 by omega]
        apply tih
    · case _ hf =>
      apply tih
```
This proof strategy is slightly different from the one we used in the subtyped definiton, 
although it uses the same intuition and induction principle: 
- if the list is empty, there's nothing to prove
- otherwise for a list `cons :: ls` we unfold the definition `filterList_without_subtype` and notice 
  that it's only pushed to the list if it's even. By the inductive hypothesis `tih` we can prove 
  that the property holds for `ls`.

Alternatively, we can can stick more precisely to that proof strategy:
```lean4
theorem filterList_property' (lin : List Nat)
  (hlout : lout = filterList_without_subtype lin) :
      ∀ i (hi : i < (lout).length), lout[i] % 2 = 0 := by
  rcases hempty : lin
  · case nil =>
    simp [hlout, filterList_without_subtype, hempty]
  · case cons head tail =>
    simp only [hlout, hempty, filterList_without_subtype, dite_eq_ite]
    by_cases hcons : head % 2 = 0
    · intros j hj
      by_cases hj : j = 0
      · simp [List.getElem_cons, hj, hcons]
      · simp [hcons, List.getElem_cons, show ¬ j = 0 by omega,
          filterList_property' tail]
    · simp [hcons, filterList_property' tail]
```
This proof is built rather mechanically, with the **same exact strategy** as the subtyped definition.
In particular, we use the body of `proof'` and replace the recursive calls in the definition with
a recursive call to the theorem we're writing (`simp [filterList_property']`).

With this strategy we might be sometimes asked to prove termination for the theorem - just like we do for definitions.
Recall that a proof in Lean is fundamentally a value of a certain type,
and when we prove a theorem we *construct* such value! 
So there really is not that much of a difference between building a proof for a lemma and building a value of a type 🤪.

Finally, note that while we can come up with different proof strategies, 
the same exact hypotheses are sufficient for both.

### A more complex, tail-recursive example

Now, it might be that we're interested in a *tail*-recursive definition. 
To say that reasoning about the subtyping of tail-recursive definitions drove me nuts would be an understatement.

Let's first turn the initial, subtyped definition into a tail-recursive one, using an accumulator.
The gist of tail-recursion with accumulators is that *the accumulator will change at every recursive call, such that we can return it directly upon reaching the base case of the recursion.*

In the subtyped case, upon reaching the base case, we want to have have both a result and a proof for that result.
Therefore, the first difference that we need to take into account is that we need to carry around a proof that 
said accumulator respects the property we expect.
When we add a new element into the accumulator (in this case a `List`) `acc' := head :: acc`
and want to prove that `acc'` satisfies a property, 
we want a hypothesis about `acc` already satisfying it ( `hacc`),
and we then want to show that the newly-added element `head` complies too.
In the recursive call we will pass the new proof, that is up-to-date with respect to the new `acc'`
```lean4
def filterList_with_subtype_tailrec (lin acc : List Nat)
    (hacc : ∀ i (hi : i < acc.length), acc[i] % 2 = 0) :
    {ls : List Nat // ∀ i (hi : i < ls.length), ls[i] % 2 = 0} :=
  match lin with
  | /- in the base case the accumulator is already complete and proven to satisfy the property -/
    [] => ⟨acc, hacc⟩
  | head :: tail =>
      if hcons : head % 2 = 0 then
        /- we first construct the new accumulator -/
        let acc' := head :: acc
        /- we show that `acc'` satisfies the property -/
        have proof' : ∀ (i : Nat) (hi : i < acc'.length), acc'[i] % 2 = 0 := by
          intros j hj
          simp [acc']
          by_cases hj : j = 0
          · /- the newly-added element satisfies the property by `hcons` -/
            simp [List.getElem_cons, hj, hcons]
          · /- for the old accumulator we can use the old hypothesis `hacc` -/
            simp [List.getElem_cons, show ¬ j = 0 by omega]
            apply hacc
        filterList_with_subtype_tailrec tail acc' proof'
      else
        filterList_with_subtype_tailrec tail acc hacc
```


What happens if we try to split this definition into a non-subtyped definition plus a lemma? 
First a definition
```lean4
def filterList_without_subtype_tailrec (lin acc : List Nat) : List Nat :=
  match lin with
  | [] => acc
  | head :: tail =>
      if _hcons : head % 2 = 0 then
        let acc' := head :: acc
        filterList_without_subtype_tailrec tail acc'
      else
        filterList_without_subtype_tailrec tail acc
```
Then would want a lemma like:
```lean4
theorem filterList_without_subtype_tailrec_property
  (lin lout : List Nat) (hlout : lout = filterList_without_subtype_tailrec lin []) :
    ∀ i (hi : i < lout.length), lout[i] % 2 = 0 := by sorry
```
This strategy is not going to work (unless `filterList_without_subtype_tailrec` is *trivial enough*™️), 
because this lemma only considers what happens when the accumulator is empty, which is not enough!
In fact, our definition is very general, and its behavior might differ when the accumulator is non-empty:
we need to characterize the behaviour of the definition for **any** accumulator, 
i.e., for **any** call in the recursive definition, as the accumulator changes!

In particular, we will need the following theorem:
```lean4
theorem filterList_without_subtype_tailrec_property'
  (lin lout acc : List Nat)
  (hacc : ∀ i (hi : i < acc.length), acc[i] % 2 = 0)
  (hlout : lout = filterList_without_subtype_tailrec lin acc) :
    ∀ i (hi : i < lout.length), lout[i] % 2 = 0 := by
  subst hlout
  rcases lin
  · case _ => exact hacc
  · case _ head tail =>
    intros j hj
    unfold filterList_without_subtype_tailrec
    by_cases hcons : head % 2 = 0
    · simp only [hcons, reduceDIte]
      let acc' := head :: acc
      /- same proof strategy as the subtyped definition -/
      have proof' : ∀ (i : Nat) (hi : i < acc'.length), acc'[i] % 2 = 0 := by
        intros j hj
        simp [acc']
        by_cases hj : j = 0
        · /- the current element is proven by `hcons` -/  
          simp [List.getElem_cons, hj, hcons]
        · /- the rest of the list is proven by `hacc` -/
          simp [List.getElem_cons, show ¬ j = 0 by omega]
          apply hacc
      apply filterList_without_subtype_tailrec_property' tail acc'
            (lout := filterList_without_subtype_tailrec tail acc') proof'
      rfl
    · simp only [hcons, reduceDIte]
      apply filterList_without_subtype_tailrec_property' tail acc
            (lout := filterList_without_subtype_tailrec tail acc) hacc
      rfl
```
Notice that in this lemma we *had* to recycle the same `hacc` we had in the subtyped definition.
When I first approached a definition of this kind I tried really really hard to get rid of this hypothesis, 
and my reasoning was: if at the first call I **always** pass an empty accumulator, why would I want anything more general than that?
It took me quite a lot to understand this, but after a long time I realized that our definition is very general, 
and if we want to use this very general accumulator we have no rule pinky-promising that at the very first
call `acc` will comply with the property we expect.
Because our `acc` is as general as it gets, we need to ensure that it *always* verifies the property we want!

In this last lemma the proof strategy was again the exact same strategy we used in the subtyped definition, 
and we recursively call the theorem (where we would otherwise call the constructor).

We can now, finally, specialize this proof to the very specific case with the initially-empty accumulator:
```lean4
theorem filterList_without_subtype_tailrec_property_specialized
  (lin lout : List Nat) (hlout : lout = filterList_without_subtype_tailrec lin []) :
    ∀ i (hi : i < lout.length), lout[i] % 2 = 0 := by
  subst hlout
  apply filterList_without_subtype_tailrec_property'
        (lin := lin) (acc := []) (hacc := by simp)
  rfl
```

### A final note
When the accumulator is empty we can trivially prove `hacc` by `simp` - 
exactly what we did in the base case of the subtyped non-tail-recursive definition `| [] => ⟨[], by simp⟩`!
Analogously, the proof strategies in the recursive case of the tail-recursive and non-tail-recursive definitions are pretty much the same!
I find this symmetry very beautiful, as it expresses the magic of tail-recursion🧚🏼‍♀️.
