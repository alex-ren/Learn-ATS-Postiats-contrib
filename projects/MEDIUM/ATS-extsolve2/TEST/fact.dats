(* ****** ****** *)
//
fun
fact{n:nat}(n: int(n)): int =
  if n > 0 then n * fact(n-1) else 1
//
(* ****** ****** *)

(* end of [fact.dats] *)