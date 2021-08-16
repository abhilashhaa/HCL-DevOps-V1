  METHOD zif_abapgit_popups~popup_to_confirm.

    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        titlebar              = iv_titlebar
        text_question         = iv_text_question
        text_button_1         = iv_text_button_1
        icon_button_1         = iv_icon_button_1
        text_button_2         = iv_text_button_2
        icon_button_2         = iv_icon_button_2
        default_button        = iv_default_button
        display_cancel_button = iv_display_cancel_button
      IMPORTING
        answer                = rv_answer
      EXCEPTIONS
        text_not_found        = 1
        OTHERS                = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from POPUP_TO_CONFIRM' ).
    ENDIF.

  ENDMETHOD.