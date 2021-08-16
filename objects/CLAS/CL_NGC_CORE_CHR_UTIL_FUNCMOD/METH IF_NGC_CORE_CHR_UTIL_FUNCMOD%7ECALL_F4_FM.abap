  METHOD if_ngc_core_chr_util_funcmod~call_f4_fm.

    CALL FUNCTION iv_function_name
      EXPORTING
        charact               = iv_characteristic
        charact_no            = iv_charcinternalid
        display               = abap_false
        additional_values     = abap_false
        multiple_values       = abap_false
        language              = sy-langu
        display_with_language = abap_true
      TABLES
        values                = rt_values.

  ENDMETHOD.