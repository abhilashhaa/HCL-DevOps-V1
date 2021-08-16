  METHOD call_page.

    DATA: ls_stack TYPE ty_page_stack.

    IF iv_replacing = abap_false AND NOT mi_cur_page IS INITIAL.
      ls_stack-page     = mi_cur_page.
      ls_stack-bookmark = iv_with_bookmark.
      APPEND ls_stack TO mt_stack.
    ENDIF.

    mi_cur_page = ii_page.
    render( ).

  ENDMETHOD.