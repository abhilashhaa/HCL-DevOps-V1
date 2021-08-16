METHOD add_messages_from_spi.

  LOOP AT it_spi_msg ASSIGNING FIELD-SYMBOL(<ls_spi_msg>).
    APPEND VALUE ngcs_class_msg( classinternalid = is_class_key-classinternalid
                                 key_date        = is_class_key-key_date
                                 msgid           = <ls_spi_msg>-msgid
                                 msgty           = <ls_spi_msg>-msgty
                                 msgno           = <ls_spi_msg>-msgno
                                 msgv1           = <ls_spi_msg>-msgv1
                                 msgv2           = <ls_spi_msg>-msgv2
                                 msgv3           = <ls_spi_msg>-msgv3
                                 msgv4           = <ls_spi_msg>-msgv4
                                 ref_key         = ir_ref_key ) TO mt_message.
  ENDLOOP.

ENDMETHOD.