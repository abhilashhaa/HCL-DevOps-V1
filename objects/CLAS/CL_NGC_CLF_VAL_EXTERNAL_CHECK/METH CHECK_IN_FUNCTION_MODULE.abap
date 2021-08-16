  METHOD check_in_function_module.

    DATA: lv_function_name  TYPE rs38l_fnam,
          lv_new_charcvalue TYPE atwrt.

    ev_new_charcvalue = iv_charcvalue.
    lv_function_name  = iv_function_name.

    TEST-SEAM fm_function_exists.
      CALL FUNCTION 'FUNCTION_EXISTS'
        EXPORTING
          funcname           = lv_function_name
        EXCEPTIONS
          function_not_exist = 1
          OTHERS             = 2.
    END-TEST-SEAM.

    IF sy-subrc <> 0.
      RAISE function_not_found.
    ENDIF.

    TEST-SEAM call_function_dynamic.
      CALL FUNCTION iv_function_name
        EXPORTING
          charact    = iv_characteristic
          charact_no = iv_charcinternalid
          value      = iv_charcvalue
        IMPORTING
          value_ex   = lv_new_charcvalue
        EXCEPTIONS
          not_found  = 1
          OTHERS     = 2.
    END-TEST-SEAM.

    IF sy-subrc <> 0.
      RAISE value_not_found.
    ENDIF.

    IF lv_new_charcvalue IS NOT INITIAL.
      ev_new_charcvalue = lv_new_charcvalue.
    ENDIF.

  ENDMETHOD.