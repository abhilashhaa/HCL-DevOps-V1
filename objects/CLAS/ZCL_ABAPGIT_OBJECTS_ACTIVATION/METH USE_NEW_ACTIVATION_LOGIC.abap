  METHOD use_new_activation_logic.

    CALL FUNCTION 'FUNCTION_EXISTS'
      EXPORTING
        funcname           = 'DD_MASS_ACT_C3'
      EXCEPTIONS
        function_not_exist = 1
        OTHERS             = 2.
    IF sy-subrc = 0.
      rv_use_new_activation_logic = abap_true.
    ENDIF.

  ENDMETHOD.