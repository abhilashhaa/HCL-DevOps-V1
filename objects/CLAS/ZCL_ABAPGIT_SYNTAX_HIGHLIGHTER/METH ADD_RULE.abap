  METHOD add_rule.

    DATA ls_rule LIKE LINE OF mt_rules.

    IF NOT iv_regex IS INITIAL.
      CREATE OBJECT ls_rule-regex
        EXPORTING
          pattern     = iv_regex
          ignore_case = abap_true.
    ENDIF.

    ls_rule-token         = iv_token.
    ls_rule-style         = iv_style.
    ls_rule-relevant_submatch = iv_submatch.
    APPEND ls_rule TO mt_rules.

  ENDMETHOD.