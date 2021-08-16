  METHOD has_authorization.

    AUTHORITY-CHECK OBJECT 'S_DEVELOP'
           ID 'DEVCLASS' DUMMY
           ID 'OBJTYPE' FIELD 'SUSC'
           ID 'OBJNAME' FIELD iv_class
           ID 'P_GROUP' DUMMY
           ID 'ACTVT'   FIELD iv_activity.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( iv_msgid = '01'
                                         iv_msgno = '467' ).
    ENDIF.

  ENDMETHOD.