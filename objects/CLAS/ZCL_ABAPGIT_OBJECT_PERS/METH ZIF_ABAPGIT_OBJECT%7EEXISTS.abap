  METHOD zif_abapgit_object~exists.

    cl_pers_reg=>exists(
      EXPORTING
        p_pers_key              = mv_pers_key
      EXCEPTIONS
        pers_key_does_not_exist = 1
        OTHERS                  = 2 ).

    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.