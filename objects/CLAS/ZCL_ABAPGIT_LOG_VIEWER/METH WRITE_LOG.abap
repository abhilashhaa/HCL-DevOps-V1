  METHOD write_log.

    DATA: lt_message TYPE zif_abapgit_log=>tty_log_out,
          lr_message TYPE REF TO zif_abapgit_log=>ty_log_out,
          lv_text    TYPE string.

    lt_message = ii_log->get_messages( ).

    LOOP AT lt_message REFERENCE INTO lr_message.
      IF lr_message->obj_name IS NOT INITIAL AND lr_message->obj_type IS NOT INITIAL.
        lv_text = |{ lr_message->type }: { lr_message->text } ({ lr_message->obj_type }/{ lr_message->obj_name })|.
      ELSE.
        lv_text = |{ lr_message->type }: { lr_message->text }|.
      ENDIF.
      WRITE: / lv_text.
    ENDLOOP.

  ENDMETHOD.