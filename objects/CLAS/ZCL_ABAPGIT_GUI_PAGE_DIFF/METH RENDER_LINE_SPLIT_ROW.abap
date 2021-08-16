  METHOD render_line_split_row.

    IF iv_fstate = c_fstate-remote. " Remote file leading changes
      ii_html->add( iv_old ). " local
      ii_html->add( iv_new ). " remote
    ELSE.             " Local leading changes or both were modified
      ii_html->add( iv_new ). " local
      ii_html->add( iv_old ). " remote
    ENDIF.

  ENDMETHOD.