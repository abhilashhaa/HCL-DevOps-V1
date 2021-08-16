  METHOD if_ngc_core_util~function_exists.

    CALL FUNCTION 'FUNCTION_EXISTS'
      EXPORTING
        funcname = iv_function_name
      EXCEPTIONS
        OTHERS   = 1.

    rv_function_exists = boolc( sy-subrc = 0 ).

  ENDMETHOD.