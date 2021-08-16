  METHOD zif_abapgit_object~exists.

    CALL FUNCTION 'IDOCTYPE_READ'
      EXPORTING
        pi_idoctyp       = mv_idoctyp
      EXCEPTIONS
        object_not_found = 1
        db_error         = 2
        no_authority     = 3
        OTHERS           = 4.

    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.