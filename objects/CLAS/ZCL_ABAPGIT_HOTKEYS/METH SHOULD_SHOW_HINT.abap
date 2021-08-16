  METHOD should_show_hint.
    IF gv_hint_was_shown = abap_false.
      rv_yes = abap_true.
      gv_hint_was_shown = abap_true.
    ENDIF.
  ENDMETHOD.