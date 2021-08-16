  METHOD w3_api_load.

    cl_w3_api_resource=>if_w3_api_resource~load(
      EXPORTING
        p_resource_name     = ms_name
      IMPORTING
        p_resource          = ri_resource
      EXCEPTIONS
        object_not_existing = 1
        permission_failure  = 2
        error_occured       = 3
        OTHERS              = 4 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |error from w3api_resource~load. Subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.