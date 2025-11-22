---
layout: ../../layouts/BaseLayout.astro
title: "big proof 2025"
date: "06.13.2025"
---

# big proof 2025

## Kevin Buzzard - Formalizing Fermat: How it's going

- if you prove things at the right level of generality proofs are better!

## Mario Carneiro - Metatheory in Lean

- de brujin principle: the program should have a small, trusted kernel responsible for checking theorems
- kernel -> rules of type theory
- dtt:
    · impredicative uniferse prop
        def proof irrrelevance
        no univ cumul
        indexed
    · inductive types: e.g. ℕ
        in the DTT notaation: K ::= 0 | (c:e) + K
                                e ::= ...|μx : eK | c_{μx:e.K} | rec_{μx:e.K}
            and in particular: ℕ := μT : U₁ . (zero : T) + (succ : T → T)
            such a def is only admissible if positive (no T on the left side of an arrow)
            something goes against cantor's theorem?

- lean: treat all proofs of a prop as the same
    zfc: axioms of set theory that all mathematicians % french agree on
    idea: treat types as sets and elements as elements of the set (= obv model of dtt in zfc)
- grothendieck universes?
- lean is proven consistent if zfc with ω inaccessible is consistent
- definitional inversion theorem

## Paola Iannone - Lean for teaching university mathematics

- students struggle to adjust to the rigour and language of university maths
- can students `understand` proofs?
