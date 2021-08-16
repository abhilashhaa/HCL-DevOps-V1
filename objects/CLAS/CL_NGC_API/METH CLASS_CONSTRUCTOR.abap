METHOD class_constructor.

  gt_valid_charcdatatype = VALUE #(
    ( sign = if_ngc_core_c=>gc_range_sign-include option = if_ngc_core_c=>gc_range_option-equals low = if_ngc_c=>gc_charcdatatype-char )
    ( sign = if_ngc_core_c=>gc_range_sign-include option = if_ngc_core_c=>gc_range_option-equals low = if_ngc_c=>gc_charcdatatype-num  )
    ( sign = if_ngc_core_c=>gc_range_sign-include option = if_ngc_core_c=>gc_range_option-equals low = if_ngc_c=>gc_charcdatatype-curr )
    ( sign = if_ngc_core_c=>gc_range_sign-include option = if_ngc_core_c=>gc_range_option-equals low = if_ngc_c=>gc_charcdatatype-date )
    ( sign = if_ngc_core_c=>gc_range_sign-include option = if_ngc_core_c=>gc_range_option-equals low = if_ngc_c=>gc_charcdatatype-time )
  ).

ENDMETHOD.