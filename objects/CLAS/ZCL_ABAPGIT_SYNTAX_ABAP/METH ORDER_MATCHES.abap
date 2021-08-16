  METHOD order_matches.

    DATA:
      lv_index      TYPE sy-tabix,
      lv_line_len   TYPE i,
      lv_prev_token TYPE c.

    FIELD-SYMBOLS:
      <ls_prev>  TYPE ty_match,
      <ls_match> TYPE ty_match.

    SORT ct_matches BY offset.

    lv_line_len = strlen( iv_line ).

    LOOP AT ct_matches ASSIGNING <ls_match>.
      lv_index = sy-tabix.

      " Delete matches after open text match
      IF lv_prev_token = c_token-text AND <ls_match>-token <> c_token-text.
        DELETE ct_matches INDEX lv_index.
        CONTINUE.
      ENDIF.

      CASE <ls_match>-token.
        WHEN c_token-keyword.
          IF <ls_match>-offset > 0
              AND substring( val = iv_line
                             off = ( <ls_match>-offset - 1 )
                             len = 1 ) CA '-<'.
            " Delete match if keyword is part of structure or field symbol
            DELETE ct_matches INDEX lv_index.
            CONTINUE.
          ENDIF.

        WHEN c_token-comment.
          <ls_match>-length = lv_line_len - <ls_match>-offset.
          DELETE ct_matches FROM lv_index + 1.
          CONTINUE.

        WHEN c_token-text.
          <ls_match>-text_tag = substring( val = iv_line
                                        off = <ls_match>-offset
                                        len = <ls_match>-length ).
          IF lv_prev_token = c_token-text.
            IF <ls_match>-text_tag = <ls_prev>-text_tag.
              <ls_prev>-length = <ls_match>-offset + <ls_match>-length - <ls_prev>-offset.
              CLEAR lv_prev_token.
            ELSEIF <ls_prev>-text_tag = '}' AND <ls_match>-text_tag = '{'.
              <ls_prev>-length = <ls_match>-offset - <ls_prev>-offset - 1.  " Shift } out of scope
              <ls_prev>-offset = <ls_prev>-offset + 1.                   " Shift { out of scope
              CLEAR lv_prev_token.
            ELSEIF <ls_match>-text_tag = '{'.
              <ls_prev>-length = <ls_match>-offset - <ls_prev>-offset.
              CLEAR lv_prev_token.
            ELSEIF <ls_prev>-text_tag = '}'.
              <ls_prev>-length = <ls_match>-offset - <ls_prev>-offset.
              <ls_prev>-offset = <ls_prev>-offset + 1.                   " Shift } out of scope
              CLEAR lv_prev_token.
            ENDIF.
            DELETE ct_matches INDEX lv_index.
            CONTINUE.
          ENDIF.

      ENDCASE.

      lv_prev_token = <ls_match>-token.
      ASSIGN <ls_match> TO <ls_prev>.
    ENDLOOP.

  ENDMETHOD.