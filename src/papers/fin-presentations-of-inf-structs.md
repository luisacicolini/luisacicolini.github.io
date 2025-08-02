## finite presentations of infinite structures: automata and interpretations - a. blumensath et al.

#### def
Some domanis of infinite buf finitely presentable structures: 
- recursive structure: countable structures whose functions and relations are computable, their domain is typically too large 
- constraint database: modern database model admitting infinite relations presented by quantifier-free formulae over a fized background structure. A constraint database consists of a context structure $\textfrak{U}$ and a set $\{\phi_1, ..., \phi_m\}$ of quantifier-free formulae defining the database relations
- metafinite strucutres: two-sorted structures consisting of a finite structure $\textfrak{U}$, a background structure $\textfrak{R}$ (usually infinite but fixed) and a class of weight functions from finite to infinite part. For example: finite graphs whose edges are weighted by real numbers. 
- automatic structures: their functions and relations are represented by finite automata. A relational strucutre $\textfrak{U}=(A, R_1, ..., R_m)$ is automatic if there exists a regular language $L_\delta \subseteq \Sigma^*$ naming the elements in $\textfrak{U}$ and a function $\nu : L_\delta \rightarrow A$ mapping every $w\in L_\delta$ to the element of $\textfrak{U}$ that it represents. 
$\nu$ must be surjective but necessarily injective (everything has a name, can have more than one). 
Finite automata must be able to recognize (1) whether wro words in $L_\delta$ name the same elements and (2) for each $R_i \in \textfrak{U}$ whether a given tuple of words in $L_\delta$ names a tuple in $R_i$.
Using automata over infinite words we obtain $\omega-$automatic structures, which may have uncountable cardinality. 
Overall, automatic structures admit effective and automatic evaluation on all first-order queries. 
#### theorem
The model-checking problem for $FO(\exists^\omega)$, first order logic extended by quantifier "there are infinitely many" is decidable on the domain of $\omega$-automatic structures. 
- tree-automatic structures: defined by automata on finite or infinite trees, natural generalization of automatic structures 
- tree-interpretable structures: structures that are interpretable on the infinite binary tree $\mathcal{T}^2=(\{0,1\}^*, \sigma_0, \sigma_1)$ via one-dimensional monadic second-order interpretation. 
they form a proper subclass of automatic structures that generalizes various notions of infinite graphs. Examples: context free graphs (= configuration graphs of PDA), HR- and VR-equational graphs, prefix-recognizable graphs.
#### theorem
For any graph $G=(V,(E_a)_{a\in A})$ the followign are equivalent: 
(1) G is tree-interpretable,
(2) G is prefix-recognizable,
(3) G is VR-equational,
(4) G is the restriction to a regular set of the configuration graph of a PDA with $\epsilon$-transitions.
#### theorem
- tree-constructible structures: Caucal hierarchy
- ground tree rewriting graphs 

#### def
A relational structure $\textfrak{U}$ is automatic if there exists a regular language $L_\delta \subseteq \Sigma^*$ and a surjective function $\nu : L_\delta \rightarrow A$ such that the relation 
$$L_\epsilon := \{(w, w')\in :L_\delta \times L_\delta\;|\;\nu w = \nu w'\}\subseteq \Sigma^* \times \Sigma^*$$
and, for all predicates $R\subseteq A^r$ of $\textfrak{U}$, the relations 
$$L_R := \{\overline{w}\in (L_\delta)^r\;|\;(\nu w_1,...,\nu w_r)\in R\}\subseteq (\Sigma^*)^r$$
are regular. An arbitrary structure is automatic iif its relational variant is. 
All finite structures are automatic, and all automatic structures are $\omega$-automatic.
#### def
Let $L$ be a logic and $\textfrak{U}=(A, R_0,..., R_n)$ and $\textfrak{B}$ relational structures. A (k-dimensional) L-interpretation of $\textfrak{U}$ in $\textfrak{B}$ is a sequence
$$\mathcal{I} := \langle \delta(\overline{x}), \epsilon(\overline{x}, \overline{y}), \phi_{R_0}(\overline{x}_1,...,\overline{x}_r),...., \phi_{R_n}(\overline{x}_1,...,\overline{x}_s)\rangle$$
of L-formulae of the vocabulary of $\textfrak{B}$ (where each tuple $\overline{x}, \overline{y}, \overline{x_i}$ consists of k variables) such that
$$\textfrak{U} \cong \mathcal{I}(\textfrak{B}) := (\delta^\textfrak{B},(\phi_{R_0})^\textfrak{B},...,(\phi_{R_n})^\textfrak{B})/\epsilon^\textfrak{B}$$

#### theorem
If $\mathcal{I} : \textfrak{U}\leq_{FO} \textfrak{B}$, then 
$$\textfrak{U} \models \phi (\mathcal{I}{\overline{b}})\;\; iif \;\; \textfrak{B}\models \phi^\mathcal{I} (\overline{b}) \;\; for\; all\; \phi\in FO\;\; and \overline{b}\subseteq \delta^\textfrak{B}$$

This theorem states that for any logic L a notion of interpretation is suitable if a similar statement holds and if the logic is closed under $\phi \mapsto \phi^\mathcal{I}$
The classes of autimatic, $\omega$-automatic structures are closed under 
(1) extensions by definable relations, (2) factorizations by definable congruences, (3) substructures with definable universe and (4) finite powers. 

### model checking and query evaluation
- model checking: given a structure $\textfrak{U}$, a formula $\phi(\overline{x})$ and a tuple of parameters $\overline{a}$ in $\textfrak{U}$, decide whethere $\textfrak{U}\models \phi(\overline{a})$
- query evaluation: given a presentation of a structure $\textfrak{U}$ and a formula $\phi(\overline{x})$, compute a presentation of $(\textfrak{U},\phi^\textfrak{U})$, i.e., given automata for the relations of $\textfrak{U}$ 
construct an automaton that recognizes $\phi^\textfrak{U}$.
All first-order queries on ($\omega-$)automatic structures are computable since: 
#### theorem
If $\textfrak{U}\leq \textfrak{B}$ and $\textfrak{B}$ is ($\omega$-)automatic, then so is $\textfrak{U}$.
Every ($\omega$-)automatic structure has an injective presentation.
Reachability is undecidable for automatic structures. 
It is undedicable whether two automatic structures are isomorphic.
