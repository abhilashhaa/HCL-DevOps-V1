METHOD validate.

  DATA:
    lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
    lo_data_provider  TYPE REF TO if_ngc_clf_validation_dp.

  CLEAR: eo_clf_api_result.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  IF io_classification IS NOT BOUND.
    RETURN.
  ENDIF.

  " Validation only works on Classification object instances which
  " implement the validation data provider interface (IF_NGC_CLF_VALIDATION_DP)
  TRY.
      lo_data_provider ?= io_classification.
    CATCH cx_sy_move_cast_error.
      ASSERT 1 = 2. " This should not happen!
  ENDTRY.

  " Get and process list of class types to be validated
  DATA(lt_validation_class_types) = lo_data_provider->get_validation_class_types( ).
  lo_data_provider->clear_validation_class_types( ).

  LOOP AT lt_validation_class_types ASSIGNING FIELD-SYMBOL(<lv_classtype>).

    " Get list of validators for the given class type
    DATA(lt_validators) = get_validators_for_class_type( <lv_classtype> ).

    " Call Validators and collect results
    LOOP AT lt_validators ASSIGNING FIELD-SYMBOL(<ls_validator>).
      DATA(lo_clf_api_result_tmp) = <ls_validator>-validator->validate( iv_classtype      = <lv_classtype>
                                                                        io_data_provider  = lo_data_provider
                                                                        io_classification = io_classification ).
      IF lo_clf_api_result_tmp IS BOUND AND lo_clf_api_result_tmp->has_message( ) = abap_true.
        lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).
      ENDIF.
    ENDLOOP.

  ENDLOOP.

  eo_clf_api_result = lo_clf_api_result.

ENDMETHOD.