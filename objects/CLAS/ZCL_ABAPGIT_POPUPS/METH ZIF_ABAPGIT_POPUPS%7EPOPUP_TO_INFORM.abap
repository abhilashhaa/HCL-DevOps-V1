  METHOD zif_abapgit_popups~popup_to_inform.

    DATA: lv_line1 TYPE c LENGTH 70,
          lv_line2 TYPE c LENGTH 70.

    lv_line1 = iv_text_message.
    IF strlen( iv_text_message ) > 70.
      lv_line2 = iv_text_message+70.
    ENDIF.

    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = iv_titlebar
        txt1  = lv_line1
        txt2  = lv_line2.

  ENDMETHOD.