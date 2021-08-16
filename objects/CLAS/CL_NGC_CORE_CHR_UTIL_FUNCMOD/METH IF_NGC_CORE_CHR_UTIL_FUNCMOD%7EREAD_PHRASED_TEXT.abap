  METHOD if_ngc_core_chr_util_funcmod~read_phrased_text.

    DATA(ls_addinf) = VALUE rcgaddinf( valdat = sy-datum ).

    CALL FUNCTION 'C14X_PHRASE_TEXT_READ'
      EXPORTING
        i_addinf         = ls_addinf
        i_value          = iv_phrase_key
      IMPORTING
        e_phrcode        = ev_phrase_code
      EXCEPTIONS
        phrase_not_found = 1.

    IF sy-subrc <> 0.
      RAISE phrase_not_found.
    ENDIF.

  ENDMETHOD.