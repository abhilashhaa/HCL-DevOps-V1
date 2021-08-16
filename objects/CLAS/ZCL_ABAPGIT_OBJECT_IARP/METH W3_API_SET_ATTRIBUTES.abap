  METHOD w3_api_set_attributes.

    ii_resource->set_attributes(
      EXPORTING
        p_attributes          = is_attributes
      EXCEPTIONS
        object_not_changeable = 1
        object_deleted        = 2
        object_invalid        = 3
        author_not_existing   = 4
        authorize_failure     = 5
        error_occured         = 6
        OTHERS                = 7 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |error from if_w3_api_resource~set_attributes. Subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.