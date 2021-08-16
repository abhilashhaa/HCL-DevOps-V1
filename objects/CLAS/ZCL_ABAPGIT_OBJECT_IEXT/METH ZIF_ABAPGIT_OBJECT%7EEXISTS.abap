  METHOD zif_abapgit_object~exists.

    CALL FUNCTION 'EXTTYPE_READ'
      EXPORTING
        pi_cimtyp = mv_extension
      EXCEPTIONS
        OTHERS    = 1.

    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.