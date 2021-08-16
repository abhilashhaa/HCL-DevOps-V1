  METHOD check_overlap.

    IF ( iv_valid_from1 > iv_valid_to1 ) OR ( iv_valid_from2 > iv_valid_to2 ).
      RAISE EXCEPTION TYPE cx_ngc_core_cls_hier_maint. " No valid interval
    ENDIF.

    IF iv_valid_from1 > iv_valid_to2 OR iv_valid_to1 < iv_valid_from2.
      rv_overlap = abap_false.
      RETURN.
    ENDIF.
    rv_overlap = abap_true.

  ENDMETHOD.