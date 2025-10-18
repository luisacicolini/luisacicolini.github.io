---
layout: ../../layouts/BaseLayout.astro
title: "the method of coalgebra - j. rutten"
date: "06.28.2024"
---

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
