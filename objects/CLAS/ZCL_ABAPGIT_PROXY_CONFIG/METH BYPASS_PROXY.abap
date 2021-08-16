  METHOD bypass_proxy.

    DATA lt_proxy_bypass TYPE zif_abapgit_definitions=>ty_range_proxy_bypass_url.

    lt_proxy_bypass = mo_settings->get_proxy_bypass( ).

    IF lt_proxy_bypass IS NOT INITIAL
    AND iv_repo_url IN lt_proxy_bypass.
      rv_bypass_proxy = abap_true.
    ENDIF.

  ENDMETHOD.