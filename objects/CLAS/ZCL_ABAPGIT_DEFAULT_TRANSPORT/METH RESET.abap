  METHOD reset.

    DATA: ls_default_task TYPE e070use.

    IF mv_is_set_by_abapgit = abap_false.
      " if the default transport request task isn't set
      " by us there is nothing to do.
      RETURN.
    ENDIF.

    CLEAR mv_is_set_by_abapgit.

    ls_default_task = get( ).

    IF ls_default_task IS NOT INITIAL.

      clear( ls_default_task ).

    ENDIF.

    restore( ).

  ENDMETHOD.