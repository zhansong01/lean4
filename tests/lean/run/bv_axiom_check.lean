import Std.Tactic.BVDecide

open BitVec

theorem bv_axiomCheck (x y z : BitVec 1) : x < y → y < z → x < z := by bv_decide

/--
info: 'bv_axiomCheck' depends on axioms: [propext, Classical.choice, Lean.ofReduceBool, Lean.trustCompiler, Quot.sound]
-/
#guard_msgs in
#print axioms bv_axiomCheck
