METHOD add_messages_from_core.

  LOOP AT it_core_message ASSIGNING FIELD-SYMBOL(<ls_core_message>).
    APPEND VALUE ngcs_classification_msg( object_key       = is_classification_key-object_key
                                          technical_object = is_classification_key-technical_object
                                          change_number    = is_classification_key-change_number
                                          key_date         = is_classification_key-key_date
                                          msgid            = <ls_core_message>-msgid
                                          msgty            = <ls_core_message>-msgty
                                          msgno            = <ls_core_message>-msgno
                                          msgv1            = <ls_core_message>-msgv1
                                          msgv2            = <ls_core_message>-msgv2
                                          msgv3            = <ls_core_message>-msgv3
                                          msgv4            = <ls_core_message>-msgv4
                                          ref_key          = ir_ref_key
                                          ref_type         = iv_ref_type ) TO mt_message.
  ENDLOOP.

ENDMETHOD.