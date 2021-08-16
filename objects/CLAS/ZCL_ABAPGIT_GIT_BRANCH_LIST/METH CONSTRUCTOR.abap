  METHOD constructor.

    parse_branch_list(
      EXPORTING
        iv_data        = iv_data
      IMPORTING
        et_list        = me->mt_branches
        ev_head_symref = me->mv_head_symref ).

  ENDMETHOD.