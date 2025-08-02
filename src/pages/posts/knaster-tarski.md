---
layout: ../../layouts/BaseLayout.astro
title: "knaster-tarski theorem"
---

*WIP*

# Knaster-Tarski theorem in type theory
statement: *the set of fixed points of a monotone function over a complete lattice is itself a complete lattice*. 

We start by definining the elements that live in the statement. 

### Lattice
A *lattice* is a set of elements $L$ such that 
1. there exists two binary operations $meet (\land)$ and $join (\lor)$ such that 
- $\land$ is associative: $\forall x, y, z \in L, (x \land y)\land z = x \land (y\land z)$
- $\land$ is commutative: $\forall x, y \in L, x \land y = x \land x$
- $\land$ is idempotent: $\forall x \in L, x \land x = x$
- $\lor$ is associative: $\forall x, y, z \in L, (x \lor y)\lor z = x \lor (y\lor z)$
- $\lor$ is commutative: $\forall x, y \in L, x \lor y = x \lor x$
- $\lor$ is idempotent: $\forall x \in L, x \lor x = x$
2. there exists two elements $\top$ and $\bot$ such that 
- $\top$ is an identity element for $\land$: $\forall x \in L, x\land \top = x$
- $\bot$ is an absorbing element for $\land$: $\forall x \in L, x\land \bot = \bot$
- $\bot$ is an identity element for $\lor$: $\forall x \in L, x\lor \bot = x$
- $\top$ is an absorbing element for $\lor$: $\forall x \in L, x\lor \top = \top$
3. there exists a partial order, which we indicate as $\le$, such that 
- $\bot$ is below everything: $\forall x, \bot \le x$
- $\top$ is above everything: $\forall x, x \le \top$
- $x \land y$ is the "greatest lower bound (GLB) of x and y", where: 
    (i) the lower bound of $x, y$ is $p = LB (x, y)$ if $p \le x$ and $p \le y$
    (ii) $p$ is the greatest lower bound if $\forall q, q = LB (x, y)$, where $q \le x$ and $q \le y$, 
        we also have $q \le p$
- $x \lor y$ is the "least upper bound (LUB) of x and y", where: 
    (i) the upper bound of $x, y$ is $p = UB (x, y)$ if $x \le p$ and $y \le p$
    (ii) $p$ is the least upper bound if $\forall q, q = UB (x, y)$, where $x \le q$ and $y \le q$, 
        we also have $p \le q$

From the definitions we have: 
- $x \land y \le x$ and $x \land y \le y$
- $x \lor y \ge x$ and $x \lor y \ge y$
- $x \land (y \lor z) \le ((x\land y)\lor(x\land z))$
    ```
                   ⊤
                   |
                 x ∨ y       "join" : LUB
                 /   \
                /     \
                x      y
                \     /
                 \   /
                 x ∧ y       "meet" : GLB
                   |
                   ⊥
    ```

Other examples:
- Given any set, the set of its subsets is a lattice, with the partial order $\subseteq$
- $\mathbb{R}$ between $[0,1]$ is a latice with $\land$ being `max`, $\lor$ being `min`, 
    and the order relation being $\le$
- same for $\mathbb{Q}$ between $[0,1]$

We can also reason the other way around and get a lattice out of a partial order: consider $\mathbb{Q}[0,1]$ with order relation $\le$, we need to define $meet$ and $join$. 

We can have a lattice with $d = \top$, $a = \bot$ and $a \land c = a$, $b \land c = a$ ...
```
         d
        / \
       b   c
        \ /
         a
```
    
In this case:
```
         d
        / \
       c   e
       | x |
       b   f
        \ /
         a
```
We have a lattice with $d = \top$, $a = \bot$ and $b \land f = e$, but also $b \land f = c$?
In this lattice we can't decide what's the actual LUB between c and e. This goes against the actual definition of join, hence this is not a lattice.
To make this a proper lattice we can just add: 
```
      d
     / \
    c - e
    | x |
    b   f
     \ /
      a
```
meaning that $b \land f = c$ since $c \le e$, and it can't be $b \land f = e$ since $e$ is not the *least* upper bound.

If a partial order fails to become a lattice it's usually because there's no $\top$, no $\bot$ or 
two elements don't have a unique LUB\GLB.

Another example with sets: let's consider $S = \mathbb{N}$ and a lattice $L$, a set containing: 
1. $S$
2. All finite subsets of $S$: $T \;|\; T\subseteq S \; and \; |T|\le \infty$
For example, this will include the nodes: 
```
    ...
        {1, 2, 3}    {1, 2, 4}
        /      |     /   |
       /       |    /    |
    {3}       {1, 2}    {4}
    ...
```
We'll have 
- $\top := S$
- $\bot := \empty$
- $\land := \cap$, which is GLB, in fact: 
    $S\cap T$ is the GLB of $(S, T) \iff$ (1) $S\cap T \le S$ and (2) $S\cap T \le T$ and (3) $\forall V, V \le S$ and $V \le T \implies V \le S \cap T$
    1. $S\cap T\le S$: $\forall x, x\in S\cap T = \{x\;|\; x\in S \; and\; x\in T\} \implies x\in S$
    2. analogously, $S\cap T \le T$
    3. $\forall V, V \le S$ and $V \le T \implies V \le S \cap T$, but we know $\forall x\in V, x \in S$ and $\forall x\in V, x \in T$ and $\forall x\in V, x \in T\cap S$ is the same as saying that $x\in S$ and $x\in T$
- $\lor := \cup$

We now need to define a *complete* lattice:

# Knaster-Tarski theorem in analysis

let us recall some definitions:
· lattice := set of points with two functions join and meet : L × L → L
            and two elements sup and inf : L
· a lattice is complete ↔ (∀ S ⊆ L ∃ l, IsLeastUpperBound S l) ∧ (∀ S ⊆ L ∃ l, IsGreatestLowerBound S l)
            (any subset has at least an upper bound and a greatest lower bound)
    where
        IsUpperBound S l, with S ⊆ L and l ∈ L := ∀ s ∈ S, s ≤ l
        IsLowerBound S l, with S ⊆ L and l ∈ L := ∀ s ∈ S, l ≤ s
        IsLeastUpperBound S m, with S ⊆ L and m ∈ L := IsUpperBound S m ∧ (∀ l: IsUpperBound S l → m ≤ l)
        IsGreatestLowerBound S m, with S ⊆ L and m ∈ L := IsLowerBound S m ∧ (∀ l: IsLowerBound S l → l ≤ m)
    e.g.:
        · (ℚ ∩ [0, 1], ≤) is not complete, e.g. √2 is missing and sub-lattices around that area will not have the appropriate upper/lower bounds.
        (ℝ ∩ [0, 5]) is a complere lattice
        · In Lean, (Prop, →) is a lattice, where join is disjunction and meet is conjunction, ⊥ is false and ⊤ is true
    In general, in any lattice, we have that IsLeastUpperBound {P, Q} = P ∨ Q and IsGreatestLowerBound {P, Q} = P ∧ Q.
    Note also that IsLeastUpperBound {P} = P and IsLeastUpperBound {} = ⊥.
    Finally, we can define a lattice L as a partially ordered set (L, ≤) such that every finite subset S ⊆ L has at least
    *IsLeastUpperBound* (either ⊥ or joins) and *IsGreatestLowerBound*.
    In particular, a lattice is complete if this definition holds for any subset S ⊆ L (not necessarily finite).
    In practice, we show that LeastUpperBound and GreatestLowerBound exist by establishing the existence of a ⊥
    (an element smaller than any other element) and ⊤ (an element larger than any other element), as well as join and meet,
    which yield the LeastUpperBound and GreatestLowerBound of a two-element-set. By repeatedly applying join and meet we
    obtain the LeastUpperBound and GreatestLowerBound of finite sets.
    From intuition, we assume to know that the LeastUpperBound and GreatestLowerBound are unique (won't prove it here, though).
· a function f : L → M is monotonic ↔ ∀ x, ∀ y, x ≤ y → f(x) ≤ f(y), i.e., the ordering relation is preserved

theorem statement:
Let (L, ≤) be a complete lattice and let f : L → L be an order-preserving (monotonic) function w.r.t. ≤.
Then the set of fixed points of f in L forms a complete lattice under ≤.

To understand the theorem, we construct the following lattice:
· we take ℕ, add two extra elements called ⊤ and ⊥:
            ⊤
        0 1 2 ...
            ⊥
    this is a complete lattice:
    LeastUpperBound ∅ = ⊥ because any element is an upper bound of an empty set and is smaller than every orhter element
    LeastUpperBound {n} = n
    LeastUpperBound {n, m} = ⊤
    so this is a complete lattice.
· let L be a complete lattice, let X be any set, then the space of functions [X, L] = {f | X → L} is a complete lattice
    bottom function ⊥ := fun x => (⊥ : L) "takes any element in X, spits out ⊥"
    join function (f ∨ g) := fun x => (f x) ∨ (g x)
    and is complete, because given a family of functions {fi}, their join (f1 ∨ ... ∨ fn) := fun x => f1(x) ∨ ... ∨ fn(x)
    being able to do join on infinitely many elements reassures us about the completeness of said lattice.
    the join of an infinite set of elements is thus the LeastUpperBound
    analogously, given a family of functions {fi}, the GreatestLowerBound of {fi} is fun x => GreatestLowerBound {fi(x)},
    and note that fi(x) all belong in L, which was complete to begin with and allows us to compute a GreatestLowerBound
    for example: GreatestLowerBound {f, g} := fun x => GreatestLowerBound {(f x), (g x)}
· we instantiate this construction with X = ℕ and L = ℕ⊤⊥
    the lattice contains for example:
    · almost identity function fun (x : ℕ) => x
    · always-returns-bottom function fun (x : ℕ) => ⊥
    · weird function fun (x : ℕ) => if x = 0 then 1 else ⊥
    · another weird function fun (x : ℕ) => if x = 0 then 1 else if x = 1 then 1 else ⊥
    · another weird function fun (x : ℕ) => if x = 0 then 1 else if x = 1 then 1 else if x = 2 then 2 else ⊥
    · another weird function fun (x : ℕ) => if x = 0 then 1 else if x = 1 then 1 else if x = 2 then 2 else if x = 3 then 6 else ⊥
    these weird functions are all finite approximations of the factorial function (up to a certain x).
· we build a monotone function from this space of functions to itself m := (ℕ → ℕ⊤⊥) → (ℕ → ℕ⊤⊥)
    i.e. m (f) := fun x => if x = 0 then 1 else x * f (n - 1)
                         0          1          2          3          4          5       ...
    f0 = fun x => ⊥      ⊥          ⊥ ...
    f1 = m f0            1          ⊥          ⊥ ... we cheat, because we're multiplying a natural number by ⊥!
    f2 = m f1            1          1          ⊥          ⊥         ⊥ ...
    f3 = m f2            1          1          2          ⊥          ⊥ ...
    f4 = m f3            1          1          2          6          ⊥ ...
    f1 ∨ f2              1          1          ⊥ ... we take the join (upper) element of {f1(0), f(0)}, etc.
· given two said functions we define f ≤ g ↔ ∀ x f(x) ≤ g(x) ∀ f(x) ≤ g(x) then m(f) ≤ m(g)

idea:
think about the lattice ℝ[0,1] for "normal functions" (i.e. real analysis)
then think about sets: e.g. the set of naturals (each set is a node of the lattice). in this case the "real math" object
    is a set, the lattice structure is given by ∪ ∩, the monotone function we use to understand this is a f
    S ↦ {zero} ∪ {succ s ∀ s ∈ S}
knaster tarski is the only way we have to create real math objects out of recursive defs
not every rec definition has a fixed point:
    consider functions ℝ → ℝ, f(x) = x + 1, which has no fixed points
if we want to build some real maths in lean we need to have a lattice and a monotone function and use KT
positivity check: prove that the function is monotone
if we use a non monotone function, we can't use KT whcih means we cant find a set it corresponds to
in lean this is called positivity check
for function defs, the "real math object" we refer to is an actual function, e.g. ℕ → ℕ, so we need to impose a lattice on functions
which we don't have, so we use a larger space of partial functions (functions with ⊥, ⊤) for which we can impose said definitions
and then we'll give that a monotone function, whose fixed point is the function itself. KT shows that the fixed point of these
defs lives in actual functions (not only partial) : we can show that the least fixed point are well defined everywhere, otherwise it would not be a function
e.g. in Lean when we can;'t prove the structural termination of stuff its bc lean cant prove the monotonicity of the function on that lattice
