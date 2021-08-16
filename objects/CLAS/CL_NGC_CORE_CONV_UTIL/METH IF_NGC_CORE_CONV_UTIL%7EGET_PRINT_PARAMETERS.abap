  METHOD if_ngc_core_conv_util~get_print_parameters.

    CLEAR: es_out_parameters, ev_valid, ev_sy_subrc.

    CALL FUNCTION 'GET_PRINT_PARAMETERS'
      EXPORTING
        line_size      = iv_line_size
        no_dialog      = iv_no_dialog
      IMPORTING
        out_parameters = es_out_parameters
        valid          = ev_valid
      EXCEPTIONS
        OTHERS         = 4.

    ev_sy_subrc = sy-subrc.

  ENDMETHOD.