  METHOD build_string_assigned_values.

    DATA:
      ls_core_characteristic_header TYPE ngcs_core_charc_header,
      ls_core_characteristic_value  TYPE ngcs_core_charc_value_data.

    CLEAR: ev_charcvalue, et_core_message.

    me->if_ngc_classification~get_characteristics(
      EXPORTING iv_classtype       = is_valuation_data-classtype
                iv_charcinternalid = is_valuation_data-charcinternalid
      IMPORTING et_characteristic  = DATA(lt_characteristic) ).

    READ TABLE lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic_header>)
      WITH KEY classtype       = is_valuation_data-classtype
               charcinternalid = is_valuation_data-charcinternalid
               key_date        = ms_classification_key-key_date.
    DATA(ls_characteristic_header) = <ls_characteristic_header>-characteristic_object->get_header( ).

    ls_core_characteristic_header-characteristic         = ls_characteristic_header-characteristic.
    ls_core_characteristic_header-charcvalueunit         = ls_characteristic_header-charcvalueunit.
    ls_core_characteristic_header-charcdatatype          = ls_characteristic_header-charcdatatype.
    ls_core_characteristic_header-charcdecimals          = ls_characteristic_header-charcdecimals.
    ls_core_characteristic_header-charclength            = ls_characteristic_header-charclength.
    ls_core_characteristic_header-negativevalueisallowed = ls_characteristic_header-negativevalueisallowed.
    ls_core_characteristic_header-charctemplate          = ls_characteristic_header-charctemplate.
    ls_core_characteristic_header-charcexponentformat    = ls_characteristic_header-charcexponentformat.
    ls_core_characteristic_header-charcexponentvalue     = ls_characteristic_header-charcexponentvalue.

    ls_core_characteristic_value-charcvalue                = is_valuation_data-charcvalue.
    ls_core_characteristic_value-charcfromnumericvalue     = is_valuation_data-charcfromnumericvalue.
    ls_core_characteristic_value-charctonumericvalue       = is_valuation_data-charctonumericvalue.
    ls_core_characteristic_value-charcvaluedependency      = is_valuation_data-charcvaluedependency.
    ls_core_characteristic_value-charcfromnumericvalueunit = is_valuation_data-charcfromnumericvalueunit.
    ls_core_characteristic_value-charctonumericvalueunit   = is_valuation_data-charctonumericvalueunit.

    mo_core_util_intersect->build_string(
      EXPORTING
        iv_charcinternalid = ls_characteristic_header-charcinternalid
        is_charc_head      = ls_core_characteristic_header
*     iv_simplify_value  = ABAP_FALSE
      IMPORTING
        et_core_message    = et_core_message
      CHANGING
        cs_charc_value     = ls_core_characteristic_value
    ).
    ev_charcvalue = ls_core_characteristic_value-charcvalue.

  ENDMETHOD.