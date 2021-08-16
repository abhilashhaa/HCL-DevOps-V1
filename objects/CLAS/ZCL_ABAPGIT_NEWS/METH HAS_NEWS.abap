  METHOD has_news.
    rv_boolean = boolc( lines( mt_log ) > 0 ).
  ENDMETHOD.