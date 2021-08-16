  METHOD supports_url.
    rv_supported = mo_url_regex->create_matcher( text = iv_url )->match( ).
  ENDMETHOD.