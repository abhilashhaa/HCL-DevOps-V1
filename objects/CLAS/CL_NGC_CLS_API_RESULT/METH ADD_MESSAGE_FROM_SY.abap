METHOD add_message_from_sy.

  APPEND VALUE ngcs_class_msg( classinternalid = is_class_key-classinternalid
                               key_date        = is_class_key-key_date
                               msgid           = sy-msgid
                               msgty           = sy-msgty
                               msgno           = sy-msgno
                               msgv1           = sy-msgv1
                               msgv2           = sy-msgv2
                               msgv3           = sy-msgv3
                               msgv4           = sy-msgv4
                               ref_key         = ir_ref_key ) TO mt_message.

ENDMETHOD.