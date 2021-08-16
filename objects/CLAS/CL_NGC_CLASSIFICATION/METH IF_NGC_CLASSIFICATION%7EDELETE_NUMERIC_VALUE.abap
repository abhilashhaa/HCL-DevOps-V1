  METHOD if_ngc_classification~delete_numeric_value.

    delete_characteristic_value(
      EXPORTING
        iv_charc_type     = if_ngc_c=>gc_charcdatatype-num
        it_change_value   = it_change_value
      IMPORTING
        eo_clf_api_result = eo_clf_api_result
        et_success_value  = et_success_value
    ).

  ENDMETHOD.