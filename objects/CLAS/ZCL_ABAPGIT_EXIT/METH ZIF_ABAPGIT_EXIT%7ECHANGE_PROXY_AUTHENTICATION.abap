  METHOD zif_abapgit_exit~change_proxy_authentication.

    TRY.
        gi_exit->change_proxy_authentication(
          EXPORTING
            iv_repo_url             = iv_repo_url
          CHANGING
            cv_proxy_authentication = cv_proxy_authentication ).
      CATCH cx_sy_ref_is_initial cx_sy_dyn_call_illegal_method ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.