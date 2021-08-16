  METHOD format_line.

    DATA:
      lv_chunk TYPE string,
      ls_rule  LIKE LINE OF mt_rules.

    FIELD-SYMBOLS <ls_match> TYPE ty_match.

    LOOP AT it_matches ASSIGNING <ls_match>.
      lv_chunk = substring( val = iv_line
                            off = <ls_match>-offset
                            len = <ls_match>-length ).

      CLEAR ls_rule. " Failed read equals no style
      READ TABLE mt_rules INTO ls_rule WITH KEY token = <ls_match>-token.

      lv_chunk = me->apply_style( iv_line  = lv_chunk
                                  iv_class = ls_rule-style ).

      rv_line = rv_line && lv_chunk.
    ENDLOOP.

  ENDMETHOD.