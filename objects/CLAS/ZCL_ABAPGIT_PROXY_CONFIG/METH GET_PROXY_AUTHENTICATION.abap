  METHOD get_proxy_authentication.

    IF bypass_proxy( iv_repo_url ) = abap_false.
      rv_auth = mo_settings->get_proxy_authentication( ).
    ENDIF.

    mi_exit->change_proxy_authentication(
      EXPORTING
        iv_repo_url            = iv_repo_url
      CHANGING
        cv_proxy_authentication = rv_auth ).

  ENDMETHOD.