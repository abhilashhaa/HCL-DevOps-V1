  METHOD on_double_click.

    DATA: lo_selections    TYPE REF TO cl_salv_selections.

    lo_selections = mo_select_list_popup->get_selections( ).

    IF lo_selections->get_selection_mode( ) = if_salv_c_selection_mode=>single.
      mo_select_list_popup->close_screen( ).
    ENDIF.

  ENDMETHOD.