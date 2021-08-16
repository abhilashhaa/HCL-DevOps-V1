  METHOD set_msg_vars_for_clike.

    DATA: ls_msg   TYPE ty_msg,
          lv_dummy TYPE string.

    ls_msg = split_text( iv_text ).

    MESSAGE e001(00) WITH ls_msg-msgv1 ls_msg-msgv2 ls_msg-msgv3 ls_msg-msgv4 INTO lv_dummy.

  ENDMETHOD.