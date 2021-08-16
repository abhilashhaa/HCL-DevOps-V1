METHOD simplify_value.

  rs_char_value = is_char_value.

  " >= Min - < X : < X
  IF rs_char_value-charcvaluedependency    = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt AND
     ( rs_char_value-charcfromnumericvalue = 0 OR
       rs_char_value-charcfromnumericvalue = if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charcfromnumericvalue ).
    rs_char_value-charcfromnumericvalue = rs_char_value-charctonumericvalue.
    rs_char_value-charctonumericvalue   = 0.
    rs_char_value-charcvaluedependency  = if_ngc_core_c=>gc_chr_charcvaluedependency-lt.
  ENDIF.

  " > X - <= Max : > X
  IF rs_char_value-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le AND
     rs_char_value-charctonumericvalue  = if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charctonumericvalue.
    rs_char_value-charctonumericvalue  = 0.
    rs_char_value-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt.
  ENDIF.

  IF rs_char_value-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.

    " >= Min - <= X : <= X
    IF rs_char_value-charcfromnumericvalue =  if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charcfromnumericvalue OR
       rs_char_value-charcfromnumericvalue =  0 .
      rs_char_value-charcfromnumericvalue = rs_char_value-charctonumericvalue.
      rs_char_value-charctonumericvalue  = 0.
      rs_char_value-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le.
    ENDIF.

    " >= X - <= Max : >= X
    IF rs_char_value-charctonumericvalue =  if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charctonumericvalue.
      rs_char_value-charctonumericvalue  = 0.
      rs_char_value-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge.
    ENDIF.

  ENDIF.

ENDMETHOD.