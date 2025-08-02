---
title: "a mini intro to category theory"
---
model something
    . sets, functions between sets
    . vec spaces, maps between vec spaces (ps. what is a vector space?)
    . types, function between types (e.g. in Lean)
        e.g. A \oplus B ~ inductive Sum A B
                            | inj_l : A => Sum A B
                            | inj_r : B => Sum A B
    . groups, group homorphisms
    . dialects in MLIR

category :=
        . collection of objects O (O : Set, e.g. O is everything that lives in Type)
        . collection of morphisms \forall o1, o2 \in O : Hom(o1, o2) (or: Hom: O x O --> Set)

    homomorphism := map between two algebraic structures of the same type that preserves the operations of the structures

    we define:
        . composition operation "o" : \forall A, B, C \in O : Hom (B, C) x Hom (A, B) --> Hom (A, C) (recall: h (*) = g o f (*) = g(f(*)))
        . identity : \forall A \in O : \exists IdA \in Hom (A, A) : \forall (g: B --> A) IdA o g = g
                                                                    \forall (h: A --> B) h o IdA = h
        . associativity : \forall (f g h : )
                    (f o g) o h : f (g o h)

    examples:
        . O = {X, Y, Z, ...} collection of sets
            given X, Y \in O : Hom (X, Y) = {f : X --> Y}
            o : function composition
            \forall A \in O : IdA = [x \in A |-> x ]
            product for this collection of objects can be proven to be equivalent to the cartesian product
        . O = {X, Y, Z, ...} collection of natural numbers
            Hom (X, Y) = { "set containing a single empty set {*} | x \le y, \empty otherwise} where {*} is singleton
            Hom (Y, Z) o Hom (X, Y) : Hom (X, Z) "Y \le Z o X \le Y = X \le Z"
        . O = {A, B, C, ...} collection of natural numbers
            Hom (A, B) = "matrices of dimension A x B"
            Hom (B, C) o Hom (A, B) : matrix multiplication
            IdA = identity matrix A x A (Hom (A, A))
        . O = {P, Q, R, ...} collection of propositions about natural numbers
            Hom (P, Q) = set of all proofs that P => Q (note that false implies everything)
            Hom (Q, R) o Hom (P, Q) : P => Q => R (chain composition)
            in this case one product can be conjunction (by the def of product)

    we define product operation "x": \forall C s.t. \sA : C --> A, \sB : C --> B \exists! \t : C --> A x B (note that the product is unique *modulo* isomorphisms.)

                    ------- C --------
                    |       :\t      |              note that \t is unique!
                    |       :        |              if this happens we say "the diagram commutes"
                    |       v        |              eg1: \sA := \pA o \t
                \sA |     A x B      | \sB               \sB := \pB o \t
                    | \pA |   | \pB  |              eg2:
                    |     |   |      |
                    |     v   v      |
                    ----> A   B <-----

    in the natural number with \le  example:

                    n       m       . k \le n
                    |\     /|       . k \le m
                    | \   / |       . \forall l, l \le n \land l \le m => l \le k
                    |  \ /  |
                    |   k   |
                    |   ^   |
                    |   :   |
                    --- l ---

    eg1:            4       9       . 3 \le 4
                    |\     /|       . 3 \le 9
                    | \   / |       . \forall l, l \le 4 \land l \le 9 => l \le 3 : this is not correct, since e.g. l = 4 does not satisfy 4 \le 3
                    |  \ /  |
                    |   3   |
                    |   ^   |
                    |   :   |
                    --- 2 ---

    eg2:            4       9       . 4 \le 4
                    |\     /|       . 4 \le 9
                    | \   / |       . \forall l, l \le 4 \land l \le 9 => l \le 3 : this is correct, since *any number* that is \le 4 (0, 1, 2, 3)
                    |  \ /  |         and \le 9 (0, 1, 2, 3, 4, 5, 6, 7, 8) is also \le 4
                    |   4   |
                    |   ^   |
                    |   :   |
                    --- 2 ---

    eg3:            P       Q       . (P & Q) => P
                    |\     /|       . (P & Q) => Q
                    | \   / |       . \forall R, (R => P \land R => Q) => (R => P & Q) : this is correct, since *any prop* that implies P and Q
                    |  \ /  |         also implies P & Q
                    | P & Q |
                    |   ^   |
                    |   :   |
                    --- R ---

    eg4: on vector spaces?

    "everything is just a morphism"

    "a product is the limit of some shape and some common shapes are given names" : meaning that asking the limits of a shape unravels to the definition of a product

    not every category has products! if something satisfying those properties exists we call it a property, but that does not always happen.

    eg4: O = "category of sets of card \le 2" -> does not have all products
        consider A = {\empty, {\empty}} and B = {\empty, {\empty}}
                we know that the product should have four elements! but the category O only contains elements with size \le 2, so this such product does not exist


vector space := a set whose elements, often called vectors, can be added together and multiplied ("scaled") by numbers called scalars. The operations of vector addition and scalar multiplication must satisfy certain requirements, called vector axioms. Real vector spaces and complex vector spaces are kinds of vector spaces based on different kinds of scalars: real numbers and complex numbers. Scalars can also be, more generally, elements of any field.

colimit := like product but arrows go in the opposite direction:

                    ------> D <-------
                    |       ^\t      |
                    |       :        |
                    |       :        |
                \sA |       Q        | \sB
                    | \pA ^   ^ \pB  |
                    |     |   |      |
                    ----- A   B ------

            for sets this corresponds to disjoint union ("smallest thing")

    an example I don't understand:

                 f
              A --> B
            g |     :
              v     v
              C .. > B |_| C / f ~ g ("B disjoint union C quotiented by ~")

    --> the product is unique modulo isomorphisms


    another example I don't understand:


             C ---- D
            A        E              ===>                E,A         or          A,C - D,E
            |       /                                 /  |                       |  /
            |      /                               F,D - B,C                     B,F
            |     /
            B    F

    and defining different colimits gives you different ways to glue up these things and define different shapes (e.g. torus)
    --> you need category theory to discuss the glueing
