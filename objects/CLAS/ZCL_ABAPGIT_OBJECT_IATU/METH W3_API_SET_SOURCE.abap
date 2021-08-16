  METHOD w3_api_set_source.

    ii_template->set_source(
      EXPORTING
        p_source              = it_source
      EXCEPTIONS
        object_not_changeable = 1
        object_deleted        = 2
        object_invalid        = 3
        authorize_failure     = 4
        invalid_parameter     = 5
        error_occured         = 6
        OTHERS                = 7 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from w3_api_template~set_source subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.