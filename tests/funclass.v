From HB Require Import structures.

HB.mixin Record has_assoc T (F : T -> T -> T) := {
  assoc : forall x y z : T , F x (F y z) = F (F x y) z
}.

HB.mixin Record has_neutral T (F : T -> T -> T) := {
  id : T;
  idl : forall x : T , F id x = x;
  idr : forall x : T , F x id = x;
}.

HB.structure Definition Magma T := { F of has_assoc T F }.
HB.structure Definition Monoid T := { F of Magma T F & has_neutral T F }.
Require Import Arith.

HB.instance Definition xxx := has_assoc.Build nat plus plus_assoc.

Lemma plus_O_r x : x + 0 = x. Proof. now rewrite plus_n_O.  Qed.
HB.instance Definition yyy := has_neutral.Build nat plus 0 plus_O_n plus_O_r.

Check Monoid.of plus.