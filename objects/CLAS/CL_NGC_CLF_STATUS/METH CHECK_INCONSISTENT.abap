  METHOD check_inconsistent.

    DATA lo_data_provider TYPE REF TO if_ngc_clf_validation_dp.

    lo_data_provider ?= io_classification.

    " Check if assigned values are still valid
    DATA(lo_clf_api_result) = mo_domain_value_validator->validate(
      EXPORTING
        io_classification = io_classification
        io_data_provider  = lo_data_provider
        iv_classtype      = is_classification_data-classtype ).

    rv_inconsistent = lo_clf_api_result->has_message( ).

    IF rv_inconsistent = abap_false.
      " Check if removed values are used by leaf objects
      lo_clf_api_result = mo_value_used_leaf_validator->validate(
        EXPORTING
          io_classification = io_classification
          io_data_provider  = lo_data_provider
          iv_classtype      = is_classification_data-classtype ).

      rv_inconsistent = lo_clf_api_result->has_message( ).
    ENDIF.

  ENDMETHOD.