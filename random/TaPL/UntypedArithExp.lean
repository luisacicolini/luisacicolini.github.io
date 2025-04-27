/-- Inductive definition of terms:
  The set of terms T contains:
  · {true, false, 0}
  · if t₁ ∈ T then {succ t₁, pred t₁, iszero t₁} ⊆ T
  · if t₁, t₂, t₃ ∈ T then "if t₁ then t₂ else t₃" ∈ T
-/

/-
inductive newType : Nat → Type where
  | ttrue {n : Nat} : newType 0
  | ffalse {n : Nat} : newType 0
  | zero {n : Nat} : newType 0
  | pred {n : Nat} (t : newType (n - 1)) : newType n
  | isZero {n : Nat} (t : newType (n - 1)) : newType n
  | ite {n : Nat} (t₁ t₂ t₃ : newType (n - 1)) : newType n
-/

/- Lean automatically indexes the levels of the types -/
inductive newType : Type where
  | ttrue : newType
  | ffalse  : newType
  | zero : newType
  | pred (t : newType)  : newType
  | isZero (t : newType) : newType
  | ite  (t₁ t₂ t₃ : newType) : newType

/- Lean generates a `sizeOf` automatically that knows the level `i` for a `tᵢ`: -/
#reduce sizeOf newType.ttrue -- 1
#reduce sizeOf newType.ffalse -- 1
#reduce sizeOf (newType.isZero .ttrue) -- 2

/-- Untyped Booleans -/

inductive t where
  | True : t
  | False : t
  | ite : t → t → t → t

#reduce sizeOf t.True -- 1
#reduce sizeOf t.False -- 1
#reduce sizeOf (t.ite t.True t.True t.False) -- 4

/- define the evaluation relation: in Lean we incode it as an  *inductive prooposition* -/

inductive t.EvaluatesTo : t → t → Prop
| EvaluatesToTrue: t.EvaluatesTo (.ite .True t₂ t₃) t₂
| EvaluatesToFalse: t.EvaluatesTo (.ite .False t₂ t₃) t₃
| EvaluatesToIf (h : t.EvaluatesTo c c') : t.EvaluatesTo (.ite c l r) (.ite c' l r)

open t

/-
  theorem 3.5.4: determinacy of one-step evaluation
    if t → t' and t → t'' then t' = t''
  (note that we implement "→" as EvaluatesTo)
-/
theorem OneStepDeterminacy (a b c : t) (hab : t.EvaluatesTo a b) (hac : t.EvaluatesTo a c) : b = c := by
  revert c -- need to generalize c to be able to use it afterwards in the inductive cases
  induction hab
  · case EvaluatesToTrue =>
   intros c hac
   cases hac
   · case EvaluatesToTrue => rfl
   · case EvaluatesToIf tthenc telsec =>
      cases telsec -- absurd, t.True is a normal form, cannot EvaluatesTo.
  · case EvaluatesToFalse =>
      intros c hac
      cases hac
      · case EvaluatesToFalse => rfl
      · case EvaluatesToIf tthen telse =>
        cases telse -- absurd, t.False is a normal form, cannot EvaluatesTo.
  · case EvaluatesToIf ac ac' al ar hacac' ih  =>
      intros c thenRed
      cases thenRed
      · case EvaluatesToTrue => cases hacac' -- absurd, t.True is a normal form, cannot EvaluatesTo.
      · case EvaluatesToFalse => cases hacac' -- absurd, t.False is a normal form, cannot EvaluatesTo.
      · case EvaluatesToIf tthen telse =>
          rw [ih]
          exact telse

/--  Untyped Booleans and Naturals -/

inductive t' where
  | True : t'
  | False : t'
  | ite : t' → t' → t' → t'
  | zero : t'
  | succ : t' → t'
  | pred : t' → t'
  | iszero : t' → t'

inductive t'.EvaluatesTo : t' → t' → Prop
| -- ite true t₂ t₃ → t₂
  EvaluatesToTrue: t'.EvaluatesTo (t'.True.ite t₂ t₃) t₂
| -- ite false t₂ t₃ → t₃
  EvaluatesToFalse: t'.EvaluatesTo (t'.False.ite t₂ t₃) t₃
| -- (c → c') → (ite c l r → ite c' l r)
  EvaluatesToIf (h : t'.EvaluatesTo c c') : (c.ite l r).EvaluatesTo (c'.ite l r)
| -- (t₁ → t₁') → (succ t₁ → succ t₂)
  EvaluatesToSucc (h : t'.EvaluatesTo t₁ t₁') : (t'.succ t₁).EvaluatesTo (t'.succ t₁')
| -- pred 0 = 0
  EvaluatesToZero : (t'.pred t'.zero).EvaluatesTo (t'.zero)
| -- pred (succ nv) → nv
  EvaluatesToPredSucc : (t'.pred (t'.succ t₁)).EvaluatesTo  (t₁)
| -- (t₁ → t₁') → (pred t₁ → pred t₂)
  EvaluatesToPred (h : t'.EvaluatesTo t₁ t₁') : (t'.pred t₁).EvaluatesTo (t'.pred t₁')
| -- iszero 0 → true
  EvaluatesToIsZeroZero : (t'.iszero t'.zero).EvaluatesTo (t'.True)
| -- iszero (succ nv) → false
  EvaluatesToIsZeroSucc : (t'.iszero (t'.succ _)).EvaluatesTo (t'.False)
| -- (t₁ → t₁') → (iszero t₁ → iszero t₂)
  EvaluatesToIsZero (h : t'.EvaluatesTo t₁ t₁') : (t'.iszero t₁).EvaluatesTo (t'.iszero t₁')

/-- exercise 3.5.14: show that theorem 3.5.4 also holds for t' -/
theorem OneStepDeterminacy' (a b c : t') (hab : t'.EvaluatesTo a b) (hac : t'.EvaluatesTo a c) : b = c := by
  revert c -- bring hypothesis hac into the goal
  induction hab
  · -- a [EvaluatesToTrue]→ b
    -- i.e. a = (ite true b t) [EvaluatesToTrue]→ b
    case EvaluatesToTrue b t =>
    intro c hIteTrueEval
    -- let us focus on the rules that can reduce hIteTrueEval
    cases hIteTrueEval
    · -- either we reduce a = (ite true b t) → b
      -- using (ite true b t) [EvaluatesToTrue] → b
      case EvaluatesToTrue => rfl
    · -- or we reduce a = (ite true b t) → b
      -- using (ite true b t) [EvaluatesToIf] → a'.ite b t
      -- under the hypothesis that true → a'
      case EvaluatesToIf a' hTrueEvalToa' =>
        -- we now study the reduction of true → a'
        -- the only rule that allows for this reduction is: true [EvaluatesToTrue] → a'
        -- however, this reduction is absurd, since true (t'.True) is in NF already!
        -- in fact, no evaluation rule can reduce t'.True to anything.
        cases hTrueEvalToa'
  · -- a [EvaluatesToFalse]→ b
    -- i.e. a = (ite false b t) [EvaluatesToFalse]→ b
    case EvaluatesToFalse t c =>
    intro c hIteFalseEval
    -- we study hIteFalseEval
    cases hIteFalseEval
    · -- (ite false t c) [EvaluatesToFalse] → c
      case EvaluatesToFalse => rfl
    · -- (ite false t c) [EvaluatesToIf] → c
      -- required hypothesis false [EvaluatesTo?]→ c, which is absurd
      case EvaluatesToIf a' hFalseEvalToa' =>
        cases hFalseEvalToa'
  · -- a [EvaluatesToIf]→ b
    -- i.e. a [EvaluatesToIf]→ b
    -- in this case, we know that b will be something like b = ite b1 a2 a3
    -- and given a = ite a1 a2 a3, to have a [EvaluatesToIf]→ b we need a1 → b1
    case EvaluatesToIf a1 b1 a2 a3 haEvalTob ih =>
    -- haEvalTocImp : ∀ (c : t'), a1.EvaluatesTo c → b1 = c is the inductive hypothesis
    -- note that we are also supposing that a1 [EvaluatesToIf]→ b1
    intros c hIteEval
    -- we study the reductions that apply to hIteEval
    -- under the hypotheses that
    -- (1) (a1 → c) → b1 = c
    -- (2) a1 → b1
    cases hIteEval
    · -- we suppose a1 [EvaluatesToTrue]→ c
      -- from (2) it follows that true → b, which is absurd
      case EvaluatesToTrue => cases haEvalTob
    · -- absurd as above
      case EvaluatesToFalse => cases haEvalTob
    · -- we suppose a1 [EvaluatesToIf]→ c
      -- from (2) we know a1 → b1 : the evaluation rule applied to a must be the same
      -- considering the inductive hypothesis, if we can prove a1 → c then we're done.
      case EvaluatesToIf c1 haEvalToc =>
        rw [ih]
        apply haEvalToc
  · -- a [EvaluatesToSucc]→ b
    case EvaluatesToSucc a1 b1 haEvalTob ih  =>
    intro c haSuccEvalToc
    -- again we consider the rules for which haSuccEvalToc could happen
    -- which is only one: a1.succ [EvaluatesToSucc]→ c
    cases haSuccEvalToc
    · case EvaluatesToSucc c haEvalToc =>
      rw [ih]
      apply haEvalToc
  · -- a [EvaluateToZero]→ b
    case EvaluatesToZero =>
    -- if this is the case, we have a = t'.pred t'.zero as per the rule
    intro c hzeroEvalTo
    cases hzeroEvalTo
    · case EvaluatesToZero => rfl
    · case EvaluatesToPred c hZeroEvalTo =>
        cases c
        · case True => cases hZeroEvalTo -- absurd
        · case False => cases hZeroEvalTo -- absurd
        · case ite =>  cases hZeroEvalTo -- absurd
        · case zero => cases hZeroEvalTo -- absurd
        · case succ s => cases hZeroEvalTo -- absurd
        · case pred s => cases hZeroEvalTo -- actual predecessor
        · case iszero => cases hZeroEvalTo -- trivial
  · -- a [EvaluatesToPredSucc]→ b
    case EvaluatesToPredSucc a1 =>
    -- we suppose a = t'.pred (t'.succ t₁)
    intro c hSuccPredEvalTo
    -- consider hp: pred (succ a1) → c
    cases hSuccPredEvalTo
    · case EvaluatesToPredSucc => rfl
    · -- suppose pred (succ a1) [EvaluatesToPred]→ c1
      case EvaluatesToPred c1 hSuccEvalTo =>
        -- then a1 = pred c1

        cases c1
        · case True => cases hSuccEvalTo
        · case False => cases hSuccEvalTo
        · case ite => cases hSuccEvalTo
        · case zero => cases hSuccEvalTo
        · -- suppose a1 = pred (succ s)

          case succ s =>
            -- hp: succ a1 → succ s
            -- goal : a1 = pred (succ s)
            cases hSuccEvalTo
            case EvaluatesToSucc ha1EvalTo =>
            · cases a1
              · case True => cases ha1EvalTo
              · case False => cases ha1EvalTo
              · -- succ (ite t1 t2 t3) → succ (succ s)
                -- goal : ite t1 t2 t3 = pred (succ s)
                case ite t1 t2 t3 =>
                cases ha1EvalTo
                · case EvaluatesToTrue => sorry
                · case EvaluatesToFalse => sorry
                · case EvaluatesToIf ht1Eval => sorry
              · case _ => cases ha1EvalTo
              · case _ =>
                  sorry
              · case _ =>
                  sorry
              · case _ =>
                  sorry
        · case pred s => cases hSuccEvalTo
        · case iszero s => cases hSuccEvalTo
  · -- a [EvaluatesToPred]→ b
    case EvaluatesToPred a1 b1 haEvalTob ih =>
    intro c hPredEvalTo
    cases hPredEvalTo
    · case EvaluatesToZero => cases haEvalTob
    · case EvaluatesToPredSucc =>
        cases haEvalTob
        case EvaluatesToSucc c' hcEvalTo =>

          sorry
    · case EvaluatesToPred => sorry
  · -- a [EvaluatesToIsZeroZero]→ b
    case EvaluatesToIsZeroZero =>
    intro c hZeroIsZeroEvalTo
    cases hZeroIsZeroEvalTo
    · case EvaluatesToIsZeroZero => rfl
    · case EvaluatesToIsZero c' hZeroEvalTo => cases hZeroEvalTo
  · -- a [EvaluatesToIsZeroSucc]→ b
    case EvaluatesToIsZeroSucc s=>
    intro c hsuccIsZeroEvalTo
    cases hsuccIsZeroEvalTo
    · case EvaluatesToIsZeroSucc => rfl
    sorry
  · -- a [EvaluatesToIsZero]→ b
    case EvaluatesToIsZero a1 b1 haEvalTob ih =>
    intro c haIsZeroEvalTo
    cases haIsZeroEvalTo
    · case EvaluatesToIsZeroZero => cases haEvalTob
    · case EvaluatesToIsZeroSucc s =>
      sorry
    · case EvaluatesToIsZero =>
      sorry

/-
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
-/
