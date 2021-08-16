  METHOD w3_api_set_parameters.

    ii_service->set_parameters(
      EXPORTING
        p_parameters          = it_parameters
      EXCEPTIONS
        object_not_changeable = 1
        object_deleted        = 2
        object_invalid        = 3
        authorize_failure     = 4
        invalid_parameter     = 5
        error_occured         = 6
        OTHERS                = 7 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |error from if_w3_api_service~set_parameters. Subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.