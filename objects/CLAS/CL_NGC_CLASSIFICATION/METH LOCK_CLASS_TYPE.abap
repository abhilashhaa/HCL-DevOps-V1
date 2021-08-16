  METHOD lock_class_type.

    DATA:
      lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    LOOP AT it_classtype INTO DATA(lv_classtype).
      me->if_ngc_classification~lock_all(
        EXPORTING
          iv_classtype      = lv_classtype
        IMPORTING
          eo_clf_api_result = DATA(lo_clf_api_result_tmp) ).

      lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).
    ENDLOOP.

    ro_clf_api_result = lo_clf_api_result.

  ENDMETHOD.