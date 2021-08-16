  METHOD cache_html.

    rv_url = zif_abapgit_gui_services~cache_asset(
      iv_text    = iv_text
      iv_type    = 'text'
      iv_subtype = 'html' ).

  ENDMETHOD.