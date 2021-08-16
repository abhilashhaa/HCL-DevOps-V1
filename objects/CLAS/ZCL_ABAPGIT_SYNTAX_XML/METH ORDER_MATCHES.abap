  METHOD order_matches.

    DATA:
      lv_match      TYPE string,
      lv_line_len   TYPE i,
      lv_cmmt_end   TYPE i,
      lv_index      TYPE sy-tabix,
      lv_prev_token TYPE c,
      lv_state      TYPE c VALUE 'O'. " O - for open tag; C - for closed tag;

    FIELD-SYMBOLS:
      <ls_prev>  TYPE ty_match,
      <ls_match> TYPE ty_match.

    SORT ct_matches BY offset.

    lv_line_len = strlen( iv_line ).

    " Check if this is part of multi-line comment and mark it accordingly
    IF gv_comment = abap_true.
      READ TABLE ct_matches WITH KEY token = c_token-comment TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        CLEAR ct_matches.
        APPEND INITIAL LINE TO ct_matches ASSIGNING <ls_match>.
        <ls_match>-token = c_token-comment.
        <ls_match>-offset = 0.
        <ls_match>-length = lv_line_len.
        RETURN.
      ENDIF.
    ENDIF.

    LOOP AT ct_matches ASSIGNING <ls_match>.
      lv_index = sy-tabix.

      lv_match = substring( val = iv_line
                            off = <ls_match>-offset
                            len = <ls_match>-length ).

      CASE <ls_match>-token.
        WHEN c_token-xml_tag.
          <ls_match>-text_tag = lv_match.

          " No other matches between two tags
          IF <ls_match>-text_tag = '>' AND lv_prev_token = c_token-xml_tag.
            lv_state = 'C'.
            <ls_prev>-length = <ls_match>-offset - <ls_prev>-offset + <ls_match>-length.
            DELETE ct_matches INDEX lv_index.
            CONTINUE.

            " Adjust length and offset of closing tag
          ELSEIF <ls_match>-text_tag = '>' AND lv_prev_token <> c_token-xml_tag.
            lv_state = 'C'.
            IF <ls_prev> IS ASSIGNED.
              <ls_match>-length = <ls_match>-offset - <ls_prev>-offset - <ls_prev>-length + <ls_match>-length.
              <ls_match>-offset = <ls_prev>-offset + <ls_prev>-length.
            ENDIF.
          ELSE.
            lv_state = 'O'.
          ENDIF.

        WHEN c_token-comment.
          IF lv_match = '<!--'.
            DELETE ct_matches WHERE offset > <ls_match>-offset.
            DELETE ct_matches WHERE offset = <ls_match>-offset AND token = c_token-xml_tag.
            <ls_match>-length = lv_line_len - <ls_match>-offset.
            gv_comment = abap_true.
          ELSEIF lv_match = '-->'.
            DELETE ct_matches WHERE offset < <ls_match>-offset.
            <ls_match>-length = <ls_match>-offset + 3.
            <ls_match>-offset = 0.
            gv_comment = abap_false.
          ELSE.
            lv_cmmt_end = <ls_match>-offset + <ls_match>-length.
            DELETE ct_matches WHERE offset > <ls_match>-offset AND offset <= lv_cmmt_end.
            DELETE ct_matches WHERE offset = <ls_match>-offset AND token = c_token-xml_tag.
          ENDIF.

        WHEN OTHERS.
          IF lv_prev_token = c_token-xml_tag.
            <ls_prev>-length = <ls_match>-offset - <ls_prev>-offset. " Extend length of the opening tag
          ENDIF.

          IF lv_state = 'C'.  " Delete all matches between tags
            DELETE ct_matches INDEX lv_index.
            CONTINUE.
          ENDIF.

      ENDCASE.

      lv_prev_token = <ls_match>-token.
      ASSIGN <ls_match> TO <ls_prev>.
    ENDLOOP.

    "if the last XML tag is not closed, extend it to the end of the tag
    IF lv_prev_token = c_token-xml_tag
        AND <ls_prev> IS ASSIGNED
        AND <ls_prev>-length  = 1
        AND <ls_prev>-text_tag = '<'.

      FIND REGEX '<\s*[^\s]*' IN iv_line+<ls_prev>-offset MATCH LENGTH <ls_prev>-length.
      IF sy-subrc <> 0.
        <ls_prev>-length = 1.
      ENDIF.

    ENDIF.

  ENDMETHOD.