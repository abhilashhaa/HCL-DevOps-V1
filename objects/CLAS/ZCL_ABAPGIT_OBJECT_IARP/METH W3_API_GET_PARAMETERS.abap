  METHOD w3_api_get_parameters.

    ii_resource->get_parameters(
      IMPORTING
        p_parameters     = rt_parameters
      EXCEPTIONS
        object_invalid   = 1
        resource_deleted = 2
        error_occured    = 3
        OTHERS           = 4 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |error from if_w3_api_resource~get_parameters. Subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.