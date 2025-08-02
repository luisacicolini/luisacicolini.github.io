---
title: "omega tactic in lean4"
layout: ../layouts/BaseLayout.astro
---
`omega` is a very cool and powerful tactic in the Lean framework, made to solve linear optimization problems.
Consider the following clauses:
EX
Clearly, there is no x that can satisfy both these parameters: `omega` will tell us that it could find no x satisfying both.
Another example:
EX
There exists (at least... depending on our domain of interest :p) *at least* one x satisfying both constraints.
We say that the problem is *satisfiable* and sleep tight at night knowing that this problem exists.

Now if we consider non-linear functions, `omega` won't work as expected, e.g. :
EX
What `omega` does in this case is to assign a dummy name to x ^ 2, considering it another variable of the problem:
EX
Knowing about these assignments is very important to reason about more complex functions, whose constraints are known, e.g.:
EX
In this case `omega` won't be able to solve the problem, since it does not know power and does not know that 2 ^ w is strictly positive.
However, if we add:
EX
since the variable assigned to 2 ^ w is anyways constrained enough.
