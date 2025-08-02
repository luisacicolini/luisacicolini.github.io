
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
