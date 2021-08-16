METHOD add_message_from_sy.

  APPEND VALUE ngcs_classification_msg( object_key       = is_classification_key-object_key
                                        technical_object = is_classification_key-technical_object
                                        change_number    = is_classification_key-change_number
                                        key_date         = is_classification_key-key_date
                                        msgid            = sy-msgid
                                        msgty            = sy-msgty
                                        msgno            = sy-msgno
                                        msgv1            = sy-msgv1
                                        msgv2            = sy-msgv2
                                        msgv3            = sy-msgv3
                                        msgv4            = sy-msgv4
                                        ref_key          = ir_ref_key
                                        ref_type         = iv_ref_type ) TO mt_message.

ENDMETHOD.