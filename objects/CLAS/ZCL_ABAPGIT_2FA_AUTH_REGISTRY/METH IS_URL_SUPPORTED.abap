  METHOD is_url_supported.
    TRY.
        get_authenticator_for_url( iv_url ).
        rv_supported = abap_true.
      CATCH zcx_abapgit_2fa_unsupported ##NO_HANDLER.
    ENDTRY.
  ENDMETHOD.