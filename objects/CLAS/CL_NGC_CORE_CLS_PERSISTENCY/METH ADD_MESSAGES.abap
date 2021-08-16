METHOD add_messages.

  LOOP AT it_core_message ASSIGNING FIELD-SYMBOL(<ls_core_message>).
    READ TABLE ct_core_class_message ASSIGNING FIELD-SYMBOL(<ls_core_class_message>)
      WITH KEY classinternalid = is_core_class_key-classinternalid
               key_date        = is_core_class_key-key_date
               msgty           = <ls_core_message>-msgty
               msgid           = <ls_core_message>-msgid
               msgno           = <ls_core_message>-msgno
               msgv1           = <ls_core_message>-msgv1
               msgv2           = <ls_core_message>-msgv2
               msgv3           = <ls_core_message>-msgv3
               msgv4           = <ls_core_message>-msgv4.
    IF sy-subrc <> 0.
      APPEND INITIAL LINE TO ct_core_class_message ASSIGNING <ls_core_class_message>.
      MOVE-CORRESPONDING is_core_class_key TO <ls_core_class_message>.
      MOVE-CORRESPONDING <ls_core_message> TO <ls_core_class_message>.
    ENDIF.
  ENDLOOP.

  LOOP AT it_core_charc_message ASSIGNING FIELD-SYMBOL(<ls_core_charc_message>).
    READ TABLE ct_core_class_message ASSIGNING <ls_core_class_message>
      WITH KEY classinternalid = is_core_class_key-classinternalid
               key_date        = is_core_class_key-key_date
               msgty           = <ls_core_message>-msgty
               msgid           = <ls_core_message>-msgid
               msgno           = <ls_core_message>-msgno
               msgv1           = <ls_core_message>-msgv1
               msgv2           = <ls_core_message>-msgv2
               msgv3           = <ls_core_message>-msgv3
               msgv4           = <ls_core_message>-msgv4.
    IF sy-subrc <> 0.
      APPEND INITIAL LINE TO ct_core_class_message ASSIGNING <ls_core_class_message>.
      MOVE-CORRESPONDING is_core_class_key TO <ls_core_class_message>.
      MOVE-CORRESPONDING <ls_core_charc_message> TO <ls_core_class_message>.
    ENDIF.
  ENDLOOP.

ENDMETHOD.