METHOD get_charc_and_dom_vals.

  CLEAR: es_characteristic_header, et_domain_values, et_characteristic_ref, eo_clf_api_result.

  me->calculate_charcs_and_dom_vals(
    EXPORTING
      it_classes            = it_classes
      is_classification_key = is_classification_key
    IMPORTING
      eo_clf_api_result     = DATA(lo_clf_api_result) ).

  ASSIGN me->mt_intersected_dom_val[ classtype       = iv_classtype
                                     charcinternalid = iv_charcinternalid ]
    TO FIELD-SYMBOL(<ls_intersected_dom_val>).
  IF sy-subrc = 0.
    es_characteristic_header = <ls_intersected_dom_val>-characteristic_head.
    et_domain_values         = <ls_intersected_dom_val>-domain_values.
    eo_clf_api_result        = lo_clf_api_result.
  ENDIF.

  ASSIGN me->mt_characteristic_ref[ classtype       = iv_classtype
                                    charcinternalid = iv_charcinternalid ]
    TO FIELD-SYMBOL(<ls_characteristic_ref>).
  IF sy-subrc = 0.
    et_characteristic_ref = <ls_characteristic_ref>-characteristic_ref.
  ENDIF.

ENDMETHOD.