  METHOD w3_api_set_changeable.

    CALL METHOD io_xml_api->('IF_W3_API_OBJECT~SET_CHANGEABLE')
      EXPORTING
        p_changeable                = iv_changeable
      EXCEPTIONS
        action_cancelled            = 1
        object_locked_by_other_user = 2
        permission_failure          = 3
        object_already_changeable   = 4
        object_already_unlocked     = 5
        object_just_created         = 6
        object_deleted              = 7
        object_modified             = 8
        object_not_existing         = 9
        object_invalid              = 10
        error_occured               = 11
        OTHERS                      = 12.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from w3_api_xml3~set_changeable subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.