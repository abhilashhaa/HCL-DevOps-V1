  METHOD get_proxy_url.

    IF bypass_proxy( iv_repo_url ) = abap_false.
      rv_proxy_url = mo_settings->get_proxy_url( ).
    ENDIF.

    mi_exit->change_proxy_url(
      EXPORTING
        iv_repo_url = iv_repo_url
      CHANGING
        cv_proxy_url = rv_proxy_url ).

  ENDMETHOD.