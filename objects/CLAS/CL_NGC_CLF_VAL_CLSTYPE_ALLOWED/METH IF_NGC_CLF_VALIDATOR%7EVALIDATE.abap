METHOD if_ngc_clf_validator~validate.

**********************************************************************
* This validation checks if the class type of the assigned class is available
* for the object type (object table) in the class type customizing.
* Only class assignments (creations) are checked, because it does not
* make sense to check this for deletions and updates.
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
    WHERE object_state = if_ngc_c=>gc_object_state-created.

    " Save index if this row. We need this to be able to remove the same row from classification data table, if needed.
    DATA(lv_class_idx) = sy-tabix.

    " Class header is needed to get the class type
    DATA(ls_class_header) = <ls_assigned_classes_upd>-class_object->get_header( ).

    " Check only the supplied class type
    IF ls_class_header-classtype <> iv_classtype.
      CONTINUE.
    ENDIF.

    " Classification key is needed to get the technical object
    DATA(ls_classification_key) = io_classification->get_classification_key( ).

    " Check if class type is available for this technical object
    DATA(ls_classtype) = mo_clf_persistency->read_classtype( iv_clfnobjecttable = ls_classification_key-technical_object
                                                             iv_classtype       = ls_class_header-classtype ).

    IF ls_classtype IS INITIAL.
      " Fill class key as dynamic field and add to API results
      CREATE DATA lr_class_key.
      ASSIGN lr_class_key->* TO FIELD-SYMBOL(<ls_class_key>).
      <ls_class_key>-classinternalid = <ls_assigned_classes_upd>-classinternalid.

      " Error handling: Classification of object &1 not supported with class type &2
      MESSAGE e000(ngc_api_base) WITH ls_classification_key-technical_object ls_class_header-classtype INTO DATA(lv_msg) ##NEEDED.
      lo_clf_api_result->add_message_from_sy( is_classification_key = ls_classification_key
                                              ir_ref_key            = lr_class_key
                                              iv_ref_type           = 'ngcs_class_key' ).

      " remove data from updated data list
      DELETE lt_assigned_classes_upd INDEX lv_class_idx.
      DELETE lt_classification_data_upd INDEX lv_class_idx.
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