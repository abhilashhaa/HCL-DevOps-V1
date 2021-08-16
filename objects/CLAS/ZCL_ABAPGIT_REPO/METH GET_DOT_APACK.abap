  METHOD get_dot_apack.
    IF mo_apack_reader IS NOT BOUND.
      mo_apack_reader = zcl_abapgit_apack_reader=>create_instance( ms_data-package ).
    ENDIF.

    ro_dot_apack = mo_apack_reader.

  ENDMETHOD.