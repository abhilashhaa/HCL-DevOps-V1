  METHOD get_name.
    rv_name = super->get_name( ).

    IF rv_name IS INITIAL.
      rv_name = ms_data-url.
    ENDIF.
  ENDMETHOD.