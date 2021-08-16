  METHOD command.

    DATA ls_cmd LIKE LINE OF mt_commands.

    ASSERT iv_as_a IS INITIAL OR iv_is_main IS INITIAL.

    ls_cmd-label = iv_label.
    ls_cmd-action = iv_action.
    ls_cmd-is_main = iv_is_main.
    ls_cmd-as_a = iv_as_a.

    APPEND ls_cmd TO mt_commands.

    ro_self = me.

  ENDMETHOD.