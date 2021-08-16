METHOD add_messages_from_core_clf.

  LOOP AT it_core_message ASSIGNING FIELD-SYMBOL(<ls_core_message>).
    APPEND VALUE ngcs_classification_msg( object_key       = <ls_core_message>-object_key
                                          technical_object = <ls_core_message>-technical_object
                                          change_number    = <ls_core_message>-change_number
                                          key_date         = <ls_core_message>-key_date
                                          msgid            = <ls_core_message>-msgid
                                          msgty            = <ls_core_message>-msgty
                                          msgno            = <ls_core_message>-msgno
                                          msgv1            = <ls_core_message>-msgv1
                                          msgv2            = <ls_core_message>-msgv2
                                          msgv3            = <ls_core_message>-msgv3
                                          msgv4            = <ls_core_message>-msgv4 ) TO mt_message.
  ENDLOOP.

ENDMETHOD.