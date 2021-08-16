  METHOD corr_insert.

    " You are reminded that SUDM - Data Model has no part objects e.g. no LIMU
    " Therefore global lock is always appropriate

    " You are reminded that the master language (in TADIR) is taken from MV_LANGUAGE.

    CALL FUNCTION 'RS_CORR_INSERT'
      EXPORTING
        object              = me->ms_object_type
        object_class        = me->c_transport_object_class
        devclass            = iv_package
        master_language     = mv_language
        mode                = 'INSERT'
        global_lock         = abap_true
        suppress_dialog     = abap_true
      EXCEPTIONS
        cancelled           = 1
        permission_failure  = 2
        unknown_objectclass = 3
        OTHERS              = 4.
    IF sy-subrc = 1.
      zcx_abapgit_exception=>raise( 'Cancelled' ).
    ELSEIF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from RS_CORR_INSERT' ).
    ENDIF.
  ENDMETHOD.