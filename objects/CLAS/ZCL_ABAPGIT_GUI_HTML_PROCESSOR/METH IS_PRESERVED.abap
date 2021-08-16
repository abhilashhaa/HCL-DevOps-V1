  METHOD is_preserved.
    READ TABLE mt_preserve_css TRANSPORTING NO FIELDS WITH KEY table_line = iv_css_url.
    rv_yes = boolc( sy-subrc = 0 ).
  ENDMETHOD.