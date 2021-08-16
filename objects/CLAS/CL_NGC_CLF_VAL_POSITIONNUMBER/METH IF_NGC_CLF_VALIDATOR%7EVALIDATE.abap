METHOD if_ngc_clf_validator~validate.

*--------------------------------------------------------------------*
* This implementation calculates the position number (KSSK-ZAEHL)
* if it is not supplied from by the caller.
* Only class assignment (creations) are validated.
*--------------------------------------------------------------------*

  DATA:
    lv_was_modification TYPE boole_d VALUE abap_false.

  " Get updated data from validation data provider
  io_classification->get_updated_data( IMPORTING et_classification_data_upd = DATA(lt_classification_data_upd)
                                                 et_assigned_class_upd      = DATA(lt_assigned_classes_upd) ).

  ro_clf_api_result = NEW cl_ngc_clf_api_result( ).

  LOOP AT lt_assigned_classes_upd ASSIGNING FIELD-SYMBOL(<ls_assigned_classes_upd>)
    WHERE object_state = if_ngc_c=>gc_object_state-created.

    " Save index if this row. We need this to be able to remove the same row from classification data table, if needed.
    DATA(lv_class_idx) = sy-tabix.

    " Class header is needed to get the class type
    DATA(ls_class_header) = <ls_assigned_classes_upd>-class_object->get_header( ).

    " Check only the supplied class type
    IF ls_class_header-classtype <> iv_classtype.
      CONTINUE.
    ENDIF.

    READ TABLE lt_classification_data_upd ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>) INDEX lv_class_idx.
    ASSERT sy-subrc = 0. " should not happen!

    IF <ls_classification_data_upd>-classpositionnumber IS INITIAL.

      <ls_classification_data_upd>-classpositionnumber = get_max_positionnumber( it_classification_data_upd = lt_classification_data_upd ).

      ADD if_ngc_c=>gc_positionnumber_increment TO <ls_classification_data_upd>-classpositionnumber.

      lv_was_modification = abap_true.

    ENDIF.

  ENDLOOP.

  " If there as an error, update the data in the validation data provider
  IF lv_was_modification = abap_true.
    io_data_provider->set_updated_data( it_classification_data_upd = lt_classification_data_upd ).
  ENDIF.

ENDMETHOD.