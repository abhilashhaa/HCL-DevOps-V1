  METHOD set_single_msg_var_clike.
    " a kind of MOVE where all conversion errors are signalled by exceptions
    WRITE iv_arg LEFT-JUSTIFIED TO rv_target.
  ENDMETHOD.