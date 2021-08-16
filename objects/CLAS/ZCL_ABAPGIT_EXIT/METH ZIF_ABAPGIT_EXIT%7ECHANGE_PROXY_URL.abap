  METHOD zif_abapgit_exit~change_proxy_url.

    TRY.
        gi_exit->change_proxy_url(
          EXPORTING
            iv_repo_url  = iv_repo_url
          CHANGING
            cv_proxy_url = cv_proxy_url ).
      CATCH cx_sy_ref_is_initial cx_sy_dyn_call_illegal_method ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.