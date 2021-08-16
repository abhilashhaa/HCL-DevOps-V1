  METHOD get_proxy_port.

    IF bypass_proxy( iv_repo_url ) = abap_false.
      rv_port = mo_settings->get_proxy_port( ).
    ENDIF.

    mi_exit->change_proxy_port(
      EXPORTING
        iv_repo_url  = iv_repo_url
      CHANGING
        cv_proxy_port = rv_port ).

    CONDENSE rv_port.

  ENDMETHOD.