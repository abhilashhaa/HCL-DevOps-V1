  METHOD conversion_exit_isola_output.

    CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
      EXPORTING
        input  = iv_spras
      IMPORTING
        output = rv_spras.

  ENDMETHOD.