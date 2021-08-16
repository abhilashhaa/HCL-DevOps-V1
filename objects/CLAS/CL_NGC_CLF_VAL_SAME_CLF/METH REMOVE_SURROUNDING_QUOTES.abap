  METHOD remove_surrounding_quotes.
    CONSTANTS:
      c_quote TYPE c LENGTH 1 VALUE ''''.

    rv_atwrt = iv_atwrt.
    CONDENSE rv_atwrt.
    DATA(lv_strlen) = strlen( rv_atwrt ) - 1.

    IF rv_atwrt(1) = c_quote AND rv_atwrt+lv_strlen(1) = c_quote.
      SUBTRACT 1 FROM lv_strlen.
      rv_atwrt = rv_atwrt+1(lv_strlen).
      CONDENSE rv_atwrt.
    ENDIF.
  ENDMETHOD.