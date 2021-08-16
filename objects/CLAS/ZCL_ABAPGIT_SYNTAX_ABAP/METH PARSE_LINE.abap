  METHOD parse_line. "REDEFINITION

    DATA lv_index TYPE i.

    FIELD-SYMBOLS <ls_match> LIKE LINE OF rt_matches.

    rt_matches = super->parse_line( iv_line ).

    " Remove non-keywords
    LOOP AT rt_matches ASSIGNING <ls_match> WHERE token = c_token-keyword.
      lv_index = sy-tabix.
      IF abap_false = is_keyword( substring( val = iv_line
                                             off = <ls_match>-offset
                                             len = <ls_match>-length ) ).
        DELETE rt_matches INDEX lv_index.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.