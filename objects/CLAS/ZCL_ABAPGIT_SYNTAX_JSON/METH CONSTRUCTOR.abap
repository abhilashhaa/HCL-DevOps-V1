  METHOD constructor.

    super->constructor( ).

    " Initialize instances of regular expression

    add_rule( iv_regex = c_regex-keyword
              iv_token = c_token-keyword
              iv_style = c_css-keyword ).

    add_rule( iv_regex = c_regex-text
              iv_token = c_token-text
              iv_style = c_css-text ).

  ENDMETHOD.