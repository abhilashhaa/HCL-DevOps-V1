  METHOD go_page.

    IF iv_clear_stack = abap_true.
      CLEAR mt_stack.
    ENDIF.

    mi_cur_page = ii_page.
    render( ).

  ENDMETHOD.