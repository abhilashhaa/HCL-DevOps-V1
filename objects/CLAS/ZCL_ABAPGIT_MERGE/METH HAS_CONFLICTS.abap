  METHOD has_conflicts.

    rv_conflicts_exists = boolc( lines( mt_conflicts ) > 0 ).

  ENDMETHOD.