  METHOD extend_matches.

    DATA: lv_line_len TYPE i,
          lv_last_pos TYPE i VALUE 0,
          lv_length   TYPE i,
          ls_match    TYPE ty_match.

    FIELD-SYMBOLS <ls_match> TYPE ty_match.

    lv_line_len = strlen( iv_line ).

    SORT ct_matches BY offset.

    " Add entries refering to parts of text that should not be formatted
    LOOP AT ct_matches ASSIGNING <ls_match>.
      IF <ls_match>-offset > lv_last_pos.
        lv_length = <ls_match>-offset - lv_last_pos.
        ls_match-token  = c_token_none.
        ls_match-offset = lv_last_pos.
        ls_match-length = lv_length.
        INSERT ls_match INTO ct_matches INDEX sy-tabix.
      ENDIF.
      lv_last_pos = <ls_match>-offset + <ls_match>-length.
    ENDLOOP.

    " Add remainder of the string
    IF lv_line_len > lv_last_pos.
      lv_length = lv_line_len - lv_last_pos.
      ls_match-token  = c_token_none.
      ls_match-offset = lv_last_pos.
      ls_match-length = lv_length.
      APPEND ls_match TO ct_matches.
    ENDIF.

  ENDMETHOD.