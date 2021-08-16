  METHOD zif_abapgit_log~add.

    FIELD-SYMBOLS: <ls_log> LIKE LINE OF mt_log.

    APPEND INITIAL LINE TO mt_log ASSIGNING <ls_log>.
    <ls_log>-msg-text  = iv_msg.
    <ls_log>-msg-type  = iv_type.
    <ls_log>-rc        = iv_rc.
    <ls_log>-item      = is_item.
    <ls_log>-exception = ix_exc.

  ENDMETHOD.