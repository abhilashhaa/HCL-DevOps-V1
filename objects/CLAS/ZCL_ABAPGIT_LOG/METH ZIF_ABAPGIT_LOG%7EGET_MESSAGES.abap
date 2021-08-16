  METHOD zif_abapgit_log~get_messages.
    DATA ls_msg TYPE zif_abapgit_log~ty_log_out.
    FIELD-SYMBOLS <ls_log> TYPE ty_log.
    LOOP AT mt_log ASSIGNING <ls_log>.
      ls_msg-type      = <ls_log>-msg-type.
      ls_msg-text      = <ls_log>-msg-text.
      ls_msg-obj_type  = <ls_log>-item-obj_type.
      ls_msg-obj_name  = <ls_log>-item-obj_name.
      ls_msg-exception = <ls_log>-exception.
      APPEND ls_msg TO rt_msg.
    ENDLOOP.
  ENDMETHOD.