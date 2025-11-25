---

title: "lean-mlir misc"
date: 2025-02-28
---
# lean-mlir misc

- `variable (d : Dialect) [DialectSignature d]` instantiates the core data structure `(Expr, Com)`, it is intrinsically well typed: typing rules are baked into the data structure,
- this is done by asking the dialect to provide (via a signature) the type class: class `DialectSignature`: is a map from operations to the signature
```lean
/-- An intrinsically typed expression whose effect is *at most* EffectKind -/
inductive Expr : (Γ : Ctxt d.Ty) → (eff : EffectKind) → (ty : d.Ty) → Type where
  | mk {Γ} {ty} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) <| DialectSignature.sig op) 
    /- For now, assume that regions are impure.
       We keep it this way to minimize the total amount of disruption in our definitions.
       We shall change this once the rest of the file goes through. -/
    (regArgs : HVector (fun t : Ctxt d.Ty × d.Ty => Com t.1 .impure t.2)
      (DialectSignature.regSig op)) : Expr Γ eff ty
```

where:
- `(Γ : Ctxt d.Ty)` = dialect types
- `(ty : d.Ty)` dialect type expected for this expression
- `x : Expr [.int, .int] _ .int`
- `[.int, .int]` is the context (usually Γ), declares the type of the free varuiables, where `.int` is defined within the dialect only
- `.int` is the expected return type (again within the dialect)
- because it's intrincisally well typed, `x` is well typed with free vars `[.int, .int]` and is of type `int`
- within the context `(Γ : Ctxt d.Ty)` the argument has the type it is supposed to have

A note about `HVectors`:
- the reason why we have HVectors `HVector : (f : α → Type) → List α → Type` is to store types in a data struc (e.g. `α`), this must be in a higher universe (*universe bump*). HVector does not strictly store types, but rather elements of `α`, meaning that we don't have to perform the *universe bump*. 
- `α` is an encoding for a type, but *not* a type to avoid universe problems
- `f` allows us to interpret `α` as a type ("denotation before types")
- in the framework we have two `HVecstorsL`: one for the input and one for the region `HVector toType [bool] → HVector _ [ ([ ], int)] → toType int`
- where the function "_" to map the region sig to the Lean type is: `("context" := Valuation.region.1), ("returnType" := [[region.2]])`, `fun region => Valuation.region.1 → [[region.2]]`

NB: context declares free vars and their types

Variables/valuation/denotation notes: 
- `v : Γ.Var ty`: `v` is a variable in context `Γ` of type ty
- `Var Γ : d.Ty → Type` "f"
- `DialectSignature.sig op : List d.Ty` as : `List d.Ty`
- the i-th element of the hvector as type `f` `as[i]`
- valuation assigns free vars to a value of the denotation of that type:
- `∀ ty Γ.Var.ty → [[ty]]`
- map every type in the context Γ to a denotation of that type
- denotation: `toType : [[ty]] = toType ty : Type` (Lean type corresponding to our own types we define in the dialect)

Semantics notes:
- effects stuff: has to do with semantics
- to give semantics to a program we have another class, `DialectDenote`.
- we give semantics to operations:
    ```
    xs[i] : ToType argumentTypes[i]
    xs[i] : BitVec 32
    {(int) → int}
    BitVec 32 → BitVec 32
    ```
- `[[int]] = BitVec 32` "denotation of `int` is `bitvec 32`"
- suppose we want to say that the denotation of add is `BitVec 32 → BitVec 32 → BitVec 32` generically, giving the denotation of an arbitraty something (?) "curried function"

Currying:
- "uncurry the function": we give a `HVector toType (DialectSignature.sig add → toType (DialectSignature.outTy ty))`
- "curried function" : a way to say we have a function `α → β → γ` (curried)  is the same as `f (α, β) → γ` (uncurried), they are equivalent
- anon function e.g. `λy.f(x,y)` allows to move from curry to uncurry
- exercise: show that function uncurry → curry and curry → uncurry are the inverse of each other
- exercise: `γ ^ (α × β) ≃ (γ ^ β) ^ α`, `(α × β) → γ ≃ α → (β → γ)`
- in theory they're all equivalent, in practice in funclang we tend to curry things: compiler spends time uncurrying things
- first order languages can only do uncurried
    ```
    toType:
    [[arg[0]]] → [[arg[1]]] → ... → [[arg[n]]] → [[retType]]
    ```
- first order unification is decidable → lean can do type inference as long as we don't go higher order
- currying means going higher order (`HVector` def remains first order for this reason)

example:
- region called "if"
    ```
    {( ) → int} → (bool) → int
    DialectSignature.sig if = [bool]
    DialectSignature.outTy if = int
    DialectSignature.regSig if = [ ([ ], int) ]
- if (cond) then (reg) where (reg) returns an int
- morally we would like to have `(Unit → BitVec 32) → Bool → BitVec 32`
- we encode the denotation of the region as a function `(Unit → BitVec 32)` because of Lean's eagnerness (we make it lazy)
- this will be uncurried into the `HVector`
- this function is the "then" block: it is spiritually an argument of the "if" region, but it differs from std value args, and when an arg is a region we pass it as function