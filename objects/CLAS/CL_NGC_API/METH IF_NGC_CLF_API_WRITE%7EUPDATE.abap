METHOD if_ngc_clf_api_write~update.

  update(
    EXPORTING
      it_classification_object = it_classification_object
    IMPORTING
      eo_clf_api_result        = eo_clf_api_result
  ).

ENDMETHOD.