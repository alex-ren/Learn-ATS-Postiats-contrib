(* ****** ****** *)
//
// ATS-parse-emit-python
//
(* ****** ****** *)
//
// HX-2014-08-04: start
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload "./atsparemit.sats"
staload "./atsparemit_syntax.sats"
//
(* ****** ****** *)
//
staload "./atsparemit_emit.sats"
//
(* ****** ****** *)
//
staload "./atsparemit_topenv.dats"
//
(* ****** ****** *)

implement
emit_ENDL (out) = emit_text (out, "\n")

(* ****** ****** *)

implement
emit_SPACE (out) = emit_text (out, " ")

(* ****** ****** *)

implement
emit_SHARP (out) = emit_text (out, "#")

(* ****** ****** *)
//
implement
emit_LPAREN (out) = emit_text (out, "(")
implement
emit_RPAREN (out) = emit_text (out, ")")
//
implement
emit_LBRACKET (out) = emit_text (out, "[")
implement
emit_RBRACKET (out) = emit_text (out, "]")
//
implement
emit_LBRACE (out) = emit_text (out, "{")
implement
emit_RBRACE (out) = emit_text (out, "}")
//
(* ****** ****** *)

implement
emit_flush (out) = fileref_flush (out)
implement
emit_newline (out) = fprint_newline (out)

(* ****** ****** *)
//
implement
emit_nspc (out, ind) =
(
//
if ind > 0 then
  (emit_text (out, " "); emit_nspc (out, ind-1))
//
) (* end of [emit_nspc] *)
//
(* ****** ****** *)
//
implement
emit_int (out, x) = fprint_int (out, x)
//
implement
emit_text (out, x) = fprint_string (out, x)
//
(* ****** ****** *)
//
implement
emit_symbol (out, x) =
  fprint_string (out, symbol_get_name (x))
//
(* ****** ****** *)
//
implement
emit_PMVint
  (out, tok) = let
//
val-T_INT(base, rep) = tok.token_node
//
in
  emit_text (out, rep)
end // end of [emit_PMVint]
//
implement
emit_PMVintrep
  (out, tok) = let
//
val-T_INT(base, rep) = tok.token_node
//
in
  emit_text (out, rep)
end // end of [emit_PMVintrep]
//
(* ****** ****** *)
//
implement
emit_PMVbool
  (out, tfv) =
(
  emit_text (out, if tfv then "True" else "False")
) (* end of [emit_PMVbool] *)
//
(* ****** ****** *)

implement
emit_PMVstring
  (out, tok) = let
//
val-T_STRING(rep) = tok.token_node
//
in
  emit_text (out, rep)
end // end of [emit_PMVstring]

(* ****** ****** *)

implement
emit_PMVfloat
  (out, tok) = let
//
val-T_FLOAT(base, rep) = tok.token_node
//
in
  emit_text (out, rep)
end // end of [emit_PMVfloat]

(* ****** ****** *)

implement
emit_PMVi0nt
  (out, tok) = let
//
val-T_INT(base, rep) = tok.token_node
//
in
  emit_text (out, rep)
end // end of [emit_PMVi0nt]

(* ****** ****** *)

implement
emit_PMVf0loat
  (out, tok) = let
//
val-T_FLOAT(base, rep) = tok.token_node
//
in
  emit_text (out, rep)
end // end of [emit_PMVf0loat]

(* ****** ****** *)

implement
emit_PMVfunlab
  (out, flab) = let
in
  emit_label (out, flab)
end // end of [emit_PMVfunlab]

(* ****** ****** *)

implement
emit_PMVcfunlab
  (out, fl, d0es) =
{
//
val () =
  emit_label (out, fl)
val () =
  emit_text (out, "__closurerize")
//
val () = emit_LPAREN (out)
val () = emit_d0explst (out, d0es)
val () = emit_RPAREN (out)
//
} (* end of [emit_PMVcfunlab] *)

(* ****** ****** *)
//
implement
emit_i0de
  (out, id) = emit_symbol (out, id.i0de_sym)
implement
emit_label
  (out, lab) = emit_symbol (out, lab.i0de_sym)
//
(* ****** ****** *)

implement
emit_d0exp
  (out, d0e0) = let
in
//
case+
d0e0.d0exp_node of
//
| D0Eide (id) =>
  {
    val () = emit_symbol (out, id)
  }
//
| D0Eappid (id, d0es) =>
  {
    val () = emit_i0de (out, id)
    val () = emit_LPAREN (out)
    val () = emit_d0explst (out, d0es)
    val () = emit_RPAREN (out)
  }
| D0Eappexp (d0e, d0es) =>
  {
    val () = emit_d0exp (out, d0e)
    val () = emit_LPAREN (out)
    val () = emit_d0explst (out, d0es)
    val () = emit_RPAREN (out)
  }
//
| D0Elist (d0es) =>
  {
    val () = emit_text (out, "__D0Elist__")
    val () = emit_LPAREN (out)
    val () = emit_d0explst (out, d0es)
    val () = emit_RPAREN (out)
  }
//
| ATSempty (x) => emit_text (out, "None")
//
| ATSPMVint (tok) => emit_PMVint (out, tok)
| ATSPMVintrep (tok) => emit_PMVintrep (out, tok)
//
| ATSPMVbool (tfv) => emit_PMVbool (out, tfv)
//
| ATSPMVstring (tok) => emit_PMVstring (out, tok)
//
| ATSPMVi0nt (tok) => emit_PMVi0nt (out, tok)
| ATSPMVf0loat (tok) => emit_PMVfloat (out, tok)
//
| ATSPMVfunlab (fl) => emit_PMVfunlab (out, fl)
| ATSPMVcfunlab
    (_(*knd*), fl, d0es) => emit_PMVcfunlab (out, fl, d0es)
//
| ATSSELcon _ => emit_SELcon (out, d0e0)
//
| ATSSELrecsin _ => emit_text (out, "ATSSELrecsin(...)")
//
| ATSSELboxrec _ => emit_SELboxrec (out, d0e0)
//
| ATSSELfltrec _ => emit_text (out, "ATSSELfltrec(...)")
//
| ATSfunclo_fun
    (d2e, _(*arg*), _(*res*)) => emit_d0exp (out, d2e)
| ATSfunclo_clo
    (d2e, _(*arg*), _(*res*)) =>
  (
    emit_d0exp (out, d2e);
    emit_LBRACKET (out); emit_int (out, 0); emit_RBRACKET (out)
  ) (* end of [ATSfunclo_clo] *)
//
end // end of [emit_d0exp]

(* ****** ****** *)

local

fun
loop
(
  out: FILEref, d0es: d0explst, i: int
) : void =
(
case+ d0es of
| list_nil () => ()
| list_cons (d0e, d0es) => let
    val () =
      if i > 0 then emit_text (out, ", ")
    // end of [val]
  in
    emit_d0exp (out, d0e); loop (out, d0es, i+1)
  end // end of [list_cons]
)

in (* in-of-local *)

implement
emit_d0explst (out, d0es) = loop (out, d0es, 0)
implement
emit_d0explst_1 (out, d0es) = loop (out, d0es, 1)

end // end of [local]

(* ****** ****** *)
//
extern
fun
tyrec_labsel
  (tyrec: tyrec, lab: symbol): int
//
implement
tyrec_labsel
  (tyrec, lab) = let
//
fun loop
(
  xs: tyfldlst, i: int
) : int =
(
case+ xs of
| list_cons (x, xs) => let
    val TYFLD (id, s0e) = x.tyfld_node
  in
    if lab = id.i0de_sym then i else loop (xs, i+1)
  end // end of [list_cons
| list_nil ((*void*)) => ~1(*error*)
)
//
in
  loop (tyrec.tyrec_node, 0)
end // end of [tyrec_labsel]
//
(* ****** ****** *)

implement
emit_SELcon
  (out, d0e) = let
//
val-ATSSELcon
  (d0rec, s0e, id) = d0e.d0exp_node
val-S0Eide (name) = s0e.s0exp_node
val-~Some_vt (s0rec) = typedef_search_opt (name)
//
val index = tyrec_labsel (s0rec, id.i0de_sym)
//
val () =
  emit_d0exp (out, d0rec)
//
val () = emit_LBRACKET (out)
val () = emit_int (out, index)
val () = emit_RBRACKET (out)
//
in
  // nothing
end // end of [emit_SELcon]

(* ****** ****** *)

implement
emit_SELboxrec
  (out, d0e) = let
//
val-ATSSELboxrec
  (d0rec, s0e, id) = d0e.d0exp_node
val-S0Eide (name) = s0e.s0exp_node
val-~Some_vt (s0rec) = typedef_search_opt (name)
//
val index = tyrec_labsel (s0rec, id.i0de_sym)
//
val () =
  emit_d0exp (out, d0rec)
//
val () = emit_LBRACKET (out)
val () = emit_int (out, index)
val () = emit_RBRACKET (out)
//
in
  // nothing
end // end of [emit_SELboxrec]

(* ****** ****** *)
//
#define
ATSEXTCODE_BEG "######\n#ATSextcode_beg()\n######"
#define
ATSEXTCODE_END "######\n#ATSextcode_end()\n######\n"
//
(* ****** ****** *)

implement
emit_d0ecl
  (out, d0c) = let
in
//
case+
d0c.d0ecl_node of
//
| D0Cinclude _ => ()
//
| D0Cifdef _ => ()
| D0Cifndef _ => ()
//
| D0Ctypedef (id, def) =>
    typedef_insert (id.i0de_sym, def)
//
| D0Cdyncst_mac _ => ()
| D0Cdyncst_extfun _ => ()
//
| D0Cfundecl
    (fk, f0d) => emit_f0decl (out, f0d)
//
| D0Cextcode (toks) =>
  {
    val () = emit_text (out, ATSEXTCODE_BEG)
    val () = emit_extcode (out, toks)
    val () = emit_text (out, ATSEXTCODE_END)
  }
//
| D0Cclosurerize
  (
    fl, env, arg, res
  ) => emit_closurerize (out, fl, env, arg, res)
//
end // end of [emit_d0ecl]

(* ****** ****** *)

implement
emit_extcode
  (out, toks) = let
//
fun aux
(
  out: FILEref, tok: token
) : void =
(
case+
tok.token_node of
//
| T_KWORD _ => ()
//
| T_ENDL () => emit_ENDL (out)
| T_SPACES (cs) => emit_text (out, cs)
//
| T_COMMENT_line () =>
    emit_text (out, "#COMMENT_line\n")
| T_COMMENT_block () => ((*ignored*))
//
| T_INT (_, rep) => emit_text (out, rep)
//
| T_STRING (str) => emit_text (out, str)
//
| T_IDENT_alp (name) => emit_text (out, name)
| T_IDENT_srp (name) =>
  (
    emit_SHARP (out); emit_text (out, name)
  ) (* end of [T_IDENT_srp] *)
//
| T_IDENT_sym (name) => emit_text (out, name)
//
| T_LPAREN () => emit_LPAREN (out)
| T_RPAREN () => emit_RPAREN (out)
//
| T_LBRACKET () => emit_LBRACKET (out)
| T_RBRACKET () => emit_RBRACKET (out)
//
| T_LBRACE () => emit_LBRACE (out)
| T_RBRACE () => emit_RBRACE (out)
//
| T_LT () => emit_text (out, "<")
| T_GT () => emit_text (out, ">")
//
| T_MINUS () => emit_text (out, "-")
//
| T_COLON () => emit_text (out, ":")
//
| T_COMMA () => emit_text (out, ",")
| T_SEMICOLON () => emit_text (out, ";")
//
| T_SLASH () => emit_text (out, "/")
//
| _ (*unrecognized*) =>
  {
    val () = fprint! (out, "TOKERR(", tok, ")")
  }
)
//
in
//
case+ toks of
| list_nil () => ()
| list_cons (tok, toks) =>
  (
    aux (out, tok); emit_extcode (out, toks)
  ) (* end of [list_cons] *)
//
end // end of [emit_extcode]

(* ****** ****** *)

local

fun
aux0_arglst
(
  out: FILEref
, s0es: s0explst
, n0: int, i: int
) : void =
(
case+ s0es of
| list_nil () => ()
| list_cons
    (s0e, s0es) => let
    val () =
    if n0+i > 0 then emit_text (out, ", ")
    val () =
    (
      emit_text (out, "arg"); emit_int (out, i)
    ) (* end of [val] *)
  in
    aux0_arglst (out, s0es, n0, i+1)
  end // end of [list_cons]
) (* end of [aux0_arglst] *)

fun
aux0_envlst
(
  out: FILEref
, s0es: s0explst
, n0: int, i: int
) : void =
(
case+ s0es of
| list_nil () => ()
| list_cons
    (s0e, s0es) => let
    val () =
    if n0+i > 0 then emit_text (out, ", ")
    val () =
    (
      emit_text (out, "env"); emit_int (out, i)
    ) (* end of [val] *)
  in
    aux0_envlst (out, s0es, n0, i+1)
  end // end of [list_cons]
) (* end of [aux0_envlst] *)

fun
aux1_envlst
(
  out: FILEref
, s0es: s0explst, i: int
) : int =
(
case+ s0es of
| list_nil () => (i)
| list_cons
    (s0e, s0es) => let
    val () =
    if i > 0 then emit_text (out, ", ")
    val () =
    (
      emit_text (out, "cenv");
      emit_LBRACKET (out); emit_int (out, i+1); emit_RBRACKET (out)
    ) (* end of [val] *)
  in
    aux1_envlst (out, s0es, i+1)
  end // end of [list_cons]
) (* end of [aux1_envlst] *)

in (* in-of-local *)

implement
emit_closurerize
(
  out, fl, env, arg, res
) = let
//
val-S0Elist(s0es_env) = env.s0exp_node
val-S0Elist(s0es_arg) = arg.s0exp_node
//
val () =
  emit_text (out, "def ")
val () = emit_label (out, fl)
val () =
emit_text (out, "__closurerize(")
val () = aux0_envlst (out, s0es_env, 0, 0)
val ((*closing*)) = emit_text (out, "):\n")
//
val () = emit_nspc (out, 2)
val () = emit_text (out, "def ")
val () = emit_label (out, fl)
val () = emit_text (out, "__cfun(")
val () = emit_text (out, "cenv")
val () = aux0_arglst (out, s0es_arg, 1, 0)
val ((*closing*)) = emit_text (out, "):\n")
//
val () = emit_nspc (out, 4)
val () = emit_text (out, "return ")
val () = emit_label (out, fl)
val () = emit_LPAREN (out)
val n0 = aux1_envlst (out, s0es_env, 0)
val () = aux0_arglst (out, s0es_arg, n0, 0)
val ((*closing*)) = emit_text (out, ")\n")
//
val () = emit_nspc (out, 2)
val () = emit_text (out, "return (")
val () = emit_label (out, fl)
val () = emit_text (out, "__cfun, ")
val () = aux0_envlst (out, s0es_env, 0, 0)
val ((*closing*)) = emit_text (out, ")\n")
//
val () = emit_newline (out)
//
in
end // end of [emit_closurerize]

end // end of [local]

(* ****** ****** *)

(* end of [atsparemit_emit_py.dats] *)
