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
