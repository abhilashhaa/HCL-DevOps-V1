METHOD add_messages_from_symsg_tab.
  LOOP AT it_symsg_tab ASSIGNING FIELD-SYMBOL(<ls_symsg>).
    APPEND VALUE #( object_key       = is_classification_key-object_key
                    technical_object = is_classification_key-technical_object
                    change_number    = is_classification_key-change_number
                    key_date         = is_classification_key-key_date
                    msgty            = <ls_symsg>-msgty
                    msgid            = <ls_symsg>-msgid
                    msgno            = <ls_symsg>-msgno
                    msgv1            = <ls_symsg>-msgv1
                    msgv2            = <ls_symsg>-msgv2
                    msgv3            = <ls_symsg>-msgv3
                    msgv4            = <ls_symsg>-msgv4 ) TO mt_message.
  ENDLOOP.
ENDMETHOD.