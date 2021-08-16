METHOD if_ngc_clf_validator~validate.

**********************************************************************
* This validation checks if the class to be assigned has a status
* which allows classification (TCLU-KLFKZ).
* Otherwise the class cannot be assigned.
* Classification deletions are not checked.
**********************************************************************
  DATA:
    lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
    lv_was_error      TYPE boole_d VALUE abap_false,
    lr_class_key      TYPE REF TO ngcs_class_key.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  " Get updated data from validation data provider
  io_classification->get_updated_data( IMPORTING et_classification_data_upd = DATA(lt_classification_data_upd)
                                                 et_assigned_class_upd      = DATA(lt_assigned_classes_upd) ).

  LOOP AT lt_assigned_classes_upd ASSIGNING FIELD-SYMBOL(<ls_assigned_classes_upd>)
    WHERE object_state = if_ngc_c=>gc_object_state-created
       OR object_state = if_ngc_c=>gc_object_state-updated.

    " Save index if this row. We need this to be able to remove the same row from classification data table, if needed.
    DATA(lv_class_idx) = sy-tabix.

    " Class header is needed to get class status
    DATA(ls_class_header) = <ls_assigned_classes_upd>-class_object->get_header( ).

    " Check only the supplied class type
    IF ls_class_header-classtype <> iv_classtype.
      CONTINUE.
    ENDIF.

    IF ls_class_header-classificationisallowed = abap_false.
      " Fill class key as dynamic field and add to API results
      CREATE DATA lr_class_key.
      ASSIGN lr_class_key->* TO FIELD-SYMBOL(<ls_class_key>).
      <ls_class_key>-classinternalid = <ls_assigned_classes_upd>-classinternalid.

      " Error handling: Class status &1 of class &2 does not allow classification
      MESSAGE e001(ngc_api_base) WITH ls_class_header-classtype ls_class_header-classstatusname ls_class_header-class INTO DATA(lv_msg) ##NEEDED.
      lo_clf_api_result->add_message_from_sy( is_classification_key = io_classification->get_classification_key( )
                                              ir_ref_key            = lr_class_key
                                              iv_ref_type           = 'ngcs_class_key' ).

      " remove data from updated data list or set the object state back
      CASE <ls_assigned_classes_upd>-object_state.
        WHEN if_ngc_c=>gc_object_state-created.
          DELETE lt_assigned_classes_upd INDEX lv_class_idx.
          DELETE lt_classification_data_upd INDEX lv_class_idx.
        WHEN if_ngc_c=>gc_object_state-updated.
          <ls_assigned_classes_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
          READ TABLE lt_classification_data_upd ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>) INDEX lv_class_idx.
          <ls_classification_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
      ENDCASE.

      lv_was_error = abap_true.

      " process next class assignment
      CONTINUE.
    ENDIF.
  ENDLOOP.

  " If there as an error, update the data in the validation data provider
  IF lv_was_error = abap_true.
    io_data_provider->set_updated_data( it_classification_data_upd = lt_classification_data_upd
                                        it_assigned_class_upd      = lt_assigned_classes_upd ).
  ENDIF.

  ro_clf_api_result = lo_clf_api_result.

ENDMETHOD.