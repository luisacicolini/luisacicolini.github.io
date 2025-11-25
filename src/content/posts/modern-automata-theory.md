---

title: "modern automata theory"
date: 2024-06-15
---
# [modern automata theory](https://repositum.tuwien.at/bitstream/20.500.12708/20717/1/Esik-2012-Modern%20Automata%20Theory-ao.pdf)
### a book by z. esik, w. kuich

## finite automata
### def
A semiring is a set $A$ equipped with two binary operations $+$ and $\cdot$ and two constant elements $0,1$ such that:
1. $\langle A, +, 0\rangle$ is a commutative monoid (= set of elements with an associative, commutative binary operation and an identity element)
2. $\langle A, \cdot, 1\rangle$ is a monoid (= set of elements with an associative binary operation and an identity element)
3. the following distribution laws hold for all elements: $a \cdot (b+c) = a \cdot b + a \cdot c$, $(a + b)\cdot c = a\cdot c + b\cdot c$
4. $0\cdot a = a\cdot 0 = 0$ for every $a$

### def
A starsemiring is a semiring equipped with an additional unary operation $*$. Example of starsemirings: $\langle \mathbb{B}, +, \cdot, *, 0, 1 \rangle$ with $0*=1*=1$

### def
A Conway semiring is a starsemiring that satisfies the sum-star-equation:
$$(a+b)^* = (a^*b)^*a^*$$
and the product-star-equation:
$$(ab)^* = 1 + a(ba)^*b$$
Example: semiring $\langle 2^{\Sigma^*}, \cup, \cdot, *, \emptyset, \{ \epsilon \} \rangle$ of formal languages over $\Sigma$ with $L^*=\cup_{n\geq 0}L^n$ for all $L \subseteq \Sigma^*$

A way to highlight the connection between graphs and automata:
### def
Consider a Conway semiring $A$ and its subset $A'$. 
A finite automaton $A'$-automaton $\textfrak{U}=(n,M,S,P), n \geq 1$ is given by:
1. a transition matrix $M\in (A' \cup \{0,1\})^{n\times n}$
2. an initial state vector $S\in (A' \cup \{0,1\})^{1\times n}$
3. a final state vector $P\in (A' \cup \{0,1\})^{n\times 1}$
The behavior $||\textfrak{U}||$ of $\textfrak{U}$ is defined by 
$$||\textfrak{U}|| = \Sigma_{1 \leq i_1, i_2 \leq n} S_{i_1} (M^*)_{i_1,i_2} P_{i_2} = S M^* P$$

