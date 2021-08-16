  METHOD if_ngc_clf_validator~validate.

    DATA:
      lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
      lt_value_changes  TYPE ngct_valuation_charcvalue_chg,
      lv_charcvalue     TYPE atwrt,
      lv_translated     TYPE abap_bool VALUE abap_false.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    io_classification->get_assigned_values(
      IMPORTING
        et_valuation_data = DATA(lt_assigned_values) ).

    io_classification->get_characteristics(
      IMPORTING
        et_characteristic = DATA(lt_characteristics) ).

    LOOP AT lt_assigned_values ASSIGNING FIELD-SYMBOL(<ls_assigned_value>).
      READ TABLE lt_characteristics
        ASSIGNING FIELD-SYMBOL(<ls_characteristic>)
        WITH KEY
          charcinternalid = <ls_assigned_value>-charcinternalid.

      IF sy-subrc = 0.
        DATA(ls_char_header) = <ls_characteristic>-characteristic_object->get_header( ).

        IF ls_char_header-charccheckfunctionmodule IS INITIAL AND
           ls_char_header-charcchecktable IS INITIAL AND
           ls_char_header-charcselectedset IS INITIAL AND
           ls_char_header-plant IS INITIAL.
          CONTINUE.
        ENDIF.

        lv_charcvalue = <ls_assigned_value>-charcvalue.

        IF ls_char_header-charcdatatype        = if_ngc_c=>gc_charcdatatype-char AND
           ls_char_header-valueiscasesensitive = abap_false.
          lv_translated = abap_true.
          TRANSLATE lv_charcvalue TO UPPER CASE.
        ENDIF.

        validate_value(
          EXPORTING
            is_characteristic  = ls_char_header
            iv_charcvalue      = lv_charcvalue
            iv_classtype       = iv_classtype
          IMPORTING
            ev_new_charcvalue  = DATA(lv_new_charcvalue)
          EXCEPTIONS
            value_not_found    = 1
            function_not_found = 2
            OTHERS             = 3 ).

        IF sy-subrc      <> 0 AND
           lv_translated =  abap_true.
          validate_value(
            EXPORTING
              is_characteristic  = ls_char_header
              iv_charcvalue      = <ls_assigned_value>-charcvalue
              iv_classtype       = <ls_assigned_value>-classtype
            IMPORTING
              ev_new_charcvalue  = lv_new_charcvalue
            EXCEPTIONS
              value_not_found    = 1
              function_not_found = 2
              OTHERS             = 3 ).
        ENDIF.

        IF sy-subrc = 0.
          APPEND VALUE #(
            classtype       = iv_classtype
            charcinternalid = <ls_assigned_value>-charcinternalid
            charcvaluenew   = lv_new_charcvalue
            charcvalueold   = <ls_assigned_value>-charcvalue ) TO lt_value_changes.
        ELSE.
          " TODO: SET_ILLEGAL_VALUE_FROM_DDB in case of char type ?
          DATA(ls_classification_key) = io_classification->get_classification_key( ).

          MESSAGE e014(ngc_api_base) WITH ls_char_header-charcdescription <ls_assigned_value>-charcvalue INTO DATA(ls_message) ##NEEDED.
          lo_clf_api_result->add_message_from_sy(
            is_classification_key = ls_classification_key ).
        ENDIF.
      ENDIF.
    ENDLOOP.

    IF lt_value_changes IS NOT INITIAL.
      io_data_provider->update_assigned_values( lt_value_changes ).
    ENDIF.

    ro_clf_api_result = lo_clf_api_result.

  ENDMETHOD.