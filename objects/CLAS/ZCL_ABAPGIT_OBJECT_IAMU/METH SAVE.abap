  METHOD save.

    cl_w3_api_mime=>if_w3_api_mime~create_new(
      EXPORTING
        p_mime_data             = is_internet_appl_comp_binary-attributes
        p_mime_content          = is_internet_appl_comp_binary-source
        p_datalength            = is_internet_appl_comp_binary-length
      IMPORTING
        p_mime                  = mi_mime_api
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
      zcx_abapgit_exception=>raise( |Error from if_w3_api_mime~create_new| ).
    ENDIF.

    mi_mime_api->if_w3_api_object~save(
      EXCEPTIONS
        object_invalid        = 1
        object_not_changeable = 2
        action_cancelled      = 3
        permission_failure    = 4
        not_changed           = 5
        data_invalid          = 6
        error_occured         = 7
        OTHERS                = 8 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from if_w3_api_mime~save| ).
    ENDIF.

    release_lock( ).

  ENDMETHOD.