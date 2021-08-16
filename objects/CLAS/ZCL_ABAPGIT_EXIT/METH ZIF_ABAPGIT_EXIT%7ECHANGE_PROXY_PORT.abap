  METHOD zif_abapgit_exit~change_proxy_port.

    TRY.
        gi_exit->change_proxy_port(
          EXPORTING
            iv_repo_url   = iv_repo_url
          CHANGING
            cv_proxy_port = cv_proxy_port ).
      CATCH cx_sy_ref_is_initial cx_sy_dyn_call_illegal_method ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.