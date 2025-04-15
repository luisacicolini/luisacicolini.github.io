/-- Untyped Arithmetic Expressions -/


/-- Inductive definition of terms:
  The set of terms T contains:
  · {true, false, 0}
  · if t₁ ∈ T then {succ t₁, pred t₁, iszero t₁} ⊆ T
  · if t₁, t₂, t₃ ∈ T then "if t₁ then t₂ else t₃" ∈ T
-/

inductive newType : Nat → Type where
  | ttrue {n : Nat} : newType 0
  | ffalse {n : Nat} : newType 0
  | zero {n : Nat} : newType 0
  | pred {n : Nat} (t : newType (n - 1)) : newType n
  | isZero {n : Nat} (t : newType (n - 1)) : newType n
  | ite {n : Nat} (t₁ t₂ t₃ : newType (n - 1)) : newType n

/-- Untyped Booleans -/

inductive t where
  | True : t
  | False : t
  | ite : t → t → t → t

def val (i : t) : Bool :=
  match i with
  | t.True => true
  | t.False => false
  | t.ite c a b => if val c then val a else val b

#eval val (t.True)
#eval val (t.False)
#eval val (t.ite t.False t.True t.False)
#eval val (t.ite t.True t.True t.False)
#eval val (t.ite t.True t.False t.True)

theorem EvalIfTrue (t₁ t₂ t₃ : t) (ht₁ : val t₁ = true) :
    val (t.ite t₁ t₂ t₃) = val t₂ := by simp [val, ht₁]

theorem EvalIfFalse (t₁ t₂ t₃ : t) (ht₁ : val t₁ = false) :
    val (t.ite t₁ t₂ t₃) = val t₃ := by simp [val, ht₁]

theorem EvalIf (t₁ t₁' t₂ t₃ : t) (ht₁ : val t₁ = val t₁') :
    val (t.ite t₁ t₂ t₃) = val (t.ite t₁' t₂ t₃) := by simp [val, ht₁]

theorem OneStepDeterminacy (t₀ t' t'' : t) (h₀ : val t₀ = val t') (h₁ : val t₀ = val t'') :
    val t' = val t'' := by
  cases t₀ <;> simp_all

/-- Untyped Bools and Nats -/

inductive t' where
  | True : t'
  | False : t'
  | ite : t' → t' → t' → t'
  | zero : t'
  | succ : t' → t'
  | pred : t' → t'
  | isZero : t' → t'

def valB (b : t') :=
  match b with
  | t'.True => true
  | t'.False => false
  | t'.ite c a b => if valB c then valB a else valB b
  | _ => sorry

def valN (n : t') : Nat :=
  match n with
  | t'.True => valB n
  | t'.False => valB n
  | t'.ite c a b => valB n
  | t'.zero => val: t'
  | t'.succ => val: t' → t'
  | t'.pred => val: t' → t'
  | t'.isZero => val: t' → t'
