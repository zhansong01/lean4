example (a b : List Nat) : a = [] → b = [2] → a = b → False := by
  grind

example (a b : List Nat) : a = b → a = [] → b = [2] → False := by
  grind

example (a b : Bool) : a = true → b = false → a = b → False := by
  grind

example (a b : Sum Nat Bool) : a = .inl c → b = .inr true → a = b → False := by
  grind

example (a b : Sum Nat Bool) : a = b → a = .inl c → b = .inr true → a = b → False := by
  grind

inductive Foo (α : Type) : Nat → Type where
  | a (v : α) : Foo α 0
  | b (n : α) (m : Nat) (v : Vector Nat m) : Foo α (2*m)

example (h₁ : Foo.b x 2 v = f₁) (h₂ : Foo.b y 2 w = f₂) : f₁ = f₂ → x = y := by
  grind

example (h₁ : Foo.a x = f₁) (h₂ : Foo.a y = f₂) : f₁ = f₂ → x = y := by
  grind

example (h₁ : a :: b = x) (h₂ : c :: d = y) : x = y → a = c := by
  grind

example (h : x = y) (h₁ : a :: b = x) (h₂ : c :: d = y) : a = c := by
  grind

example (h : x = y) (h₁ : a :: b = x) (h₂ : c :: d = y) : b = d := by
  grind

example (a b : Sum Nat Bool) : a = .inl x → b = .inl y → x ≠ y → a = b → False := by
  grind

example (a b : Nat) : a = 1 → b = 2 → a = b → False := by
  grind

example (a b c : Int) : a = 1 → c = -2 → a = b → c = b → False := by
  grind

example (a b : Char) : a = 'h' → b = 'w' → a = b → False := by
  grind

example (a b : String) : a = "hello" → b = "world" → a = b → False := by
  grind

example (a b c : String) : a = c → a = "hello" → c = "world" → c = b → False := by
  grind

example (a b c : BitVec 32) : a = c → a = 1#32 → c = 2#32 → c = b → False := by
  grind

example (a b c : UInt32) : a = c → a = 1 → c = 200 → c = b → False := by
  grind

structure Boo (α : Type) where
  a : α
  b : α
  c : α

example (a b d : Nat) (f : Nat → Boo Nat) : (f d).1 ≠ a → f d = ⟨b, v₁, v₂⟩ → b = a → False := by
  grind

def ex (a b c d : Nat) (f : Nat → Boo Nat) : (f d).2 ≠ a → f d = ⟨b, c, v₂⟩ → c = a → False := by
  grind

example (a b c : Nat) (f : Nat → Nat) : { a := f b, c, b := 4 : Boo Nat }.1 ≠ f a → f b = f c → a = c → False := by
  grind

example (a b c : Nat) (f : Nat → Nat) : p = { a := f b, c, b := 4 : Boo Nat } → p.1 ≠ f a → f b = f c → a = c → False := by
  grind

example (a b c : Nat) (f : Nat → Nat) : p.1 ≠ f a → p = { a := f b, c, b := 4 : Boo Nat } → f b = f c → a = c → False := by
  grind

/--
trace: [grind.debug.proj] { a := b, b := v₁, c := v₂ }.a
-/
#guard_msgs (trace) in
set_option trace.grind.debug.proj true in
example (a b d e : Nat) (x y z : Boo Nat) (f : Nat → Boo Nat) : (f d).1 ≠ a → f d = ⟨b, v₁, v₂⟩ → x.1 = e → y.1 = e → z.1 = e → f d = x → f d = y → f d = z → b = a → False := by
  grind

example (f : Nat → Nat) (a b c : Nat) : f (if a = b then x else y) = z → a = c → c = b → f x = z := by
  grind

example (f : Nat → Nat) (a b c : Nat) : f (if a = b then x else y) = z → a = c → b ≠ c → f y = z := by
  grind

namespace dite_propagator_test

opaque R : Nat → Nat → Prop
opaque f (a : Nat) (b : Nat) (_ : R a b) : Nat
opaque g (a : Nat) (b : Nat) (_ : ¬ R a b) : Nat
open Classical

example (foo : Nat → Nat)
        (_ : foo (if h : R a c then f a c h else g a c h) = x)
        (_ : R a b)
        (_ : c = b) : foo (f a c (by grind)) = x := by
  grind

example (foo : Nat → Nat)
        (_ : foo (if h : R a c then f a c h else g a c h) = x)
        (_ : ¬ R a b)
        (_ : c = b)
        : foo (g a c (by grind)) = x := by
  grind

end dite_propagator_test

/--
trace: [grind.eqc] x = 2 * a
[grind.eqc] y = x
[grind.eqc] (y = 2 * a) = False
-/
#guard_msgs (trace) in
set_option trace.grind.eqc true in
example (a : Nat) : let x := a + a; y = x → y = a + a := by
  grind -zetaDelta

/--
trace: [grind.eqc] x = 2 * a
[grind.eqc] y = x
[grind.eqc] (y = 2 * a) = False
-/
#guard_msgs (trace) in
set_option trace.grind.eqc true in
example (a : Nat) : have x := a + a; y = x → y = a + a := by
  grind -zetaDelta

/--
trace: [grind.eqc] y = 2 * a
[grind.eqc] (y = 2 * a) = False
-/
#guard_msgs (trace) in
set_option trace.grind.eqc true in
example (a : Nat) : have x := a + a; y = x → y = a + a := by
  grind

example (α : Type) (β : Type) (a₁ a₂ : α) (b₁ b₂ : β)
        (h₁ : α = β)
        (h₂ : cast h₁ a₁ = b₁)
        (h₃ : a₁ = a₂)
        (h₄ : b₁ = b₂)
        : a₂ ≍ b₂ := by
  grind

example (α : Type) (β : Type) (a₁ a₂ : α) (b₁ b₂ : β)
        (h₁ : α = β)
        (h₂ : h₁ ▸ a₁ = b₁)
        (h₃ : a₁ = a₂)
        (h₄ : b₁ = b₂)
        : a₂ ≍ b₂ := by
  grind

example (α : Type) (β : Type) (a₁ a₂ : α) (b₁ b₂ : β)
        (h₁ : α = β)
        (h₂ : Eq.recOn h₁ a₁ = b₁)
        (h₃ : a₁ = a₂)
        (h₄ : b₁ = b₂)
        : a₂ ≍ b₂ := by
  grind

example (α : Type) (β : Type) (a₁ a₂ : α) (b₁ b₂ : β)
        (h₁ : α = β)
        (h₂ : Eq.ndrec (motive := id) a₁ h₁ = b₁)
        (h₃ : a₁ = a₂)
        (h₄ : b₁ = b₂)
        : a₂ ≍ b₂ := by
  grind

example (α : Type) (β : Type) (a₁ a₂ : α) (b₁ b₂ : β)
        (h₁ : α = β)
        (h₂ : Eq.rec (motive := fun x _ => x) a₁ h₁ = b₁)
        (h₃ : a₁ = a₂)
        (h₄ : b₁ = b₂)
        : a₂ ≍ b₂ := by
  grind

/--
trace: [grind.assert] ∀ (a : α), a ∈ b → p a
[grind.ematch.pattern] h₁: [@Membership.mem `[α] `[List α] `[List.instMembership] `[b] #1]
[grind.ematch.pattern] h₁: [p #1]
[grind.assert] w ∈ b
[grind.assert] ¬p w
[grind.ematch.instance] h₁: w ∈ b → p w
[grind.assert] w ∈ b → p w
-/
#guard_msgs (trace) in
set_option trace.grind.ematch.pattern true in
set_option trace.grind.ematch.instance true in
set_option trace.grind.assert true in
example (b : List α) (p : α → Prop) (h₁ : ∀ a ∈ b, p a) (h₂ : ∃ a ∈ b, ¬p a) : False := by
  grind

/--
trace: [grind.assert] ∀ (x : α), Q x → P x
[grind.ematch.pattern] h₁: [Q #1]
[grind.ematch.pattern] h₁: [P #1]
[grind.assert] ∀ (x : α), R x → False = P x
[grind.ematch.pattern] h₂: [R #1]
[grind.ematch.pattern] h₂: [P #1]
[grind.assert] Q a
[grind.assert] R a
[grind.ematch.instance] h₁: Q a → P a
[grind.ematch.instance] h₂: R a → False = P a
[grind.assert] Q a → P a
[grind.assert] R a → False = P a
-/
#guard_msgs (trace) in
set_option trace.grind.ematch.pattern true in
set_option trace.grind.ematch.instance true in
set_option trace.grind.assert true in
example (P Q R : α → Prop) (h₁ : ∀ x, Q x → P x) (h₂ : ∀ x, R x → False = (P x)) : Q a → R a → False := by
  grind

example (w : Nat → Type) (h : ∀ n, Subsingleton (w n)) : True := by
  grind

example {P1 P2 : Prop} : (P1 ∧ P2) ↔ (P2 ∧ P1) := by
  grind

example {P U V W : Prop} (h : P ↔ (V ↔ W)) (w : ¬ U ↔ V) : ¬ P ↔ (U ↔ W) := by
  grind

example {P Q : Prop} (q : Q) (w : P = (P = ¬ Q)) : False := by
  grind

example (P Q : Prop) : (¬P → ¬Q) ↔ (Q → P) := by
  grind

example {α} (a b c : α) [LE α] :
  ¬(¬a ≤ b ∧ a ≤ c ∨ ¬a ≤ c ∧ a ≤ b) ↔ a ≤ b ∧ a ≤ c ∨ ¬a ≤ c ∧ ¬a ≤ b := by
  simp +arith -- should not fail
  sorry

example {α} (a b c : α) [LE α] :
  ¬(¬a ≤ b ∧ a ≤ c ∨ ¬a ≤ c ∧ a ≤ b) ↔ a ≤ b ∧ a ≤ c ∨ ¬a ≤ c ∧ ¬a ≤ b := by
  grind

example (x y : Bool) : ¬(x = true ↔ y = true) ↔ (¬(x = true) ↔ y = true) := by
  grind

/--
error: `grind` failed
case grind
p q : Prop
h : p = q
h_1 : p
⊢ False
[grind] Goal diagnostics
  [facts] Asserted facts
    [prop] p = q
    [prop] p
  [eqc] True propositions
    [prop] p
    [prop] q
    [prop] p = q
-/
#guard_msgs (error) in
set_option trace.grind.split true in
example (p q : Prop) : (p ↔ q) → p → False := by
  grind -- should not split on (p ↔ q)

/--
error: `grind` failed
case grind
p q : Prop
h : p = q
h_1 : p
⊢ False
-/
#guard_msgs (error) in
example (p q : Prop) : (p ↔ q) → p → False := by
  grind -verbose -- We should not get any diagnostics


/--
error: `grind` failed
case grind
p q : Prop
h : p = ¬q
h_1 : p
⊢ False
[grind] Goal diagnostics
  [facts] Asserted facts
    [prop] p = ¬q
    [prop] p
  [eqc] True propositions
    [prop] p
    [prop] ¬q
    [prop] p = ¬q
  [eqc] False propositions
    [prop] q
-/
#guard_msgs (error) in
set_option trace.grind.split true in
example (p q : Prop) : ¬(p ↔ q) → p → False := by
  grind -- should not split on (p ↔ q)

example {a b : Nat} (h : a < b) : ¬ b < a := by
  grind

example {m n : Nat} : m < n ↔ m ≤ n ∧ ¬ n ≤ m := by
  grind

example {α} (f : α → Type) (a : α) (h : ∀ x, Nonempty (f x)) : Nonempty (f a) := by
  grind

example {α β} (f : α → β) (a : α) : ∃ a', f a' = f a := by
  grind

attribute [grind ext] List.ext_getElem?

open List in
example : (replicate n a).map f = replicate n (f a) := by
  grind +splitIndPred only [Option.map_some, Option.map_none, getElem?_map, getElem?_replicate]

open List in
example : (replicate n a).map f = replicate n (f a) := by
  grind only [cases Exists, Option.map_some, Option.map_none, getElem?_map, getElem?_replicate]

open List in
example : (replicate n a).map f = replicate n (f a) := by
  grind only [cases Exists, Option.map_some, Option.map_none, getElem?_map, getElem?_replicate]

open List in
example : (replicate n a).map f = replicate n (f a) := by
  -- Should fail since extensionality is disabled
  fail_if_success grind -ext only [Option.map_some, Option.map_none, getElem?_map, getElem?_replicate]
  sorry

@[ext, grind ext] structure S where
  a : Nat
  b : Bool

example (x y : S) : x.a = y.a → y.b = x.b → x = y := by
  grind

example (x y : S) : x.a = y.a → y.b = x.b → x = y := by
  fail_if_success grind -etaStruct
  sorry

attribute [grind ext] S.ext -- enable extensionality using S.ext

example (x y : S) : x.a = y.a → y.b = x.b → x = y := by
  grind -etaStruct -- It is applying the extensionality theorem instead of eta for structures

example (x y : S) : x.a = y.a → y.b = x.b → x = y := by
  fail_if_success grind -etaStruct -ext
  sorry

example (x : S) : x.a = 10 → false ≠ x.b → x = { a := 10, b := true } := by
  grind


-- In the following test, we should not display `10 := 10` and `20 := 20` in the
-- assignment produced by the offset module
/--
error: `grind` failed
case grind
a : Nat
b : Bool
h : (if b = true then 10 else 20) = a
h_1 : b = true
⊢ False
[grind] Goal diagnostics
  [facts] Asserted facts
    [prop] (if b = true then 10 else 20) = a
    [prop] b = true
  [eqc] True propositions
    [prop] b = true
  [eqc] Equivalence classes
    [eqc] {a, 10, if b = true then 10 else 20}
    [eqc] {b, true}
  [cutsat] Assignment satisfying linear constraints
    [assign] a := 10
-/
#guard_msgs (error) in
example (b : Bool) : (if b then 10 else 20) = a → b = true → False := by
  grind

-- Should not generate a trace message about canonicalization issues
#guard_msgs (trace) in
set_option trace.grind.issues true in
example : (if n + 2 < m then a else b) = (if n + 1 < m then c else d) := by
  fail_if_success grind (splits := 0)
  sorry

example (f : Nat → Nat) : f (a + 1) = 1 → a = 0 → f 1 = 1 := by
  grind

example [Decidable p] : a = true → decide p = a → p := by
  grind

example [Decidable p] : false = a → decide p = a → ¬p := by
  grind

example [Decidable p] : a = true → p → decide p = a := by
  grind

example [Decidable p] : false = a → ¬p → decide p = a := by
  grind

example (a : Nat) (p q r : Prop) (h₁ : if _ : a < 1 then p else q) (h₂ : r) : (if a < 1 then p else q) ↔ r := by
  grind (splits := 0)

example [BEq α] [LawfulBEq α] (a b : α) : a == b → a = b := by
  grind

example [BEq α] [LawfulBEq α] {a : α} : (a::as).replace a b = b::as := by
  grind [List.replace]

example [BEq α] [LawfulBEq α] {a : α} : (a::as).replace a b = b::as := by
  grind [List.replace_cons]

def foo [BEq α] (a b : α) :=
  match a == b with
  | true => 1
  | false => 0

example [BEq α] [LawfulBEq α] (a b : α) : a = b → foo a b = 1 := by
  grind (splits := 0) [foo]

example [BEq α] [LawfulBEq α] (a b : α) : a ≠ b → foo a b = 0 := by
  grind [foo]

example [BEq α] [LawfulBEq α] (a b : α) : a ≠ b → foo a b = 0 := by
  grind (splits := 0) [foo]

@[simp] theorem getElem_concat_length {l : List α} {a : α} {i : Nat} (h : i = l.length) (w) :
    (l ++ [a])[i]'w = a := by
  subst h; grind [List.getElem_append_left, List.getElem_append_right]

example (p q : Prop) : (p → q) → (¬ p → q) → (p → ¬ q) → (¬p → ¬q) → False := by
  grind (splitImp := true)


/-! Pull universal over disjunction -/

opaque p : (i : Nat) → i ≠ 10 → Prop

-- This example does not require pulling quantifiers
example (h : ∀ i, i > 0 → ∀ h : i ≠ 10, p i h) : p 5 (by decide) := by
  grind

-- This one is semantically equivalent to the previous example, but can only be proved by `grind` after
-- we pull universal over disjunctions during normalization.
example (h : ∀ i, (¬i > 0) ∨ ∀ h : i ≠ 10, p i h) : p 5 (by decide) := by
  grind

-- Similar to previous test.
example (h : ∀ i, (∀ h : i ≠ 10, p i h) ∨ (¬i > 0)) : p 5 (by decide) := by
  grind

-- `grind` performs hash-consing modulo alpha-equivalence
/--
trace: [grind.assert] (f fun x => x) = a
[grind.assert] ¬a = f fun x => x
-/
#guard_msgs (trace) in
example (f : (Nat → Nat) → Nat) : f (fun x => x) = a → a = f (fun y => y) := by
  set_option trace.grind.assert true in
  grind
