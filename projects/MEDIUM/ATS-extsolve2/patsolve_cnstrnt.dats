(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./patsolve_cnstrnt.sats"

(* ****** ****** *)
//
implement
fprint_val<stamp> = fprint_stamp
implement
fprint_val<symbol> = fprint_symbol
//
(* ****** ****** *)

implement
fprint_val<s2cst> = fprint_s2cst
implement
fprint_val<s2var> = fprint_s2var
implement
fprint_val<s2exp> = fprint_s2exp

(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_stamp.dats"
//
in
  // nothing
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_symbol.dats"
//
in
  // nothing
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_location.dats"
//
in
  // nothing
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_s2cst.dats"
//
in
  // nothing
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_s2var.dats"
//
in
  // nothing
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_s2vvar.dats"
//
in
  // nothing
end // end of [local]
//
(* ****** ****** *)
//
local
//
#include
"./CNSTRNT/patsolve_cnstrnt_s2exp.dats"
//
in
  // nothing
end // end of [local]
//
(* ****** ****** *)

(* end of [patsolve_cnstrnt.dats] *)
