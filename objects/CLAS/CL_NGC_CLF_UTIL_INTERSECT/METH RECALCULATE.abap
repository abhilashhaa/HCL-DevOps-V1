METHOD recalculate.

  IF me->mt_recalc_classtype_range IS INITIAL OR " if the range is initial, we also need to insert
    ( iv_classtype NOT IN me->mt_recalc_classtype_range ) .
    APPEND VALUE #( sign   = if_ngc_core_c=>gc_range_sign-include
                    option = if_ngc_core_c=>gc_range_option-equals
                    low    = iv_classtype
                    high   = space ) TO me->mt_recalc_classtype_range.
  ENDIF.

ENDMETHOD.