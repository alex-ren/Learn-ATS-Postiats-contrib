(**
  The following definitions need to be made for each possible
  bitvector length we encounter. For starters, we just have 32
  bit vectors.
*)

datasort bv32 = (* abstract *)

stacst bv32_of_int: (int) -> bv32
stadef bv32 = bv32_of_int

stacst bv32_of_bool: (bool) -> bv32
stadef bv32 = bv32_of_bool

stacst int_of_bv32: bv32 -> int
stadef bv32toint = int_of_bv32

stacst signed_int_of_bv32: bv32 -> int

stacst is_power_of_2_bv32: (bv32) -> bool
stadef is_power_of_2 = is_power_of_2_bv32

stacst has_zero_byte_bv32: (bv32) -> bool
stadef has_zero_byte = has_zero_byte_bv32

stacst swap_bits_bv32: (bv32, bv32, bv32, bv32) -> bv32
stadef swap = swap_bits_bv32

stacst has_byte_bv32: (bv32, bv32) -> bool
stadef has_byte = has_byte_bv32

stacst min_bv32_bv32: (bv32, bv32) -> bv32
stadef min = min_bv32_bv32

stacst max_bv32_bv32: (bv32, bv32) -> bv32
stadef max = max_bv32_bv32

stacst cond_set_or_clear_bv32: (bv32, bv32, bv32) -> bv32
stadef cond_set_or_clear = cond_set_or_clear_bv32

stacst and_bv32_bv32: (bv32, bv32) -> bv32
stadef land = and_bv32_bv32

stacst or_bv32_bv32: (bv32, bv32) -> bv32
stadef lor = or_bv32_bv32

stacst xor_bv32_bv32: (bv32, bv32) -> bv32
stadef lxor = xor_bv32_bv32

stacst not_bv32: (bv32) -> bv32
stadef lnot = not_bv32

stacst lshl_bv32_bv32: (bv32, bv32) -> bv32
stadef << = lshl_bv32_bv32

stacst lshr_bv32_bv32: (bv32, bv32) -> bv32
stadef lshr = lshr_bv32_bv32

stacst ashr_bv32_bv32: (bv32, bv32) -> bv32
stadef ashr = ashr_bv32_bv32

stacst neg_bv32: (bv32) -> bv32
stadef ~ = neg_bv32

stacst sub_bv32_bv32: (bv32, bv32) -> bv32
stadef - = sub_bv32_bv32

stacst add_bv32_bv32: (bv32, bv32) -> bv32
stadef + = add_bv32_bv32

stacst mul_bv32_bv32: (bv32, bv32) -> bv32
stadef * = mul_bv32_bv32

stacst div_bv32_bv32: (bv32, bv32) -> bv32
stadef / = div_bv32_bv32

stacst udiv_bv32_bv32: (bv32, bv32) -> bv32
stadef udiv = udiv_bv32_bv32

stacst eq_bv32_bv32: (bv32, bv32) -> bool
stadef == = eq_bv32_bv32

stacst lt_bv32_bv32: (bv32, bv32) -> bool
stadef < = lt_bv32_bv32

stacst lte_bv32_bv32: (bv32, bv32) -> bool
stadef <= = lte_bv32_bv32

stacst gte_bv32_bv32: (bv32, bv32) -> bool
stadef >= = gte_bv32_bv32

stacst gt_bv32_bv32: (bv32, bv32) -> bool
stadef > = gt_bv32_bv32

stacst ult_bv32_bv32: (bv32, bv32) -> bool
stadef ult = ult_bv32_bv32

stacst ulte_bv32_bv32: (bv32, bv32) -> bool
stadef ule = ulte_bv32_bv32

stacst ugte_bv32_bv32: (bv32, bv32) -> bool
stadef uge = ugte_bv32_bv32

stacst ugt_bv32_bv32: (bv32, bv32) -> bool
stadef ugt = ugt_bv32_bv32