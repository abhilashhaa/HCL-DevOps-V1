METHOD convert_fltp_buom_to_uom.

  CLEAR:
   ev_fltp_value, ev_numerator, ev_denominator, ev_add_const.

  CALL FUNCTION 'UNIT_CONVERSION_SIMPLE'
    EXPORTING
      input                = iv_fltp_value
      unit_in              = iv_buom
      unit_out             = iv_uom
    IMPORTING
      output               = ev_fltp_value
      add_const            = ev_add_const
      numerator            = ev_numerator
      denominator          = ev_denominator
    EXCEPTIONS
      conversion_not_found = 1
      division_by_zero     = 2
      input_invalid        = 3
      output_invalid       = 4
      overflow             = 5
      type_invalid         = 6
      units_missing        = 7
      unit_in_not_found    = 8
      unit_out_not_found   = 9
      OTHERS               = 10.

  IF sy-subrc <> 0.
    MESSAGE e099(sdmi) WITH iv_atnam iv_fltp_value 'Unit conversion failed' sy-subrc INTO me->mo_logger->mv_logmsg.
    me->mo_logger->add_error( ).
  ENDIF.

ENDMETHOD.