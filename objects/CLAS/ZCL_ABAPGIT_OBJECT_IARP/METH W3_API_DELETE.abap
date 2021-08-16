  METHOD w3_api_delete.

    ii_resource->if_w3_api_object~delete(
      EXCEPTIONS
        object_not_empty      = 1
        object_not_changeable = 2
        object_invalid        = 3
        error_occured         = 4
        OTHERS                = 5 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |error from if_w3_api_object~delete. Subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.