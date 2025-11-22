---
layout: ../../layouts/BaseLayout.astro
title: "knaster-tarski theorem"
date: "05.28.2025"
---

# knaster-tarski theorem in type theory

Based on a very patient and kind explanation by [bollu](https://pixel-druid.com/). 
It's taking me a lot to understand the gist of this theorem and its implication and uses.

statement: *the set of fixed points of a monotone function over a complete lattice is itself a complete lattice*. 
we will need a bunch of definitions around lattices to get to the theorem. 

A **lattice** is a set of elements $L$ such that 
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


We now need to define a **complete lattice.** 
Given the above definitions, we can reason about meet and join over sets with different number of elements:

- $meet(x_1, ...., x_n) = p \iff (p\le x_1)\land ... \land (p\le x_n)\land (\forall k, k \le x_1 \land ... \land k \le x_n)\implies k \le p$
- $meet(x) = p \iff (p\le x) \land (\forall k, k \le x) \implies k \le p $
    and given that $x\le x$, we can just pick $p = x$
- $meet (x_i \;|\; \forall i\in S) = p \iff (\forall i\in S, p \le x_i) \land (\forall k (\forall i\in S \;|\; k \le x_i)\implies k\le p)$

from which it follows for $S = \empty$ that $meet () = p \iff (\forall i\in \empty, p\le x_i) \land (\forall k (\forall i\in \empty, k\le x_i) \implies k \le p)$ where: 
1. $(\forall i\in \empty, p\le x_i)$ is always true, since the *existence* of a certain $x_i, i\in \empty$ to compare $p$ against is itself a contradiction.  
2. $(\forall i\in \empty, k\le x_i)$ is always true for the same reason 
leaving us with $\forall k, k\le p$, meaning $p = \top$.

meet finds the **highest point in the lattice** that is **lower** than the given points (GLB)
and in particular, the lattice definition ensures that if such point exists, it is **unique**.

Let's consider the set $L = \mathbb{N} \cup \{S\;|\; S \subseteq \mathbb{N} \land |S|\le \infty\}$, i.e., 
containing the set of natural numbers and any subset of natural numbers with finite cardinality.
Let's make sure this is actually a lattice by defining: 
- $\top = \mathbb{N}$
- meet = $\cap$
- join = $\cup$
- $\bot = \empty$, note that $\empty$ has finite cardinality and is a subset of $\mathbb{N}$, thus belongs to $L$
- any two elements have GLB and LUB with respect to the relation $\subseteq$: given $c, y\in L$ the GLB is also finite and 
    by definition $x\cup y\in L$, else if one of them is $\mathbb{N}$, then $\mathbb{N}\cup x = \mathbb{N} \in L$

Let's consider the infinite family of elements in this lattice $c = \{0\}, \{2\}, \{4\}, ..., \{2n\}, \forall n\in \mathbb{N}$: 
The points in $C$ do not have a LUB in $L$! 

While this structure is a lattice, it is not a *complete lattice*: pairs (or more in general, finite collections of elements)
have a LUB (join, or in this case $\cup$ suffices), but not every infinite collection does. 
To handle the join over an infinite collection of elements, we need more guarantees. 

The same happens for meet: let's consider $L' = \{S\;|\; S = \empty \lor S \subseteq \mathbb{N} : |S| = \infty\}$, which looks  something like: 
```
         ℕ
       / | \
      /  |  \
  ℕ\{0}  |  ℕ\{2} ...
         |      |
        ℕ\{1}   |
            \   |
             \  |
            ℕ\{1, 2}
             ...
        {}
```
We can build an infinite collection of elements whose intersections is finite, for example consider 
$c =  \mathbb{N}\backslash \{1\}, \mathbb{N}\backslash \{1,2\}, \{4\}, ..., \mathbb{N}\backslash \{1, 2, ..., k + 1\}, \forall k\in \mathbb{N}$. 
any finite intersection of the elements in $c$ will only miss a finite number of elements ("from the highest $k$ onwards"), however
the intersection over all the elements in $c$ fill have finite cardinality and will eventually like $\{0\} \notin L'$, since $\{0\}$ is common
to every element of the collection. 

Incomplete lattices often have the structure of $L$: everything works up to finite collections of elements, but when 
meet/join need to handle an infinite number of elements, the structure stops working.

Other examples: 
- $\mathbb{Q}\cap[0, 1]$ with order relation $\le$ is not complete, e.g. $\sqrt 2$ is missing and sub-lattices around that area will not have the appropriate upper/lower bounds.
- $\mathbb{R}\cap[0, 5]$ with order relation $\le$ is a complete lattice
- In Lean, $Prop$ with order relation $\implies$ is a lattice, where join is disjunction and meet is conjunction, $\bot$ is false and $\top$ is true

Moving on with the theorem statement, we need to define a **monotone function** on a partial order $\le$. 
Let $f : A \rightarrow B$, where $A$ has a partial order given by $\le$ and $B$ has a partial order given by $\sqsubseteq$. 

$f$ is monotone $\iff \forall a, a'\in A, a\le a' \implies f(a) \sqsubseteq f(a')$ with $f(a), f(a')\in A$

Basically, a function is monotone if it preserves the order relation existing in the codomain into the domain, 
without establishing a relation between the two order relation themselves (no hypothesis is required for $le, \sqsubseteq$). 

We then define a **fixed point**: given $f : A\rightarrow A$ and $x\in A$, we say $x$ is a fixed point (FP) $\iff x = f(x)$. 

We now have enough definitions to go back to the theorem statement: given a function $f: L\rightarrow L$ that is monotone, with 
$L$ being a complete lattice, then we know: 
1. $f$ has a FP
2. let $S$ be the set of FPs of $f$, then $\exists$ at least one *least* FP, i.e., one element $s\in S$ smaller than all other FPs
3. the set of FPs $S$ is a complete sub-lattice of $L$

Example: let's consider $L = \{x \;|\; x\subseteq \mathbb{N}\}$ with partial order $\subseteq$: 
- $\bot = \empty$ 
- $\top = \mathbb{N}$
- meet = $\cap$ 
- join = $\cup$ 
and think about a few functions: 
1. $f(x) = x$, in which case the set of FPs is $S = L$
2. $f(x)=\{1\}$, meaning $S$ only contains one element: $\{1\}$. Note that $S = \{\{1\}\}$ is itself a complete lattice!
3. $f(x) = x\cup \{1, 2\}$ with fixed points $\{1, 2\}$, $\{1, 2, 3\}$, ... and therefore $S = \{x \;|\; \{1, 2\} \subseteq x\}$ : 
    $S$ is the set of subsets $x$ of $\mathbb{N}$ such that the subset $\{1, 2\}$ is contained in $x$. 
    With this in mind, we define for the sublattice: 
    - $\top = \mathbb{N}$ 
    - $\bot = \{1, 2\}$
    - meet = $\cap$: even in the case infinite meet, the resulting subset is $\{1, 2\}$ and this be part of the sub-lattice ($\{1, 2\}\subseteq x, \forall x \in S$)
    - join = $\cup$, again the infinite union is $\mathbb{N}$ which is in $S$
    - given $x, y\in S$: LUB = $x\cup y\in S$ given that $1, 2$ will still be in the union 
    - given $x, y\in S$: GLB = $x\cap y\in S$ given that at least $1, 2$ are always in the intersection

The final objective of my effort with this theorem, is to understand its implication in type theory and in particular 
concerning types definitions in Lean, so let's try to move towards that domain. 

Let's consider $L = \{x | x \subseteq \mathbb{N}\}$ and introduce the concept of *indicator function* $I$: 
when we say $\forall S, S \subseteq \mathbb{N}$, we really are defining a function $I_S: \mathbb{N}\rightarrow \mathbb{B}$ where
$a\in S \iff I_S(a) = True$. 
We can re-interpret lattices considering this idea. 
$\mathbb{B}$ is a complete lattice, with $\top = True$ and $\bot = False$, $meet = \&\&$, $join = ||$. 
From this lattice, we derive a new lattice $\mathbb{N}\rightarrow \mathbb{B}$ by *pointwise definition*: 
- join: given $f, g\in \mathbb{N}\rightarrow \mathbb{B}$ then $f\cup g: \mathbb{N}\rightarrow \mathbb{B}$ is the join on functions such that: 
    $n : \mathbb{N} \mapsto f(n)\cup g(n)$. For each point $n$, we consider the behavior of $f, g, join$ in the $\mathbb{B}$ domain.
- meet: we use the same approach, given $f, g\in \mathbb{N}\rightarrow \mathbb{B}$ then $f\cup g: \mathbb{N}\rightarrow \mathbb{B}$ is the meet on functions such that: $n : \mathbb{N} \mapsto f(n)\cap g(n)$. For each point $n$, we consider the behavior of $f, g, meet$ in the $\mathbb{B}$ domain. 


# Knaster-Tarski theorem in analysis

A more analytical explanation. 
We construct a lattice using $\mathbb{N}$ and adding two arbitrary elements $\top$ and $\bot$: 
```
        ⊤
      0, 1, 2, ...
        ⊥
```
forming a complete lattice with: 
- LUB($\empty$) = $\bot: any element is an upper bound of an empty set 
- LUB($n$) = $n$
- LUB($n, m$) = $\top$

We now consider any set X: the space of functions $[X, L] = \{f \;|\; X\rightarrow L\}$ will be a complete lattice, with 
- bottom function $\bot (x)= \bot$, "spits out $\bot$ for any input"
- join function $f\cup g : x\mapsto f(x)\cup g(x)$
- meet function $f\cap g : x\mapsto f(x)\cap g(x)$

in particular, the lattice is complete, in fact: 
- infinite join given a family of functions $f_1\cup ... \cup f_n : x\mapsto f_1(x)\cup ... \cup f_n(x)$: the join of infinitely many elements is the LUB. This still belongs in $L$, since all $f_i$ do - also $L$ was complete in the first place, meaning that infinite join belongs in $L$!
- infinite meet given a family of functions $f_1\cap ... \cap f_n (x): x\mapsto f_1(x)\cap ... \cap f_n(x)$: the meet of infinitely many elements is the GLB. The same reasoning as join applies.

We instantiate this construction with $X = \mathbb{N}$ and $L = \mathbb{N}$ equipped with $\bot, \top$ ($L=\mathbb{N}\top\bot$). 
This construction contains, for example:
- almost identity function `fun (x : ℕ) => x`
- always-returns-bottom function `fun (x : ℕ) => ⊥`
- weird function 1 `fun (x : ℕ) => if x = 0 then 1 else ⊥`
- weird function 2 `fun (x : ℕ) => if x = 0 then 1 else if x = 1 then 1 else ⊥`
- weird function 3 `fun (x : ℕ) => if x = 0 then 1 else if x = 1 then 1 else if x =- 2 then 2 else ⊥`
- weird function 4 `fun (x : ℕ) => if x = 0 then 1 else if x = 1 then 1 else if x =- 2 then 2 else if x = 3 then 6 else ⊥`

these weird functions are all finite approximations of the factorial function (up to a- certain `x`).

We now can build a monotone function from this space of functions to itself $m = (\mathbb{N} \rightarrow L) \rightarrow (\mathbb{N} \rightarrow L)$, 
i.e. $m(f) = x\mapsto if\;\; x = 0\;\; then\; 1\;\; else\;\; x * f(n - 1)$: 
```
                         0          1          2          3          4          5       ...
    f0 = fun x => ⊥      ⊥          ⊥ ...
    f1 = m f0            1          ⊥          ⊥ ... we cheat, because we're multiplying a natural number by ⊥!
    f2 = m f1            1          1          ⊥          ⊥         ⊥ ...
    f3 = m f2            1          1          2          ⊥          ⊥ ...
    f4 = m f3            1          1          2          6          ⊥ ...
    f1 ∪ f2              1          1          ⊥ ... we take the join (upper) element of {f1(0), f(0)}, etc.
```
given two said functions we define $f \le g \iff \forall x, f(x) ≤ g(x) \implies m(f) \le m(g)$

A concrete construction of naturals using this setting: 
- we consider a function $f(S) = \{0\}\cup \{succ(s) \;|\;s\in S\}
- this function is monotone with respect to $\subseteq$: in fact $S_1\subseteq S_2 \implies f(S_1)\subseteq f(S_2)$
- according to Knaster Tarski, the set of fixed points of $f$ over a complete lattice is itself a complete lattice: 
    in this case the fixed point is a set $S = f(S)$: $\mathbb{N}$ is the fixed point itself.
In other words, Knaster Tarski guarantees that the recursive function defining the set has a fixed point and therefore 
the set actually *exists*!

For example, let's consider a function with no fixed points: $f(x) = x + 1$ in the lattice $\mathbb{R}[0,1]$: 
we can't get a set of elements out of this function. 


Think about the lattice $\mathbb{R}[0,1]$ for "normal functions" (i.e. real analysis).
Then think about sets: e.g. the set of naturals $S$ (each set is a node of the lattice), with the lattice 
structure given by ∪$\cap, \cup$, the monotone function we consider to reason about the theorem is such that: 
$S\mapsto \{zero\}\cup \{\forall s\in S, succ(s)\}$: 
Knaster Tarski allows to use the recursive definitions to create an actual "math object".

For example, if we consider a function with no fixed points over $\mathbb{R}\rightarrow \mathbb{R}$, e.g. 
$f (x) = x + 1$
In lean, the *positivity check* verifies that the function we're using to build a type is monotone!

For example, when defining the type `Nat`, the constructor might have a parameter of type `Nat`, e.g. : 
```
    Nat : 
    | zero : Nat
    | succ (n : Nat) : Nat

```
the positivity check ensures that the function `f` mapping a set of candidates for `Nat` to a new, 
larger set is indeed a monotone function on the lattice of all possible subsets of `Nat`.
On the complete lattice $L = \{S \;|\;\ S\subseteq \mathbb{N}\}$, the function we use to construct
the type is $f(S) = \{0\}\cup \{\forall s\in S, succ(s)\}$ and checking its monotonicity ensures that the 
$f$ has a fixed point, i.e. a set $S = f(S)$ ensuring the validity of the construction. 


*I am on a quest for an example with a non monotone function and would love a suggestion on this!*