  METHOD has_pulls.

    IF mi_enum_provider IS NOT BOUND.
      RETURN. " false
    ENDIF.

    IF get_pulls( ) IS NOT INITIAL.
      rv_yes = abap_true.
    ENDIF.

  ENDMETHOD.