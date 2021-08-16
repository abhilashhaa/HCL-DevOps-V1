  METHOD has_remote_source.
    rv_yes = boolc( lines( mt_remote ) > 0 ).
  ENDMETHOD.