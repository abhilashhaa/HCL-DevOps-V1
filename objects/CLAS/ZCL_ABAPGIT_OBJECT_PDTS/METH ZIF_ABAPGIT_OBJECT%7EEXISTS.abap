  METHOD zif_abapgit_object~exists.

    CALL FUNCTION 'RH_READ_OBJECT'
      EXPORTING
        plvar     = '01'
        otype     = c_object_type_task
        objid     = mv_objid
        istat     = '1'
        begda     = sy-datum
        endda     = '99991231'
        ointerval = 'X'
        read_db   = 'X'
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.

    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.