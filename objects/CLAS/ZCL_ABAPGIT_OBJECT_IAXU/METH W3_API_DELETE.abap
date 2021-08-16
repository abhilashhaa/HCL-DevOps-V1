  METHOD w3_api_delete.

    CALL METHOD io_xml_api->('IF_W3_API_OBJECT~DELETE')
      EXCEPTIONS
        object_not_empty      = 1
        object_not_changeable = 2
        object_invalid        = 3
        error_occured         = 4
        OTHERS                = 5.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from w3_api_xml3~delete subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.