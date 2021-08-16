  METHOD w3_api_load.

    cl_w3_api_service=>if_w3_api_service~load(
      EXPORTING
        p_service_name     = mv_name
      IMPORTING
        p_service          = ri_service
      EXCEPTIONS
        object_not_existing = 1
        permission_failure  = 2
        error_occured       = 3
        OTHERS              = 4 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from w3api_service~load' ).
    ENDIF.

  ENDMETHOD.