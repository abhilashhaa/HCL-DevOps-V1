METHOD constructor.

  mv_appl_name = iv_appl_name.
  mv_language  = iv_language.
  mv_rework    = iv_rework.

  IF mv_rework = abap_true.
    mv_refbo_name = gv_refbo_name.
  ELSE.
    mv_refbo_name = gv_refbou_name.
  ENDIF.

ENDMETHOD.