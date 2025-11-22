---
layout: ../../layouts/BaseLayout.astro
title: "a small intro to category theory"
date: "02.10.2025"
---
# a small intro to category theory

to model something we can use: 
- sets, functions between sets
- vector spaces, maps between vec spaces 

    *btw. small ex-cursus on vector spaces:*

    A *vector space* is a set whose elements, often called vectors, can be added together and multiplied ("scaled") by numbers called scalars. 
    The operations of vector addition and scalar multiplication must satisfy certain requirements, called vector axioms. 
    Real vector spaces and complex vector spaces are kinds of vector spaces based on different kinds of scalars: real numbers and complex numbers. 
    Scalars can also be, more generally, elements of any field.
- types, function between types (e.g. in Lean)
    e.g. $A \oplus B$ corresponds to 
        ```
        inductive Sum A B
                        | inj_l : A => Sum A B
                        | inj_r : B => Sum A B
        ```
- groups, group homorphisms
- dialects in MLIR
...

A *category* is a 
- collection of objects O (O : Set, e.g. O is everything that lives in Type)
- collection of morphisms $\forall o1, o2 \in O : Hom(o1, o2)$ (or: $Hom: O \rightarrow O -> Set$)

Where a *homomorphism* is a map between two algebraic structures of the same type that preserves the operations of the structures. 
We define
- composition "$\circ:$" : $\forall A, B, C \in O : Hom (B, C) \times Hom (A, B) \rightarrow Hom (A, C)$ (recall: $h (*) = g \circ f (*) = g(f(*))$)
- identity : $\forall A \in O : \exists IdA \in Hom (A, A)$ : 
    1. $\forall g: B \rightarrow A, IdA \circ g = g$
    2. $\forall h: A \rightarrow B, h \circ IdA = h$
- associativity : $\forall f, g, h, (f \circ g) \circ h : f (g \circ h)$

Examples:

1. Let $O = \{X, Y, Z, ...\}$ collection of sets 
- given $X, Y \in O : Hom (X, Y) = \{f : X \rightarrow Y\}$ where $\circ$ is the function composition
- $\forall A \in O, IdA = [x \in A \mapsto x ]$
- the product for this collection of objects can be proven to be equivalent to the cartesian product
2. Let $O = \{X, Y, Z, ...\}$ collection of natural numbers
- $Hom (X, Y) = \{ set\; containing\; a\; single\; empty\; set\; \{*\} | x \le y, \empty\; otherwise\}$ where $\{*\}$ is singleton
- $Hom (Y, Z) \circ Hom (X, Y) : Hom (X, Z)$, like $Y \le Z \circ X \le Y = X \le Z$
3. Let $O = \{A, B, C, ...\}$ collection of natural numbers
- $Hom (A, B) = "matrices\; of\; dimension\; A \times B"$
- $Hom (B, C) \circ Hom (A, B)$ : matrix multiplication
- $IdA$ = identity matrix $A \times A (Hom (A, A))$
4. Let $O = \{P, Q, R, ...\}$ collection of propositions about natural numbers
- $Hom (P, Q)$ = set of all proofs that $P \implies Q$ (note that false implies everything)
- $Hom (Q, R) \circ Hom (P, Q) : P \implies Q \implies R$(chain composition)
- in this case one product can be conjunction (by the def. of product)


We define product operation $\times$: $\forall C \;|\; s1 : C \rightarrow A, s2 : C \rightarrow B, \exists!\; t \:|\: C \rightarrow A \times B$ (note that the product is unique *modulo* isomorphisms.)
```
                    -------- C --------
                    |        : t      |              
                    |        :        |              
                    |        v        |              
                 s1 |      A x B      | s2                
                    |   p1 |   |  p2  |              
                    |      |   |      |
                    |      v   v      |
                    -----> A   B <-----
```
Note that t is unique. If this happens we say "the diagram commutes": $s1 = p1 \circ t$, $s2 = p2 \circ t$.

In the natural number with \le  example:
```
                    n       m   
                    ^       ^    
                    |\     /|       
                    | \   / |       
                    |  \ /  |
                    |   k   |
                    |   ^   |
                    |   :   |
                    --- l ---
```
$k \le n$, $k \le m$, $\forall l, l \le n \land l \le m \implies l \le k$

Some examples:

1. 
    ```
     4       9       
     ^       ^    
     |\     /|       
     | \   / |       
     |  \ /  |
     |   3   |
     |   ^   |
     |   :   |
     --- 2 ---
    ```
    $3 \le 4, 3 \le 9$ and $\forall l, l \le 4 \land l \le 9 \implies l \le 3$ : this is not correct, since e.g. $l = 4$ does not satisfy $4 \le 3$
2. 
    ```
     4       9     
     ^       ^    
     |\     /|       
     | \   / |       
     |  \ /  |         
     |   4   |
     |   ^   |
     |   :   |
     --- 2 ---
    ```
    $4 \le 4, 4 \le 9$ and $\forall l, l \le 4 \land l \le 9 \implies l \le 3$ : this is correct, since *any number* that is $\le 4\; (0, 1, 2, 3)$
  and $\le 9\; (0, 1, 2, 3, 4, 5, 6, 7, 8)$ is also $\le 4$    
3.          
    ```
     P       Q    
     ^       ^    
     |\     /|       
     | \   / |       
     |  \ /  |        
     | P & Q |
     |   ^   |
     |   :   |
     --- R ---
    ```
    $(P \land Q) => P, (P \land Q) => Q$ and $\forall R, (R \implies P \land R \implies Q) \implies (R \implies P \land Q)$ : this is correct, since *any prop* that $\implies$ P and Q also $\implies$ P & Q
4. Let $O = category\; of\; sets\; of\; cardinality \le 2$: even though it does not have all products. 
    Consider $A = \{\empty, \{\empty\}\}$ and $B = \{\empty, \{\empty\}\}$, we know that the product should have four elements! 
    but the category $O$ only contains elements with size $\le 2$, so this such product does not exist


A few last notes:
- *everything is just a morphism*
- a product is the limit of some shape and some common shapes are given names: meaning that asking the limits of a shape unravels to the definition of a product
- not every category has products! if something satisfying those properties exists we call it a property, but that does not always happen.



A *colimit* is like product but arrows go in the opposite direction:
```
        ------> D <-------
        |       ^ t      |
        |       :        |
        |       :        |
    s1  |       Q        | s2
        |  p1 ^   ^  p2  |
        |     |   |      |
        |     |   |      |
        ----- A   B ------
```
for sets this corresponds to disjoint union ("smallest thing")

example 1: 
```
                 f
              A --> B
            g |     :
              v     v
              C .. > B |_| C / f ~ g ("B disjoint union C quotiented by ~")
```
the product is unique modulo isomorphisms

example 2: 
```
             C ---- D
            A        E              ===>                E,A         or          A,C - D,E
            |       /                                 /  |                       |  /
            |      /                               F,D - B,C                     B,F
            |     /
            B    F
```
defining different colimits gives us different ways to *glue up* these things and define different shapes (e.g. torus)
\{\rightarrow\} category theory discusses the *glueing*
