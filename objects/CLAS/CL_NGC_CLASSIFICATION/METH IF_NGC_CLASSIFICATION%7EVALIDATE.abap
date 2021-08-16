  METHOD if_ngc_classification~validate.

    CLEAR: eo_clf_api_result.

    " Call Validation Manager to Validate
    mo_clf_validation_manager->validate( EXPORTING io_classification = me
                                         IMPORTING eo_clf_api_result = eo_clf_api_result ).

  ENDMETHOD.