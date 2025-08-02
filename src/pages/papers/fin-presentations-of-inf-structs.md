---
title: "finite presentations of infinite structures: automata and interpretations - a. blumensath et al."
---

#### def
Some domanis of infinite but finitely presentable structures: 
- recursive structure: countable structures whose functions and relations are computable, their domain is typically too large 
- constraint database: modern database model admitting infinite relations presented by quantifier-free formulae over a fixed background structure. A constraint database consists of a context structure $\text{\frak{U}}$ and a set $\{\phi_1, ..., \phi_m\}$ of quantifier-free formulae defining the database relations
- metafinite structures: two-sorted structures consisting of a finite structure $\text{\frak{U}}$, a background structure $\text{\frak{R}}$ (usually infinite but fixed) and a class of weight functions from finite to infinite part. For example: finite graphs whose edges are weighted by real numbers. 
- automatic structures: their functions and relations are represented by finite automata. A relational structure $\text{\frak{U}}=(A, R_1, ..., R_m)$ is automatic if there exists a regular language $L_\delta \subseteq \Sigma^*$ naming the elements in $\text{\frak{U}}$ and a function $\nu : L_\delta \rightarrow A$ mapping every $w\in L_\delta$ to the element of $\text{\frak{U}}$ that it represents. 
$\nu$ must be surjective but not necessarily injective (everything has a name, can have more than one). 
Finite automata must be able to recognize (1) whether two words in $L_\delta$ name the same elements and (2) for each $R_i \in \text{\frak{U}}$ whether a given tuple of words in $L_\delta$ names a tuple in $R_i$.
Using automata over infinite words we obtain $\omega$-automatic structures, which may have uncountable cardinality. 
Overall, automatic structures admit effective and automatic evaluation on all first-order queries. 

#### theorem
The model-checking problem for $FO(\exists^\omega)$, first-order logic extended by the quantifier "there are infinitely many", is decidable on the domain of $\omega$-automatic structures. 

- tree-automatic structures: defined by automata on finite or infinite trees, natural generalization of automatic structures 
- tree-interpretable structures: structures that are interpretable on the infinite binary tree $\mathcal{T}^2=(\{0,1\}^*, \sigma_0, \sigma_1)$ via one-dimensional monadic second-order interpretation. 
They form a proper subclass of automatic structures that generalizes various notions of infinite graphs. Examples: context-free graphs (= configuration graphs of PDA), HR- and VR-equational graphs, prefix-recognizable graphs.

#### theorem
For any graph $G=(V,(E_a)_{a\in A})$ the following are equivalent:  
(1) $G$ is tree-interpretable,  
(2) $G$ is prefix-recognizable,  
(3) $G$ is VR-equational,  
(4) $G$ is the restriction to a regular set of the configuration graph of a PDA with $\epsilon$-transitions.

#### theorem
- tree-constructible structures: Caucal hierarchy  
- ground tree rewriting graphs 

#### def
A relational structure $\text{\frak{U}}$ is automatic if there exists a regular language $L_\delta \subseteq \Sigma^*$ and a surjective function $\nu : L_\delta \rightarrow A$ such that the relation  
$$
L_\epsilon := \{(w, w')\in L_\delta \times L_\delta\;|\;\nu(w) = \nu(w')\} \subseteq \Sigma^* \times \Sigma^*
$$  
and, for all predicates $R\subseteq A^r$ of $\text{\frak{U}}$, the relations  
$$
L_R := \{\overline{w}\in (L_\delta)^r\;|\;(\nu(w_1),...,\nu(w_r))\in R\} \subseteq (\Sigma^*)^r
$$  
are regular. An arbitrary structure is automatic if and only if its relational variant is.  
All finite structures are automatic, and all automatic structures are $\omega$-automatic.

#### def
Let $L$ be a logic and $\text{\frak{U}}=(A, R_0,..., R_n)$ and $\text{\frak{B}}$ relational structures. A (k-dimensional) $L$-interpretation of $\text{\frak{U}}$ in $\text{\frak{B}}$ is a sequence  
$$
\mathcal{I} := \langle \delta(\overline{x}), \epsilon(\overline{x}, \overline{y}), \phi_{R_0}(\overline{x}_1,...,\overline{x}_r),...., \phi_{R_n}(\overline{x}_1,...,\overline{x}_s)\rangle
$$  
of $L$-formulae of the vocabulary of $\text{\frak{B}}$ (where each tuple $\overline{x}, \overline{y}, \overline{x_i}$ consists of $k$ variables) such that  
$$
\text{\frak{U}} \cong \mathcal{I}(\text{\frak{B}}) := (\delta^{\text{\frak{B}}},(\phi_{R_0})^{\text{\frak{B}}},...,(\phi_{R_n})^{\text{\frak{B}}})/\epsilon^{\text{\frak{B}}}
$$

#### theorem
If $\mathcal{I} : \text{\frak{U}} \leq_{FO} \text{\frak{B}}$, then  
$$
\text{\frak{U}} \models \phi (\mathcal{I}(\overline{b})) \iff \text{\frak{B}} \models \phi^{\mathcal{I}} (\overline{b}) \quad \text{for all } \phi\in FO \text{ and } \overline{b} \subseteq \delta^{\text{\frak{B}}}
$$

This theorem states that for any logic $L$, a notion of interpretation is suitable if a similar statement holds and if the logic is closed under $\phi \mapsto \phi^\mathcal{I}$.  
The classes of automatic and $\omega$-automatic structures are closed under  
(1) extensions by definable relations,  
(2) factorizations by definable congruences,  
(3) substructures with definable universe, and  
(4) finite powers.

### model checking and query evaluation

- **model checking**: given a structure $\text{\frak{U}}$, a formula $\phi(\overline{x})$, and a tuple of parameters $\overline{a}$ in $\text{\frak{U}}$, decide whether $\text{\frak{U}}\models \phi(\overline{a})$  
- **query evaluation**: given a presentation of a structure $\text{\frak{U}}$ and a formula $\phi(\overline{x})$, compute a presentation of $(\text{\frak{U}},\phi^{\text{\frak{U}}})$, i.e., given automata for the relations of $\text{\frak{U}}$, construct an automaton that recognizes $\phi^{\text{\frak{U}}}$.

All first-order queries on ($\omega$-)automatic structures are computable since:

#### theorem
If $\text{\frak{U}} \leq \text{\frak{B}}$ and $\text{\frak{B}}$ is ($\omega$-)automatic, then so is $\text{\frak{U}}$.  
Every ($\omega$-)automatic structure has an injective presentation.  
Reachability is undecidable for automatic structures.  
It is undecidable whether two automatic structures are isomorphic.
