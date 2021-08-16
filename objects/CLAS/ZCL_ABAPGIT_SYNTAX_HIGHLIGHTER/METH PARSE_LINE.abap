  METHOD parse_line.

    DATA:
      lo_regex   TYPE REF TO cl_abap_regex,
      lo_matcher TYPE REF TO cl_abap_matcher,
      lt_result  TYPE match_result_tab,
      ls_match   TYPE ty_match.

    FIELD-SYMBOLS:
      <ls_regex>    LIKE LINE OF mt_rules,
      <ls_result>   TYPE match_result,
      <ls_submatch> LIKE LINE OF <ls_result>-submatches.


    " Process syntax-dependent regex table and find all matches
    LOOP AT mt_rules ASSIGNING <ls_regex> WHERE regex IS BOUND.
      lo_regex   = <ls_regex>-regex.
      lo_matcher = lo_regex->create_matcher( text = iv_line ).
      lt_result  = lo_matcher->find_all( ).

      " Save matches into custom table with predefined tokens
      LOOP AT lt_result ASSIGNING <ls_result>.
        CLEAR: ls_match.
        IF <ls_regex>-relevant_submatch = 0.
          ls_match-token  = <ls_regex>-token.
          ls_match-offset = <ls_result>-offset.
          ls_match-length = <ls_result>-length.
          APPEND ls_match TO rt_matches.
        ELSE.
          READ TABLE <ls_result>-submatches ASSIGNING <ls_submatch> INDEX <ls_regex>-relevant_submatch.
          "submatch might be empty if only discarted parts matched
          IF sy-subrc = 0 AND <ls_submatch>-offset >= 0 AND <ls_submatch>-length > 0.
            ls_match-token  = <ls_regex>-token.
            ls_match-offset = <ls_submatch>-offset.
            ls_match-length = <ls_submatch>-length.
            APPEND ls_match TO rt_matches.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.