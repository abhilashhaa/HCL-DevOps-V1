  METHOD is_empty.
    rv_yes = boolc( lines( mt_entries ) = 0 ).
  ENDMETHOD.