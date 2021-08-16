  METHOD convert_fltp_to_curr.

    DATA ls_message TYPE bapireturn.

    ev_error = abap_false.

    DATA(lv_amount) = CONV bapicurr_d( iv_fltp_value ).

    CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
      EXPORTING
        currency             = iv_currency
        amount_external      = lv_amount
        max_number_of_digits = mc_max_len_new_curr_val
      IMPORTING
        amount_internal      = rv_curr ##NUMBER_OK
        return               = ls_message.

    IF ls_message IS NOT INITIAL.
      MESSAGE e099(sdmi) WITH iv_atnam iv_fltp_value iv_currency ls_message-message INTO me->mo_logger->mv_logmsg.
      me->mo_logger->add_error( ).
      ev_error = abap_true.
    ENDIF.

    IF iv_fltp_value IS NOT INITIAL AND rv_curr = 0 AND ev_error = abap_false.
      MESSAGE e099(sdmi) WITH iv_atnam iv_fltp_value iv_currency 'Data loss occurred when converting' INTO me->mo_logger->mv_logmsg.
      me->mo_logger->add_error( ).
      ev_error = abap_true.
    ENDIF.

  ENDMETHOD.