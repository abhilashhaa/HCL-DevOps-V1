  METHOD constructor.

    super->constructor( ).

    " Initialize instances of regular expression

    add_rule( iv_regex = c_regex-keyword
              iv_token = c_token-keyword
              iv_style = c_css-keyword ).

    add_rule( iv_regex = c_regex-comment
              iv_token = c_token-comment
              iv_style = c_css-comment ).

    add_rule( iv_regex = c_regex-text
              iv_token = c_token-text
              iv_style = c_css-text ).

    add_rule( iv_regex = c_regex-selectors
              iv_token = c_token-selectors
              iv_style = c_css-selectors ).

    add_rule( iv_regex = c_regex-units
              iv_token = c_token-units
              iv_style = c_css-units ).

    " Styles for keywords
    add_rule( iv_regex = ''
              iv_token = c_token-html
              iv_style = c_css-html ).

    add_rule( iv_regex = ''
              iv_token = c_token-properties
              iv_style = c_css-properties ).

    add_rule( iv_regex = ''
              iv_token = c_token-values
              iv_style = c_css-values ).

    add_rule( iv_regex = ''
              iv_token = c_token-functions
              iv_style = c_css-functions ).

    add_rule( iv_regex = ''
              iv_token = c_token-colors
              iv_style = c_css-colors ).

    add_rule( iv_regex = ''
              iv_token = c_token-extensions
              iv_style = c_css-extensions ).

    add_rule( iv_regex = ''
              iv_token = c_token-at_rules
              iv_style = c_css-at_rules ).

  ENDMETHOD.