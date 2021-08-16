  METHOD if_ngc_classification~change_date_value.

    change_characteristic_value(
      EXPORTING
        iv_charc_type     = if_ngc_c=>gc_charcdatatype-date
        it_change_value   = it_change_value
*       iv_lock           = ABAP_FALSE
      IMPORTING
        eo_clf_api_result = eo_clf_api_result
        et_success_value  = et_success_value ).

  ENDMETHOD.