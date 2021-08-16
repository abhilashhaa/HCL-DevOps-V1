  METHOD validate_value.

    IF is_characteristic-charccheckfunctionmodule IS NOT INITIAL.
      me->check_in_function_module(
        EXPORTING
          iv_function_name     = is_characteristic-charccheckfunctionmodule
          iv_characteristic    = is_characteristic-characteristic
          iv_charcinternalid   = is_characteristic-charcinternalid
          iv_charcvalue        = iv_charcvalue
        IMPORTING
          ev_new_charcvalue    = ev_new_charcvalue
        EXCEPTIONS
          value_not_found      = 1
          function_not_found   = 2
          OTHERS               = 3 ).

      IF sy-subrc = 1.
        RAISE value_not_found.
      ELSEIF sy-subrc = 2.
        RAISE function_not_found.
      ELSE.
        " Other exception
      ENDIF.
    ENDIF.

    IF is_characteristic-charcchecktable IS NOT INITIAL.
      me->check_in_check_table(
        EXPORTING
          is_characteristic   = is_characteristic
          iv_classtype        = iv_classtype
          iv_charcvalue       = iv_charcvalue
          iv_check_table_name = is_characteristic-charcchecktable
        IMPORTING
          ev_new_charcvalue   = ev_new_charcvalue
        EXCEPTIONS
          value_not_found     = 1
          OTHERS              = 2 ).

      IF sy-subrc <> 0.
        RAISE value_not_found.
      ENDIF.

      " TODO: Check ATKON field (missing)!
*      me->convert_internal_to_external(
*        EXPORTING
*          iv_class_type     = iv_classtype
*          iv_assigned_value = iv_assigned_value
*          is_characteristic = is_characteristic
*        IMPORTING
*          ev_new_value      = ev_new_value ).
    ENDIF.

    " TODO: Check: QKATART_CL missing!
    IF is_characteristic-charcselectedset IS NOT INITIAL AND
       is_characteristic-plant IS NOT INITIAL.
      me->check_catalog_value(
        EXPORTING
          iv_plant          = is_characteristic-plant
          iv_catalog        = ''
          iv_selection_set  = is_characteristic-charcselectedset
          iv_charcvalue     = iv_charcvalue
        IMPORTING
          ev_new_charcvalue = ev_new_charcvalue
        EXCEPTIONS
          value_not_found   = 1
          OTHERS            = 2 ).

      IF sy-subrc <> 0.
        RAISE value_not_found.
      ENDIF.
    ENDIF.

  ENDMETHOD.