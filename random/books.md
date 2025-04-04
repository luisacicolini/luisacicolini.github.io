# the method of coalgebra - j. rutten

## algebras

### def
A Functor $\mathcal{F}: \mathcal{C} \rightarrow \mathcal{D}$, where $\mathcal{C}$ and $\mathcal{D}$ are categories, 
assigns (1) to any object $A\in \mathcal{C}$ an object $\mathcal{F}(A)\in \mathcal{D}$, (2) to any arrow $f:A\rightarrow B\in \mathcal{C}$ an 
arrow $\mathcal{F}(f) : \mathcal{F}(A) \rightarrow \mathcal{F}(B) \in \mathcal{D}$, such that (3) $\mathcal{F}$ preserves composition and identies. 

### def
Let $\mathcal{F}: \mathcal{C} \rightarrow \mathcal{C}$ be a functor. An $\mathcal{F}-$algebra is a pair $(A,\alpha)$ consisting of an obhect $A$ and an arrow  $\alpha:\mathcal{F}(A)\rightarrow A$. $\mathcal{F}$ is the type, $A$ is the carrier, $\alpha$ is the structure map of the algebra.

### example
$(\mathbb{N}, [zero, succ])$ is an $N$-algebra, defined via functor $N:Set\rightarrow Set$ for everty set $X$ by $N(X)=1+X$

### def
Let $F: \mathcal{C} \rightarrow \mathcal{C}$ be a functor. 
An homomorphism of $F$-algebras $(A,\alpha)$, $(B,\beta)$ is an arrow $f:A\rightarrow B$ such that $f\circ \alpha = \beta\circ F(f)$:
- $F(A)\xrightarrow{F(f)}F(B)$
- $F(A)\xrightarrow{\alpha}A$
- $F(B)\xrightarrow{\beta}B$
- $A\xrightarrow{f}B$
For this definition to make sense $F$ must be a functor and act not only on objects, but also on arrows.

## coalgebras

### def
Let $\mathcal{F}: \mathcal{C} \rightarrow \mathcal{C}$ be a functor. An $\mathcal{F}-$coalgebra is a pair $(A,\alpha)$ consisting of an obhect $A$ and an arrow 
$\alpha:A\rightarrow \mathcal{F}(A)$. $\mathcal{F}$ is the type, $A$ is the carrier, $\alpha$ is the structure map of the coalgebra.

Coalgebras are like algebras, but the structure map is reversed.

### def
Let $F: \mathcal{C} \rightarrow \mathcal{C}$ be a functor. 
An homomorphism of $F$-algebras $(A,\alpha)$, $(B,\beta)$ is an arrow $f:A\rightarrow B$ such that $\beta\circ f = F(f)\circ \alpha$:
- $F(A)\xrightarrow{F(f)}F(B)$
- $A\xrightarrow{\alpha}F(A)$
- $B\xrightarrow{\beta}F(B)$
- $A\xrightarrow{f}B$
For this definition to make sense $F$ must be a functor and act not only on objects, but also on arrows.

Coalgebras are the dual form of algebra and are derived via the categorical principle of duality.

## inductive and coinductive definitions

### def
An initial $F$-algebra is an $F$-algebra that is an \textit{initial object} in the category of all $F$-algebras and $F$ $(A,\alpha)$, $(B,\beta)$ is an arrow $f:A\rightarrow B$ such that $\beta\circ f = F(f)\circ \alpha$:
    - $F(A)\xrightarrow{F(f)}F(B)$
    - $A\xrightarrow{\alpha}F(A)$
    - $B\xrightarrow{\beta}F(B)$
    - $A\xrightarrow{f}B$
For this definition to make sense $F$ must be a functor and act not only on objects, but also on arrows.


# modern automata theory - z. \'esik

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

## context-free grammars and algebraic systems

