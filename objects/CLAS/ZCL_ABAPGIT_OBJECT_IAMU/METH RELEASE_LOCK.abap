  METHOD release_lock.

    " As a side effect this method removes also existing locks
    mi_mime_api->if_w3_api_object~set_changeable(
      EXPORTING
        p_changeable                 = abap_false
      EXCEPTIONS
        action_cancelled             = 1
        object_locked_by_other_user  = 2
        permission_failure           = 3
        object_already_changeable    = 4
        object_already_unlocked      = 5
        object_just_created          = 6
        object_deleted               = 7
        object_modified              = 8
        object_not_existing          = 9
        object_invalid               = 10
        error_occured                = 11
        OTHERS                       = 12 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from if_w3_api_mime~set_changeable| ).
    ENDIF.

  ENDMETHOD.