  METHOD clear_functiongroup_globals.
    TYPES ty_param_vari TYPE abap_bool.

    DATA lt_error_list TYPE STANDARD TABLE OF rsmp_check WITH DEFAULT KEY.
    FIELD-SYMBOLS <lv_param_vari> TYPE ty_param_vari.

    " only way to clear global fields in function group
    CALL FUNCTION 'RS_TRANSACTION_INCONSISTENCIES'
      EXPORTING
        transaction_code = 'ZTHISTCODENEVEREXIST'
      TABLES
        error_list       = lt_error_list
      EXCEPTIONS
        object_not_found = 1
        OTHERS           = 2.
    IF sy-subrc <> 0.
      "Expected - fine

      " but there is no other way to clear this field
      ASSIGN ('(SAPLSEUK)PARAM_VARI') TO <lv_param_vari>.
      IF sy-subrc = 0.
        CLEAR <lv_param_vari>.
      ENDIF.

    ENDIF.

  ENDMETHOD.