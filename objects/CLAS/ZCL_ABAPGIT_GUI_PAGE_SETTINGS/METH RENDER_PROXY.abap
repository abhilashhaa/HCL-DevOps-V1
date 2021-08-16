  METHOD render_proxy.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( |<h2>Proxy</h2>| ).
    ri_html->add( |<label for="proxy_url">Proxy URL</label>| ).
    ri_html->add( |<br>| ).
    ri_html->add( `<input name="proxy_url" type="text" size="50" value="` &&
      mo_settings->get_proxy_url( ) && `">` ).
    ri_html->add( |<br>| ).
    ri_html->add( |<label for="proxy_port">Proxy Port</label>| ).
    ri_html->add( |<br>| ).
    ri_html->add( `<input name="proxy_port" type="text" size="5" value="` &&
      mo_settings->get_proxy_port( ) && `">` ).
    ri_html->add( |<br>| ).
    ri_html->add( |<label for="proxy_auth">Proxy Authentication</label>| ).
    IF mo_settings->get_proxy_authentication( ) = abap_true.
      ri_html->add( `<input name="proxy_auth" type="checkbox" checked>` ).
    ELSE.
      ri_html->add( `<input name="proxy_auth" type="checkbox">` ).
    ENDIF.
    ri_html->add( |<br>| ).
    ri_html->add( |<br>| ).
    ri_html->add( |<label for="proxy_bypass">Bypass Proxy Settings for These Hosts & Domains</label>| ).
    ri_html->add( |<br>| ).
    ri_html->add( |<button type="button" name="proxy_bypass" class="grey-set"|
                & |onclick="location.href='sapevent:{ c_action-change_proxy_bypass }';">Maintain</button>| ).
    ri_html->add( |<br>| ).

    ri_html->add( |<br>| ).

  ENDMETHOD.