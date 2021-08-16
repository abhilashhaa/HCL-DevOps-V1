  METHOD is_allowed.

    DATA: li_auth TYPE REF TO zif_abapgit_auth.

    TRY.
        CREATE OBJECT li_auth TYPE ('ZCL_ABAPGIT_AUTH_EXIT').
        rv_allowed = li_auth->is_allowed( iv_authorization = iv_authorization
                                          iv_param         = iv_param ).
      CATCH cx_sy_create_object_error.
        rv_allowed = abap_true.
    ENDTRY.

  ENDMETHOD.