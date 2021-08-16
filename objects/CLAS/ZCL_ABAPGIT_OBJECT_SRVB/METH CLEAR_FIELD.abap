  METHOD clear_field.

    FIELD-SYMBOLS: <lv_value> TYPE data.

    ASSIGN COMPONENT iv_fieldname OF STRUCTURE cs_service_binding
           TO <lv_value>.
    ASSERT sy-subrc = 0.

    CLEAR: <lv_value>.

  ENDMETHOD.