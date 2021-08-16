  METHOD w3_api_create_new.

    cl_w3_api_resource=>if_w3_api_resource~create_new(
      EXPORTING
        p_resource_data         = is_attributes
      IMPORTING
        p_resource              = ri_resource
      EXCEPTIONS
        object_already_existing = 1
        object_just_created     = 2
        not_authorized          = 3
        undefined_name          = 4
        author_not_existing     = 5
        action_cancelled        = 6
        error_occured           = 7
        OTHERS                  = 8 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |error from if_w3_api_resource~create_new. Subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.