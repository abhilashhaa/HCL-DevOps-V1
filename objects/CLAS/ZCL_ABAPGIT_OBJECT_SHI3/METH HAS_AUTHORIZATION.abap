  METHOD has_authorization.

    AUTHORITY-CHECK OBJECT 'S_DEVELOP'
      ID 'DEVCLASS'  FIELD iv_devclass
      ID 'OBJTYPE'   FIELD 'MENU'
      ID 'OBJNAME'   FIELD iv_structure_id
      ID 'P_GROUP'   DUMMY
      ID 'ACTVT'     FIELD iv_activity.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( iv_msgid = 'S#'
                                         iv_msgno = '203' ).
    ENDIF.
  ENDMETHOD.