  METHOD set_single_msg_var.

    FIELD-SYMBOLS <lg_arg> TYPE any.

    IF iv_arg IS INITIAL.
      RETURN.
    ENDIF.

    ASSIGN mo_exception->(iv_arg) TO <lg_arg>.
    IF sy-subrc <> 0.
      CONCATENATE '&' iv_arg '&' INTO rv_target.
      RETURN.
    ENDIF.

    TRY.
        rv_target = set_single_msg_var_clike( iv_arg = <lg_arg> ).
        RETURN.
      CATCH cx_sy_dyn_call_illegal_type ##no_handler.
    ENDTRY.

    TRY.
        rv_target = set_single_msg_var_numeric( iv_arg = <lg_arg> ).
        RETURN.
      CATCH cx_sy_dyn_call_illegal_type ##no_handler.
    ENDTRY.

    TRY.
        rv_target = set_single_msg_var_xseq( iv_arg = <lg_arg> ).
        RETURN.
      CATCH cx_sy_dyn_call_illegal_type ##no_handler.
    ENDTRY.

    CONCATENATE '&' iv_arg '&' INTO rv_target.

  ENDMETHOD.