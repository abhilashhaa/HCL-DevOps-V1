  METHOD zif_abapgit_object~delete.

    CALL FUNCTION 'IDOCTYPE_DELETE'
      EXPORTING
        pi_idoctyp          = mv_idoctyp
      EXCEPTIONS
        object_not_found    = 1
        lock_error          = 2
        action_not_possible = 3
        transport_error     = 4
        db_error            = 5
        no_authority        = 6
        OTHERS              = 7.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.