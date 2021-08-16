  METHOD zif_abapgit_object~exists.

    DATA: ls_tdct TYPE tdct.

    ls_tdct = _read_tdct( ).

    rv_bool = boolc( ls_tdct IS NOT INITIAL ).

  ENDMETHOD.