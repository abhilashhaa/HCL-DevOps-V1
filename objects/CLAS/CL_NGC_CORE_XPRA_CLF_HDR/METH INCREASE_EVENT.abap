METHOD INCREASE_EVENT.

  READ TABLE ct_events ASSIGNING FIELD-SYMBOL(<ls_event>) WITH TABLE KEY event = iv_event param = iv_param.
  IF sy-subrc EQ 0.
    ADD 1 TO <ls_event>-count.
  ELSE.
    APPEND VALUE #( event = iv_event param = iv_param count = 1 ) TO ct_events.
  ENDIF.

ENDMETHOD.