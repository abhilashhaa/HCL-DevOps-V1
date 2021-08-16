  METHOD constructor.

    super->constructor( ).

    " Initialize instances of regular expressions

    add_rule( iv_regex    = c_regex-xml_tag
              iv_token    = c_token-xml_tag
              iv_style    = c_css-xml_tag
              iv_submatch = 1 ).

    add_rule( iv_regex = c_regex-attr
              iv_token = c_token-attr
              iv_style = c_css-attr ).

    add_rule( iv_regex = c_regex-attr_val
              iv_token = c_token-attr_val
              iv_style = c_css-attr_val ).

    add_rule( iv_regex = c_regex-comment
              iv_token = c_token-comment
              iv_style = c_css-comment ).

  ENDMETHOD.