

# from books

## the method of coalgebra - j. rutten

### algebras

#### def
A Functor $\mathcal{F}: \mathcal{C} \rightarrow \mathcal{D}$, where $\mathcal{C}$ and $\mathcal{D}$ are categories, 
assigns (1) to any object $A\in \mathcal{C}$ an object $\mathcal{F}(A)\in \mathcal{D}$, (2) to any arrow $f:A\rightarrow B\in \mathcal{C}$ an 
arrow $\mathcal{F}(f) : \mathcal{F}(A) \rightarrow \mathcal{F}(B) \in \mathcal{D}$, such that (3) $\mathcal{F}$ preserves composition and identies. 

#### def
Let $\mathcal{F}: \mathcal{C} \rightarrow \mathcal{C}$ be a functor. An $\mathcal{F}-$algebra is a pair $(A,\alpha)$ consisting of an obhect $A$ and an arrow  $\alpha:\mathcal{F}(A)\rightarrow A$. $\mathcal{F}$ is the type, $A$ is the carrier, $\alpha$ is the structure map of the algebra.

#### example
$(\mathbb{N}, [zero, succ])$ is an $N$-algebra, defined via functor $N:Set\rightarrow Set$ for everty set $X$ by $N(X)=1+X$

#### def
Let $F: \mathcal{C} \rightarrow \mathcal{C}$ be a functor. 
An homomorphism of $F$-algebras $(A,\alpha)$, $(B,\beta)$ is an arrow $f:A\rightarrow B$ such that $f\circ \alpha = \beta\circ F(f)$:
- $F(A)\xrightarrow{F(f)}F(B)$
- $F(A)\xrightarrow{\alpha}A$
- $F(B)\xrightarrow{\beta}B$
- $A\xrightarrow{f}B$
For this definition to make sense $F$ must be a functor and act not only on objects, but also on arrows.

### coalgebras

#### def
Let $\mathcal{F}: \mathcal{C} \rightarrow \mathcal{C}$ be a functor. An $\mathcal{F}-$coalgebra is a pair $(A,\alpha)$ consisting of an obhect $A$ and an arrow 
$\alpha:A\rightarrow \mathcal{F}(A)$. $\mathcal{F}$ is the type, $A$ is the carrier, $\alpha$ is the structure map of the coalgebra.

Coalgebras are like algebras, but the structure map is reversed.

#### def
Let $F: \mathcal{C} \rightarrow \mathcal{C}$ be a functor. 
An homomorphism of $F$-algebras $(A,\alpha)$, $(B,\beta)$ is an arrow $f:A\rightarrow B$ such that $\beta\circ f = F(f)\circ \alpha$:
- $F(A)\xrightarrow{F(f)}F(B)$
- $A\xrightarrow{\alpha}F(A)$
- $B\xrightarrow{\beta}F(B)$
- $A\xrightarrow{f}B$
For this definition to make sense $F$ must be a functor and act not only on objects, but also on arrows.

Coalgebras are the dual form of algebra and are derived via the categorical principle of duality.

### inductive and coinductive definitions

#### def
An initial $F$-algebra is an $F$-algebra that is an \textit{initial object} in the category of all $F$-algebras and $F$ $(A,\alpha)$, $(B,\beta)$ is an arrow $f:A\rightarrow B$ such that $\beta\circ f = F(f)\circ \alpha$:
    - $F(A)\xrightarrow{F(f)}F(B)$
    - $A\xrightarrow{\alpha}F(A)$
    - $B\xrightarrow{\beta}F(B)$
    - $A\xrightarrow{f}B$
For this definition to make sense $F$ must be a functor and act not only on objects, but also on arrows.


## modern automata theory - z. \'esik

### finite automata
#### def
A semiring is a set $A$ equipped with two binary operations $+$ and $\cdot$ and two constant elements $0,1$ such that:
1. $\langle A, +, 0\rangle$ is a commutative monoid (= set of elements with an associative, commutative binary operation and an identity element)
2. $\langle A, \cdot, 1\rangle$ is a monoid (= set of elements with an associative binary operation and an identity element)
3. the following distribution laws hold for all elements: $a \cdot (b+c) = a \cdot b + a \cdot c$, $(a + b)\cdot c = a\cdot c + b\cdot c$
4. $0\cdot a = a\cdot 0 = 0$ for every $a$

#### def
A starsemiring is a semiring equipped with an additional unary operation $*$. Example of starsemirings: $\langle \mathbb{B}, +, \cdot, *, 0, 1 \rangle$ with $0*=1*=1$

#### def
A Conway semiring is a starsemiring that satisfies the sum-star-equation:
$$(a+b)^* = (a^*b)^*a^*$$
and the product-star-equation:
$$(ab)^* = 1 + a(ba)^*b$$
Example: semiring $\langle 2^{\Sigma^*}, \cup, \cdot, *, \emptyset, \{ \epsilon \} \rangle$ of formal languages over $\Sigma$ with $L^*=\cup_{n\geq 0}L^n$ for all $L \subseteq \Sigma^*$

A way to highlight the connection between graphs and automata:
#### def
Consider a Conway semiring $A$ and its subset $A'$. 
A finite automaton $A'$-automaton $\textfrak{U}=(n,M,S,P), n \geq 1$ is given by:
1. a transition matrix $M\in (A' \cup \{0,1\})^{n\times n}$
2. an initial state vector $S\in (A' \cup \{0,1\})^{1\times n}$
3. a final state vector $P\in (A' \cup \{0,1\})^{n\times 1}$
The behavior $||\textfrak{U}||$ of $\textfrak{U}$ is defined by 
$$||\textfrak{U}|| = \Sigma_{1 \leq i_1, i_2 \leq n} S_{i_1} (M^*)_{i_1,i_2} P_{i_2} = S M^* P$$

### context-free grammars and algebraic systems

# from papers

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

## abstract interpretation from B\"uchi Automata - m. hoffman et al.
From a given BA, build an abstract lattice with the following properties: 
- there is a Galois connection between it and the infinite lattice of languages of finite and infinite words over a given alphabet
- the abstraction is faithful wrt. acceptance
- least fixpoints and $\omega-$iterations can be computed on the level of the abstract lattice
one can develop an abstract interpretation to check whether finite and infinite traces of a recursive program are accepted by a policy automaton. 
this approach is more flexible for integration with data types, objects, higher-order functions (easier reasoning?)

## b\"uchi, lindenbaum, tarski: a program analysis appetizer - v. d'silva et al.
There are various approaches to prove the correctness of a program:
- satisfiability-based: bounded executions and errors of $P$ are encoded as a formulae $Exec(P)$ and $Err$, respectively. 
    If no bounded execution violates the assertion, then: $\vdash Exec(P)\implies \neg Err $. Solvers prove this by showing $Exec(P)\land Err$ unsatisfiable.
- model checking: check whether program $P$ is a model of formula $\neg Err$: $P\models \neg Err$
- automata-theoretic: the executions of program $P$ are words accepted by automaton $\mathcal{A}_P$, erroneous executions are words accepted by $\mathcal{A}_{Err}$. Program 
    $P$ contains no assertion violation if $\mathcal{L}(\mathcal{A}_P\times {A}_{Err})=\emptyset$
- lattice-theoretic: originated from programming language semantics and compiler construction, relies on abstract interpretation to interpret program $P$ and assertion $Err$ in a lattice A of approximation. 
    The program is error-free if the lattice element denoted by $P$ is separate from the lattice element denoted by the error: $\llbracket P \rrbracket_A \sqcap \llbracket Err \rrbracket_A \sqsubseteq \perp$
One can move in between these representations:
- automata ($\mathcal{L}(\mathcal{A}_{P}\times \mathcal{A}_{Err})\subseteq \emptyset$) $\xrightarrow{b\"uchi's theorem}$ logic ($\vdash Exec(P)\implies \neg Err $)
- automata ($\mathcal{L}(\mathcal{A}_{P}\times \mathcal{A}_{Err})\subseteq \emptyset$) $\xrightarrow{\mathcal{L}}$ concrete lattice ($\mathcal{P}(Exec), \subseteq$)
- logic ($\vdash Exec(P)\implies \neg Err $) $\xrightarrow{mod}$ concrete lattice ($\mathcal{P}(Exec), \subseteq$)
- logic ($\vdash Exec(P)\implies \neg Err $) $\xrightarrow{Lindenbaum-Tarski}$ abstract lattice ($\llbracket P \rrbracket_A \sqcap \llbracket Err \rrbracket_A \sqsubseteq \perp$)
- concrete lattice ($\mathcal{P}(Exec), \subseteq$) $\xrightarrow{abs}$ abstract lattice ($\llbracket P \rrbracket_A \sqcap \llbracket Err \rrbracket_A \sqsubseteq \perp$)
- abstract lattice ($\llbracket P \rrbracket_A \sqcap \llbracket Err \rrbracket_A \sqsubseteq \perp$) $\xrightarrow{conc}$ concrete lattice ($\mathcal{P}(Exec), \subseteq$)  
Loop invariants are fixed points of functions on lattices. 

## a sat-based procedure for verifying finite state machines in ACL2 - w. hunt et al.
- sulfa properties converted into sat (cnf): 
- We present an algorithm for converting ACL2 conjectures into conjunctive normal form (CNF), which we then output and check with an external satisfiability solver. The procedure is directly available as an ACL2 proof request. When the SAT tool is successful, a theorem  is added to the ACL2 system database as a lemma for use in future proof attempts. 

## cell morphing: from array programs to array-free horn clauses - d. monniaux et al.

From our programs with arrays, we generate nonlinear Horn clauses over scalar variables only,in a common format with clear and unambiguous logical semantics, for which there exist several solvers. We thus avoid the use of solvers operating over arrays, which are still very immature.

## inductive approach to spacer - t. tsukada et al.

- as linear CHC: an approach called property-directed reachability proposed as a solver of finite model-checking that corresponds to linear CHCs over finite data domain, also applied to non linear CHCs (GPDR)
- Spacer is based on several new ideas, but the key to refutational completeness is a technique called model-based projection. It is used to divide the set of local candidatesof counterexamples into a finite number of classes, and the finiteness of the classes allows an exhaustive search for candidates of global counterexamples in a finite number of steps.
- the refutational completeness of spacer seems to be a matter of discussion? there exists a refutationally complete variant

## formal verification at higher levels of abstraction - d. kroening et al., 2007

- Algorithms that operate at the bit-level are unable to exploit the structure provided by the higher abstraction levels, and thus, are less scalable $\rightarrow$ high level models: (1) word-level verification with predicate abstraction and smt solvers, (2) term-level modeling and their combination for scalable verification 
- Abstraction techniques reduce the state space by mapping the set of states of the actual, concrete system to an abstract, and smaller, set of states in a way that preserves the relevant behaviors of the system $\rightarrow$ might be nice to have hierarchy in this?
- Capacity is the main challenge for formal verification tools. Given a high-level model, word-level reasoning can increase the capacity of formal verification tools significantly when compared to a net-list level tool. We discuss decision procedures (SMT solvers) for bit-vector arithmetic, and give an overview of predicate abstraction, a word-level assertion checking technique.

## high-level abstractions and modular debugging for FPGA design validation - y. iskander et al., 2014
The developed approach provides two means of directly validating synthesized hardware designs.
The first allows the original high-level model written in C or C++ to be directly coupled to the synthesized hardware, abstracting away the traditional gate-level view of designs. 
A high-level programmatic interface allows the synthesized design to be validated directly by the software reference model. 
The second approach provides an alternative view to FPGAs within the scope of a traditional software debugger. 
This debug framework leverages partially reconfigurable regions to accelerate the modification of dynamic, software-like breakpoints for low-level analysis and provides a automatable, scriptable, command-line interface directly to a running design on an FPGA.

## fsm anomaly detection using formal analysis - f. farahmandi et al., 2017

The proposed method tries to find inconsistencies between the specification and FSM implementation through manipulation of respective polynomials.
Security properties (such as a safe transition to a protected state) are derived using specification polynomials and verified against implementation polynomials. In a case of a failure, the vulnerability is reported. While existing methods can verify legal transitions, our approach tries to solve the important and non-trivial problem of detecting illegal accesses to the design states (e.g., protected states). 

## spot: an extensible model checking library using transition-based generalize b\"uchi automata - a. duret-lutx et al., 2004

b\"uchi automata $\rightarrow$ tableaux before encoding 

## eliminating excessive dynamism of dataflow circuits using model cheecking - xu et al., 2023

In this work, we present a verification framework based on model checking to systematically reduce the hardware complexity of dataflow circuits.

## theory of latency-insensitive design - carloni et al., 2003
- Latency-insensitive designs are synchronous distributed systems and are realized by composing functional modules that exchange data on communication channels according to an appropriate protocol.
- The theory may be applied as a rigorous basis to design complex digital systems by simply composing predesigned and verified components so that the composition satisfies, formally and “by construction,” the required properties of synchronization and communication
- According to our approach, the system can be thought as completely synchronous, i.e., just as a collection of modules that communicate by means of channels having “zero delay,” i.e., a delay negligible with respect to the pe- riod of the common clock signal (synchronous assumption).
- However,the proposed theory guarantees that it is not necessary to complete costly redesign iterations or to slow down the real clock. The key idea is borrowed from pipelining [10], [11]: partition the long wires into segments whose lengths satisfy the timing requirements imposed by the real clock by inserting logic locks called relay stations, which have a function similar to the one of latches on a pipelined data path
- The key point of this approach is to relax time constraints during the early phases of the design when correct measures of the delay paths among the modules are not yet available.
- Two systems are latency equivalent if on every channel, they present the same data streams, i.e., the same ordered sequence of data, but, pos- sibly, with different timing. We show that for patient processes, the notion of latency equivalence is compositional by proving the following theorems: 1) the intersection of two patient pro- cesses is a patient process; 2) given two pairs of latency equiv- alent patient processes, their pairwise intersections are also la- tency equivalent; and 3) for all pairs of strict processes and patient processes , if is latency equivalent to and is latency equivalent to , then their intersections are latency equivalent. As a consequence, we can derive the major result of our theory: if all processes in a strict system are re- placed by corresponding patient processes, then the resulting system is patient and latency equivalent to the original one. 

Insight: latency-insensitive design is useful and allows faster iterations on 
the design/faster development in general.

## The Essence of Bluespec

A paper so beautiful and clean that I somehow wish I had written.

- The commercial BSV compiler relies on a static analysis to do ORAAT-preserving concurrent scheduling of rules. Its static analysis, combined with user-provided annotations (e.g. descending urgency and execution order), generally creates excellent circuits. This approach, however, is not sat- isfactory for two reasons. (1) The static analysis should be an abstraction of the dynamic semantics of a program. BSV’s dynamic semantics applies only to one-rule-at-a-time execu- tions, and the cycle-level semantics necessarily depends on the static analysis of rules. (2) BSV programmers often think deliberately about static-analysis details and even change their code to nudge the compiler in the right direction to achieve the desired degree of concurrency.
- Traditional HDLs like Verilog and VHDL are structural in the sense that they describe interconnections of boxes, i.e., Boolean gates and registers. The main problem with such languages is that they provide inadequate type checking and lack precise semantics, which makes verification and design refinement a Herculean task.
- A cycle-accurate description is essential to understand the performance of a hardware circuit. Such descriptions, how- ever, often complicate reasoning about functional proper- ties of the hardware. 

insight: very useful related work section, gives tons of interesting facts about pros and cons of different approaches and highlights their shortcomings. 
idea: abstract interpretation for more efficient simulation and verification starting from the definition of circt dialects' semantics. in lean4. 

## Semantics Driven Hardware Design, Implementation, and Verification with ReWire}
This paper presents ReWire, a functional programming language providing a suitable foundation for formal verification of hardware designs, and a compiler for that language that translates high-level, semantics-driven designs directly into working hardware. 

## Learning Semantic Representations to Verify Hardware Designs}

example of how hardware abstractons' semantics is extracted.

- Design2Vec, a deep architecture that learns emantic abstractions of hardware designs
- RTL designs are typically simulated using an RTL design simulator, which does not suffice for the design goals of our analysis. For use with machine learning, we choose to represent RTL as a control data flow graph (CDFG). The CDFG we construct for each Verilog RTL program encodes the program’s simulation semantics, so that our models may make inferences about the their behavior

## Experience with embedding hardware description languages in HOL

interesting tech report. 

## What are the Semantics of Hardware, Bernstein et al., 2021
- We propose an endeavor to formalize and relate each level of semantics using abstract interpretation.
- There are at least three major points of view on implementing interpreters/simulators. If the language resembles sequential code (e.g. HLS), then the host software-language semantics are often appealed to. In functional HDLs, some dataflow interpretation[ 15 ] is commonly used. Verilog itself uses a form of event-based simu- lation that resembles dataflow[ 1 ]. Lastly, many high-performance simulators flatten module hierarchy, eliminate loops by breaking the circuit at registers, and compile a single transition function for updating the state at each synchronous clock.
- the dataflow point of view (which is the most similar to our proposal) does not handle combinational loops and other lower-level aspects of hardware simulation
- Our idea is to use the theoretical framework of Abstract Interpre- tation [7] to define semantics, and therefore reference interpreters, for HDLs at multiple levels of Abstraction
- New “just-in-time” [19 ] or distributed simulation methods pro-pose to separately compile parts of circuits that must then “synchro-nize” or converge via communication. The fix-point formulationof semantics clarifies the conditions under which such simulationsconverge to a unique solution.


# from talks 
## CGO, 020324, M. O’Boyle Keynote, CC

- Compilers redux vs. End of Moore’s law, rough ~3.6% improvement
- Architecture can’t do it alone
- Idea: using FSM for compiler verification only? All dialects have lowering to FSM
- Compiler ~ Jenga
- HW-SW contract is breaking down → SW cant fit on new (heterogeneous) HW → rethink the contract
- Can compilers help as a DSL would? Without having programmers learn all DSL/manage translation etc→ ✨ABSTRACTION✨ → eg shift up x86 → openCL → clBLAS/Halide/…
- Target: nearer to algorithm, will always perform well BUT target is complex and changeable → solutions must work for all APIs → AUTOMATION
- IDEA: Lift code to API/DSL and THEN to HW
- Learn HW accelerator (grey-box program synthesis/infer program behaviour) and match SW
- Match libraries to legacy code automatically (neural classifier)
- Further: exploit domain knowledge with higher level abstractions (MLIR), multi-level tactics
- Neural decompilation
- Idea: generate a FSM testbench automatically with neural network/LLM?
- Inductive Oracle/Program Synthesis?
- Challenges: Scalability, Data, Accuracy (verification?), Explanation
- Idea: represent dataflow/control flow with FSMs?
- Semantic-based check can be very useful especially between IRs

## CGO, 030324, Albert Cohen Keynote, CC

- Abstractions are key for performances → lift the abstractions until sth we know (domain-wise) and enjoy the ride
- Reflective Programming must be domesticated → JAX
- Multi-stage programming: useful when we know the domain very well/have a plan/know optimisations in advance (AnyDSL, OOPSLA 2018) → manage partial evaluation (Cohen, SCP 2006) → Cross-stage persistence + macro expansion
- Autotuning on top of existing compilers (A flexible approach to autotuning, PACT 2021)
- Beyond: reinforcement learning for register allocation → open up compiler interface to make it suitable for production
- Guided metaprogramming → scheduling languages, split compilation
- IRDL
- Rethink/Reevaluate correctness requirements
- Idea: find problems FSMs can describe efficiently
- Testing methodologies → verification?

## CGO, 030324, Panel: Compilers and ML, CC

- Saman: compilers haven’t changed much in the last ~30y, although we have more computing power, better/faster algorithms and more data, neither of which we actually use. We should have:
    - CaaS: Compilation as a Service (processing power/accelerators/memory and storage)
    - Can we naively use ML? → Neural Machine Translation BUT no correctness guarantee
    - Centrally Collected Data for Continuous Improvement exploiting the usage information retrieved by CaaS (real data)
- Tobias: ML has a transformative impact on compilers, true or false? Compilers are pervasive across multiple domains → can we enable reuse? MLIR enables this → Multi-level rewriting: we broke compilers to pieces → bigger surface to retrieve data/information. Prolific areas for ML in compilers:
    - CompCERT → local verification of lowerings
    - Peephole Rewrites/Proof Synthesis?
    - ML-written automation support
    - Integrate performance models with ML?
- Hyesoon: before → lot of pre/post processing, today → chatGPT
- Fabrice: compilers for ML → yes, ML for compilers → lots of paper, but what about production compilers? Extend to:
    - Scientific computing
    - Generic compilers: pattern-spec embedded libraries
- Xipeng: LLM bridge semantic gap for compilers: high-level semantics is key → correctness challenges.
    - LLM: good at high-level code semantics, but lacks precision/scalability/detailed compiler knowledge
    - Compiler: precise, detailed transformations, but lacks high-level understanding and is easily blocked by ambiguities
    - LLM-compiler synergy: compiler-assisted LLM + LLM-assisted compiler → potential = find new optimisations/rewritings via math formulae
- Q: ML interpretability for correctness
- Q: security of cloud compilation?
- Q: avoid black-box → improve interaction with the compiler + need for safety → expose bigger surface? → no clear answer: embrace the dark side

## CGO24, Amir Shaikhha - A Tensor Algebra Compiler for Sparse Differentiation

- Program = bottleneck between data and hardware
- Challenges for sparse differentiation: require control-flow constructs and are complicated
- There are a lot of sparse storage format
- Two levels of abstractions: logical (AD) + physical (compressed formats: expressive enough for the conversion)
- Semi-rings are cool and compositional → can be used as dictionaries to represent sparse matrices

## CGO24, Katsumi Okuda - AskIt: Unified Programming Interface for Programming with Large Language Models

- Communication: program <- function call → program, human <-programming language → program, human <-natural language→ LLM-based system
- Question: program <-?→ LLM → use DSL to:
    - LLM as part of a program
    - ???
- Emergent abilities of LLMs = directly answerable questions
- GPT-4 as a parser: make prompt → send prompt → extract result
- AskIt: define type → define function → call function
- Intersection of directly answerable tasks and codable tasks
- Programming interface to have LLMs and programmers interact easily with the program
- Does generated code improve performance? (GSM8K benchmark)? Yes
- Verification of results: no (AST), the generated programs are tested for correctness (test cases)

## CGO24 Volker Seeker - Revealing Compiler Heuristic through Automated Discovery and Optimisation

- Motivation: compilers are great, but difficult to optimize → heuristics guide code optimizations, there are default optimizations settings
- Tuning heuristics is beneficial → ML-guided heuristic tuning
- impossible to find/tune manually everything, especially in large code bases which are constantly updated etc → automation: what to optimise wrt objectives → existing approaches:
    - iterative compilation
    - promising: RL, but only for exposed heuristics
- what they do: automatically find heuristics and expose them to attach tuning
- how to find heuristics: try to find one that validates the output, then explore the output semantics → possibly improved → differential testing
- both application and compiler optimization
- NAS, Polybench benchmark suite → identified different tuning targets for each benchmark (only individual) → Q: what is a tuning target/why some benchmarks have more?
- core: enable fine-grained ML tuning for compiler heuristics → not only compilers

## CGO24 SLaDe

- Decompilation → considerable manual work and code is often mangled (e.g. Ghidra: produces hard to read code)
- Neural Decompilation: automated, trained on human-written code → readable
- BTC: code is plausible but incorrect, no correctness evaluation
- ChatGPT: readable, but incorrect
- Tradeoff: correctness vs. Readability → SLaDe is both
- small, specialised transformers have potential

## CGO24 Jean-Michel G.

- preserve properties across automata transformations
- translation validation throughout the compilation flow
- verifying that hw is consistent with initial hypotheses

## CGO24 Retargeting and Respecializing GPU Workloads for Performance Portability

- GPU optimisation → parallel semantics
- Synchronisation interaction → preserve barriers semantics → divergent control flow?
- thread coarsening → no barriers in divergent control flow → recursive interleaving→ always legal here
- Granularity of coarsening factor → finer granularity yields better results

## CGO24 Computing Systems for the Foundation Model Era

- Provide scale and efficiency + achieve performance and programmability → vertically integrated solution: ML algorithms + dataflow compilers + reconfigurable dataflow architecture
- General purpose monolithic model vs. Hundreds of specialist models with automatic routing → smaller fine-tuned models are cheaper and sometimes better than large, generalist ones
- challenge: sparse training with accuracy and HW efficiency
- dataflow compilers: dataflow graph analysis is important → dataflow programming → optimisation by scheduling in space and time: fusion, tiling, pipelining → lower representation closer to hw (e.g. DSL called spatial, PLDI)
- reconfigurable dataflow architecture

## 240524 Lizy John HW design with/for ML

- Exploit SW optimization first
- Add hard matrix multiplier blocks to FPGA → how many? trade off: small area 3-5% (“Tensor Slices”) doubles the throughput for ML applications, w\out increasing the overall area, no extra general purpose connection required, no slowdown in non-ML benchmarks
- Add compute in RAMs: improvement with +3% extra hw → reduction in data movement
- Weightless NN have potential
- ML for performance modeling: (1) calibration of power models using ML → McPAT, simulator to model machines that do not exist yet
- Interest in ML-guided HW design → Computer Architecture 2.0, e.g. ML-based branch predictors?

## SOAP24 Recent Advances in Floating-point (Static) Analyses

## PLDI24 SpEQ: Translation of Sparse Codes using Equivalences

- Nasa Parallel Benchmarks!!
- verify sparsity → equivalence check between dense and compressed = precondition for sparsity over input data → stuttering bisimulation
- semantics is important and can be an interesting proxy for optimizations

## PLDI24 Compiling with Abstract Interpretation

- ai framework for compilation + use comp result to improve ai
- ai = combine multiple analyses to collaborate/increase precision → can it be used for transformations?
- free algebra domains generate programs as analysis result + domain functors for comp passes + online comp to SSA
- ai: propagate analysis until fixed point

## PLDI24 Towards Trustworthy Automated Program Verifiers: Formally Validating Translations into an Intermediate Verification Language

- soundness of intermediate verification language program = frontend + backend
- frontend soundness: ivl correct ⇒ backend correct
- pb: no formal guarantees on implementations in practice + nontrivial implementations
- cont: simulation methodology for source and ivl + certifying adaptation of viper-to-boogie translation
- very interesting choice of ordering: first cont + results then challenges
- ch1: semantic gap viper-boogie
- ch2: diversity
- ch3: non locality
- pb: relating viper method and boogie procedure → p simulates m = decompose simulation into small semantic concerns + tactics for simulation of resulting concerns

## PLDI24 Verified Extraction from Coq to OCaml

- hand writing = control of optimization + bugs
- solution: high level languages
- pb: verifying aggressively opt compilers is very hard
- first work: 2 stage compiler for hig level func lang + combinators to tinker with lowerl level details = verified
- now the lowering algo is verified
- reshape operators (invertible) → rewrite framework exploiting verified equivalences

## PLDI24 Yann

- compcert -drtl
- vericert -dgblpar -dgblseq

## PLDI24 Hyper Hoare Logic: (Dis-)Proving Program Hyperproperties
https://pldi24.sigplan.org/program/program-pldi-2024?past=Show%20upcoming%20events%20only#

## PLDI24

- demanded abstract interpretation graph

## BigSpec24

- christopher pulte, ben simner, catalin hritcu, michael sammler
- what’s special about hypervisors verification?
- back to the building blocks (white house paper?)

## BigSpec24 Sandrine Blazy - Some challenges and work in progress in verified compilation of realistic languages

- many intermediate languages (IRs) necessary to verify compilers (eg compcert) → IR design is important
- simulation diagram = standard technique, target program has less behaviors
- stutterings??
- pb: define invariants and measures between source and target → no standard procedure, depends on the languages
- small step semantics → model diverging executions
- with continuations : using induction in Cocq
- mechanized operational semantics
- rtl verification backends: compcert gsa, vericert icl, fm jit, chamois uga
- interesting related projects: verasco abstract interpreter, vst separation logic (gillian-c, verifast), certicoq, compcerto, l2c, velus, probcompcert
- Q: how do you test semantics?
- IR design: testing semantics → compcert has an interpreter for the source lang to test semantics on some programs → eg functions shared by semantics and intepreters
- open projects:
    - IR for Catala (DSL to describe law)
    - IR for dataflow circuits (Tony Law) → intermediate languages (one for compiler toolchain: graph with components + one for inductively defined lang to reasone more easily and show determinacy of circuit executions → semantically equivalent)
        - component: independent CU, consumes/produces tokens, async connection, may be stateful
        - channel,: transfer token, unbounded queue
        - semantics: execute anything that has enough inputs, scheduling is implementation dependent → semantics is independent of scheduling, dynamic scheduling = execution only constrained by availability of input data
- why do we have to write induction by hand?

## BigSpec24 Alastair Reid - Engineering large, multipurpose microprocessor specifications (using the x86-64 architecture as a case study)

- Reid, Who guards the guards (oopsla 2017)

## BigSpec24 Anna Slobodova, Micro-architectural modelling and verification of an x86 micro-processor

- actual microarchitecture → parallel decoding, reordering, parallel exec, speculation, deep pipeline, several levels of caches, multiple copies of state elements, complicated power management, focus: verification of execution clusters
- goal: complete verification of all micro ops in EXE (int, log, vec, fp) with minimal assumptions, power management, deep pipelining, design-for-test features
- ACL2 with built-in automation tools, $\subset$ LISP, open source, executable, efficient, well documented, versatile, extensible, experts available
- requirements: formalism that allows fast model build → SV to FSM, extensibility, easy decomposition → CIRCT has them all (claim on easy decomposition → implement product and such)
- systemVerilog → SVEX + SVTV → framework to define, unroll, evaluate FSMs, translate everything into FSMs and then use that
- specialized rewriter for multipliers

# random thoughts and ideas

- a compositional approach to hardware verification exploiting high level abstractions (dialects) for progressive and verified lowering, using fsms as a proxy to represent dialects' semantics, based on the assumption that the automata-theoretic approach is better than the logic one (in this specific case? in general? based on what?).
- so for example a problem with logic representation is that it scales quite poorly with the number of variables involved
- a decision procedure such as the one we have already is easily extensible to multiple variables? 
- the key difference between the two approaches is that for the logic formulae we need to use smt solvers, which are typically very good under very constrained circumstances (e.g. fsm x chc), instead when we have an automaton we can "just" explore the automaton and use some heuristics to optimize its exploration and prune the state space. which solvers do too so idk if there's a real benefit in there. but certainly representing things as automata is easier than massaging an smt formula. 
- in theory we can use automatic structures on domains that are broader than bool, although i suppose their complexity scales quite poorly. 
- Things we want to say and do over the three years: 
    (1) formalize high level abstractions as FSMs (papers on how to use FSMs to represent dataflow? requires representing actual handshake)
    (2) extend fsm dialect to represent buechi automata 
    (3) reason about designs in terms of omega-languages, ltl and ctl
    (4) make verification of designs modular and prpogressive as the design becomes more complex.
- there are three fundamentally equivalent ways to analyze a program and verify it: automata-theoretic approach, logic approach, abstract interpretation. we can move between the three, but beign able to exploit their characteristics and differences to perform and optimize different analyses could make our life esier. automata are good for (1) temporal logic stuff and (2) concurrent designs etc, so how am i planning to use this in a compiler thingy? in hardware modeling ltl stuff is useful! but here we're talking about compilers? 
- can fsms help in modeling the gray area between dataflow and rtl?
- fsms are good for LTL and temporal logic. we already have smt for model checking. for temporal properties (which, crucially, are very important for hw) buechi automata are our best shot. integrating BA in circt would give us another very powerful tool for verification, complementing the work that is currently being done with smt but with a focus on temporal (modal?) logics. having this in a framework that is by design modular and reusability oriented is a great comb because we can exploit all the algorithms that enable to easily manipulate automata (a well scope and known problem) and this would make our life easier. furthermore, if we encode the so-obtained automata in an it such as lean, we might even get the additional benefit that we can reason about it, write theorems,  prove the lowering correct. 
- dialects semantics is just a sequence of operations really. can we encode that in some sort of automaton like the ones we have for bitvectors? 
- itps can be a game changer in (1) the progressive verificat on of hw designs and (2) the verification of lowerings and optimization sin compilers
- buechi automata as an easier interface to reason about ltl properties on the design?
- does it make sense to use buechi automata to reason about ?


