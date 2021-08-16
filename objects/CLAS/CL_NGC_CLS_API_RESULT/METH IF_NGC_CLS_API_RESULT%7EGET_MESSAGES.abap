METHOD if_ngc_cls_api_result~get_messages.

  IF iv_message_type IS INITIAL.
    rt_message = mt_message.
  ELSE.
    LOOP AT mt_message ASSIGNING FIELD-SYMBOL(<ls_message>)
      WHERE msgty = iv_message_type.
      APPEND <ls_message> TO rt_message.
    ENDLOOP.
  ENDIF.

ENDMETHOD.