METHOD if_ngc_clf_api_write~validate.

  DATA:
    lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  LOOP AT it_classification_object ASSIGNING FIELD-SYMBOL(<ls_classification_object>)
    WHERE classification IS BOUND.
    mo_clf_validation_mgr->validate(
      EXPORTING
        io_classification = <ls_classification_object>-classification
      IMPORTING
        eo_clf_api_result = DATA(lo_clf_api_result_tmp)
    ).
    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).
  ENDLOOP.

  eo_clf_api_result = lo_clf_api_result.

ENDMETHOD.