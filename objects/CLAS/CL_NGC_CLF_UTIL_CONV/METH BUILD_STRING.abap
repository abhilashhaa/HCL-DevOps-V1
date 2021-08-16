  METHOD build_string.

    DATA:
      ls_core_characteristic_header TYPE ngcs_core_charc_header,
      ls_core_characteristic_value  TYPE ngcs_core_charc_value_data.


    CLEAR: ev_charcvalue.


    " header data
    ls_core_characteristic_header-characteristic         = is_characteristic_header-characteristic.
    ls_core_characteristic_header-charcvalueunit         = is_characteristic_header-charcvalueunit.
    ls_core_characteristic_header-charcdatatype          = is_characteristic_header-charcdatatype.
    ls_core_characteristic_header-charcdecimals          = is_characteristic_header-charcdecimals.
    ls_core_characteristic_header-charclength            = is_characteristic_header-charclength.
    ls_core_characteristic_header-negativevalueisallowed = is_characteristic_header-negativevalueisallowed.
    ls_core_characteristic_header-charctemplate          = is_characteristic_header-charctemplate.
    ls_core_characteristic_header-charcexponentformat    = is_characteristic_header-charcexponentformat.
    ls_core_characteristic_header-charcexponentvalue     = is_characteristic_header-charcexponentvalue.

    " value data
    ls_core_characteristic_value-charcvalue                = is_ausp-atwrt.
    ls_core_characteristic_value-charcvaluedependency      = is_ausp-atcod.
    ls_core_characteristic_value-charcfromnumericvalue     = is_ausp-atflv.
    ls_core_characteristic_value-charctonumericvalue       = is_ausp-atflb.
    ls_core_characteristic_value-charcfromnumericvalueunit = is_ausp-atawe.
    ls_core_characteristic_value-charctonumericvalueunit   = is_ausp-ataw1.

    " conversion call
    io_ngc_core_cls_util_intersect->build_string(
      EXPORTING
        iv_charcinternalid = is_ausp-atinn
        is_charc_head      = ls_core_characteristic_header
        "iv_simplify_value  = abap_false
      IMPORTING
        et_core_message    = DATA(lt_core_message)
      CHANGING
        cs_charc_value     = ls_core_characteristic_value
    ).

    io_clf_api_result->add_messages_from_core(
      is_classification_key = is_classification_key
      it_core_message       = lt_core_message ).

    ev_charcvalue = ls_core_characteristic_value-charcvalue.

  ENDMETHOD.