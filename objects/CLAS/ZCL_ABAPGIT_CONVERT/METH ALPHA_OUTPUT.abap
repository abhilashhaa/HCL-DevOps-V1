  METHOD alpha_output.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
      EXPORTING
        input  = iv_val
      IMPORTING
        output = rv_str.

    CONDENSE rv_str.

  ENDMETHOD.