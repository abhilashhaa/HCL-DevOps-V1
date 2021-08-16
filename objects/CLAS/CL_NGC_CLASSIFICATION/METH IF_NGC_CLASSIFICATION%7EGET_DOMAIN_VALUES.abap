  METHOD if_ngc_classification~get_domain_values.

    CLEAR: et_domain_value, eo_clf_api_result.

    eo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    me->if_ngc_classification~get_assigned_classes(
      IMPORTING
        et_assigned_class = DATA(lt_assigned_class) ).

    me->mo_clf_util_intersect->get_charc_and_dom_vals(
      EXPORTING
        iv_classtype          = iv_classtype
        iv_charcinternalid    = iv_charcinternalid
        is_classification_key = me->ms_classification_key
        it_classes            = lt_assigned_class
      IMPORTING
*     es_characteristic_header =
        et_domain_values      = et_domain_value
        eo_clf_api_result     = eo_clf_api_result ).

  ENDMETHOD.