(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"./../prelude/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun
listlen
  : {a:t@ype} List0 (a) -> int = "mac#listlen"
//
implement
listlen{a}
  (xs) = let
//
prval () = lemma_list_param (xs)
//
fun
loop{i,j:nat} .<i>.
(
  xs: list (a, i), res: int(j)
) : int(i+j) = let
in
//
case+ xs of
| list_nil () => res | list_cons (_, xs) => loop (xs, res+1)
//
end // end of [loop]
//
in
  loop (xs, 0)
end // end of [intlistlen]

(* ****** ****** *)
//
extern
fun
fromto
  : (int, int) -> List0 (int) = "mac#fromto"
//
implement
fromto (m, n) =
if m < n
  then list_cons (m, fromto (m+1, n)) else list_nil ()
// end of [if]
//
(* ****** ****** *)

%{^
//
// file inclusion:
//
var fs = require('fs');
eval(fs.readFileSync('./../prelude/CATS/basics_cats.js').toString());
eval(fs.readFileSync('./../prelude/CATS/integer_cats.js').toString());
%} // end of [%{^]

(* ****** ****** *)

%{$
var xs = fromto(0, 10)
console.log("listlen(", xs, ") =", listlen(xs))
%} // end of [%{$]

(* ****** ****** *)

(* end of [listlen.dats] *)
