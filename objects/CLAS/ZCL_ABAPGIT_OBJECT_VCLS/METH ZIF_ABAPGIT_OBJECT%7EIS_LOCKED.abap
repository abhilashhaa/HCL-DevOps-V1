  METHOD zif_abapgit_object~is_locked.

    DATA:
      lv_argument       TYPE seqg3-garg,
      lv_argument_langu TYPE seqg3-garg.

    lv_argument       = me->ms_item-obj_name.
    lv_argument_langu = |@{ me->ms_item-obj_name }|.

    "Check all relevant maintein tabeles for view clusters
    IF check_lock( iv_tabname = 'VCLDIR'
                   iv_argument = lv_argument ) = abap_true
        OR check_lock( iv_tabname = 'VCLDIRT'
                       iv_argument = lv_argument_langu ) = abap_true
        OR check_lock( iv_tabname = 'VCLSTRUC'
                       iv_argument = lv_argument )       = abap_true
        OR check_lock( iv_tabname = 'VCLSTRUCT'
                       iv_argument = lv_argument_langu ) = abap_true
        OR check_lock( iv_tabname = 'VCLMF'
                       iv_argument = lv_argument )       = abap_true.

      rv_is_locked = abap_true.
    ENDIF.

  ENDMETHOD.