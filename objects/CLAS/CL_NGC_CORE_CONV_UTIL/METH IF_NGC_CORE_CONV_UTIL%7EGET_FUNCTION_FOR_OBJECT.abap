  METHOD if_ngc_core_conv_util~get_function_for_object.

    CLEAR: ev_function_name, ev_sy_subrc.

    CALL FUNCTION 'CLOCH_FUNCTION_NAME'
      EXPORTING
        object_type = iv_object_type
      IMPORTING
        func_name   = ev_function_name
      EXCEPTIONS
        OTHERS      = 1.

    ev_sy_subrc = sy-subrc.

  ENDMETHOD.