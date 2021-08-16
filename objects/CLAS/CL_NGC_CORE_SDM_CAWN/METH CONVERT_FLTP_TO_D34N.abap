  METHOD convert_fltp_to_d34n.

    DATA:
      lv_fltp_value   TYPE fltp_value,
      lr_data         TYPE REF TO data,
      lv_char_val     TYPE atwrt.

    FIELD-SYMBOLS:
      <lv_packed_num> TYPE any,
      <exp_sign>      TYPE any,
      <exp>           TYPE any.


    DATA(lv_uom_conv) = xsdbool(
       iv_buom IS NOT INITIAL AND
       iv_uom  IS NOT INITIAL AND
       iv_buom <> iv_uom ).

    IF lv_uom_conv = abap_true.
      me->convert_fltp_buom_to_uom(
        EXPORTING
          iv_atnam       = iv_atnam
          iv_fltp_value  = iv_fltp_value
          iv_buom        = iv_buom
          iv_uom         = iv_uom
        IMPORTING
          ev_fltp_value  = lv_fltp_value
          ev_numerator   = DATA(lv_numerator)
          ev_denominator = DATA(lv_denominator)
          ev_add_const   = DATA(lv_add_const)
      ).
    ELSE.
      lv_fltp_value = iv_fltp_value.
    ENDIF.

    CASE iv_exp_disp_format.
      WHEN 0. " No exponent
        CALL FUNCTION 'ROUND'
          EXPORTING
            decimals      = iv_decimals
            input         = lv_fltp_value
            sign          = 'X'
          IMPORTING
            output        = lv_fltp_value
          EXCEPTIONS
            input_invalid = 1
            overflow      = 2
            type_invalid  = 3
            OTHERS        = 4.

        IF sy-subrc <> 0.
          MESSAGE e099(sdmi) WITH 'Rounding error:' iv_atnam iv_fltp_value INTO me->mo_logger->mv_logmsg ##NO_TEXT.
          me->mo_logger->add_error( ).
          RETURN.
        ENDIF.

        TRY.
            CREATE DATA lr_data TYPE p LENGTH 16 DECIMALS iv_decimals.
            ASSIGN lr_data->* TO <lv_packed_num>.
            <lv_packed_num> = lv_fltp_value.
            rv_d34n         = <lv_packed_num>.

          CATCH cx_root INTO DATA(lx_exception).
            MESSAGE e099(sdmi) WITH iv_atnam iv_fltp_value lx_exception->get_text( ) INTO me->mo_logger->mv_logmsg.
            me->mo_logger->add_error( ).
            RETURN.
        ENDTRY.

      WHEN 1. " Standard
        WRITE iv_fltp_value TO lv_char_val DECIMALS iv_decimals.

      WHEN 2. " Exponent entered
        WRITE iv_fltp_value TO lv_char_val DECIMALS iv_decimals EXPONENT iv_exponent.

      WHEN 3. " Scientific exponent
        " Determine exponent and sign.
        WRITE iv_fltp_value TO lv_char_val.
        SEARCH lv_char_val FOR 'E'.
        ADD 1 TO sy-fdpos.
        ASSIGN lv_char_val+sy-fdpos(1) TO <exp_sign>.
        ADD 1 TO sy-fdpos.
        ASSIGN lv_char_val+sy-fdpos(*) TO <exp>.

        " Determine scientific exponent.
        DATA(exp_f) = CONV f( <exp> ).
        IF <exp_sign> EQ '-'.
          exp_f = exp_f - '0.2' .
          DATA(exp_i) = CONV i( ( trunc( exp_f / 3 ) + 1 ) * ( -3 ) ).
        ELSE.
          exp_i = CONV i( trunc( exp_f / 3 ) * 3 ).
        ENDIF.

        " Convert float to scientific exponent
        WRITE iv_fltp_value TO lv_char_val DECIMALS iv_decimals EXPONENT exp_i.

      WHEN OTHERS.
        MESSAGE e099(sdmi) WITH 'Unexpected exponent format' iv_atnam iv_fltp_value INTO me->mo_logger->mv_logmsg ##NO_TEXT.
        me->mo_logger->add_error( ).
        RETURN.

    ENDCASE.

    IF iv_exp_disp_format = 1 OR
       iv_exp_disp_format = 2 OR
       iv_exp_disp_format = 3.

      TRY.
          cl_abap_decfloat=>read_decfloat34(
          EXPORTING
            string = lv_char_val
          IMPORTING
            value  = rv_d34n
        ).

        CATCH cx_root INTO lx_exception.
        MESSAGE e099(sdmi) WITH iv_atnam iv_fltp_value lx_exception->get_text( ) INTO me->mo_logger->mv_logmsg.
        me->mo_logger->add_error( ).
    ENDTRY.
    ENDIF.


    IF lv_uom_conv = abap_true.

      rv_d34n = me->convert_d34n_uom_to_buom(
        EXPORTING
          iv_d34n                 = rv_d34n
          iv_buom2uom_numerator   = lv_numerator
          iv_buom2uom_denominator = lv_denominator
          iv_buom2uom_add_const   = lv_add_const ).

    ENDIF.

  ENDMETHOD.