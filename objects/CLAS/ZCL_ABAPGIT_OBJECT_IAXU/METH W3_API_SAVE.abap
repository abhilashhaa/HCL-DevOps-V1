  METHOD w3_api_save.

    CALL METHOD io_xml_api->('IF_W3_API_OBJECT~SAVE')
      EXCEPTIONS
        object_invalid        = 1
        object_not_changeable = 2
        action_cancelled      = 3
        permission_failure    = 4
        not_changed           = 5
        data_invalid          = 6
        error_occured         = 7
        OTHERS                = 8.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from w3_api_xml3~save subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.