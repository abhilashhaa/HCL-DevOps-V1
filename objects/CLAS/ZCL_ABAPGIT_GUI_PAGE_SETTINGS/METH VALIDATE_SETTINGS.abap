  METHOD validate_settings.

    IF ( mo_settings->get_proxy_url( ) IS NOT INITIAL AND mo_settings->get_proxy_port( ) IS INITIAL ) OR
                 ( mo_settings->get_proxy_url( ) IS INITIAL AND mo_settings->get_proxy_port( ) IS NOT INITIAL ).
      MESSAGE 'If specifying proxy, specify both URL and port' TYPE 'W'.
    ENDIF.

  ENDMETHOD.