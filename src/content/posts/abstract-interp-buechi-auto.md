---

title: "abstract interpretation from buechi automata"
date: 2023-09-30
---

# [abstract interpretation from buechi automata](https://dl.acm.org/doi/pdf/10.1145/2603088.2603127)
### a paper by m. Hofmann, w. chen

From a given BA, build an abstract lattice with the following properties: 
- there is a Galois connection between it and the infinite lattice of languages of finite and infinite words over a given alphabet
- the abstraction is faithful wrt. acceptance
- least fixpoints and $\omega-$iterations can be computed on the level of the abstract lattice
one can develop an abstract interpretation to check whether finite and infinite traces of a recursive program are accepted by a policy automaton. 
this approach is more flexible for integration with data types, objects, higher-order functions (easier reasoning?)
