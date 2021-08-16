  METHOD go_home.

    DATA: ls_stack LIKE LINE OF mt_stack,
          lv_mode  TYPE tabname.

    IF mi_router IS BOUND.
      CLEAR: mt_stack, mt_event_handlers.
      APPEND mi_router TO mt_event_handlers.
      " on_event doesn't accept strings directly
      GET PARAMETER ID 'DBT' FIELD lv_mode.
      CASE lv_mode.
        WHEN 'ZABAPGIT'.
          on_event( action = |{ c_action-go_db }| ).
        WHEN OTHERS.
          on_event( action = |{ c_action-go_home }| ).
      ENDCASE.
    ELSE.
      IF lines( mt_stack ) > 0.
        READ TABLE mt_stack INTO ls_stack INDEX 1.
        mi_cur_page = ls_stack-page.
      ENDIF.
      render( ).
    ENDIF.

  ENDMETHOD.