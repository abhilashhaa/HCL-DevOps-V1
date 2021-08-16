  METHOD zif_abapgit_html~add_icon.

    zif_abapgit_html~add( icon(
      iv_name    = iv_name
      iv_class   = iv_class
      iv_hint    = iv_hint
      iv_onclick = iv_onclick ) ).

  ENDMETHOD.