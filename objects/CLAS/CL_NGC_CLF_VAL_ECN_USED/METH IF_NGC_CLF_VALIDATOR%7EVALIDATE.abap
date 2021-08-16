METHOD if_ngc_clf_validator~validate.

**********************************************************************
* This validation checks if the there is already existing class assignment
* for the object with this classtype and this existing assignment uses a
* change number. If during class assignment no change number is used, and
* there is an already existing assignment with this class type, we should
* not allow class assignment.
*--------------------------------------------------------------------*
* This check is only relevant if change number is not filled
* BUT: Currently we ignore change numbers, but change number remains in the
* classification key! Therefore currently we always need this check.
* (Later on we can put a check so that the validation is run only
* in case the change number is filled.)
**********************************************************************

  DATA:
    lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
    lv_was_error      TYPE boole_d VALUE abap_false,
    lr_class_key      TYPE REF TO ngcs_class_key.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  DATA(ls_classification_key) = io_classification->get_classification_key( ).

* Get updated data from validation data provider
  io_classification->get_updated_data( IMPORTING et_classification_data_upd = DATA(lt_classification_data_upd)
                                                 et_assigned_class_upd      = DATA(lt_assigned_classes_upd) ).

  " Check if class type is available for this technical object
  DATA(ls_classtype) = mo_clf_persistency->read_classtype( iv_clfnobjecttable = ls_classification_key-technical_object
                                                           iv_classtype       = iv_classtype ).
  IF ls_classtype IS INITIAL.
    ro_clf_api_result = lo_clf_api_result.
    " If class type is not available, we return - this case is validated in another validator class
    RETURN.
  ENDIF.

  LOOP AT lt_assigned_classes_upd ASSIGNING FIELD-SYMBOL(<ls_assigned_classes_upd>)
    WHERE object_state = if_ngc_c=>gc_object_state-created
       OR object_state = if_ngc_c=>gc_object_state-updated
       OR object_state = if_ngc_c=>gc_object_state-deleted.

    " Save index if this row. We need this to be able to remove the same row from classification data table, if needed.
    DATA(lv_class_idx) = sy-tabix.

    " Class header is needed to get the class type
    DATA(ls_class_header) = <ls_assigned_classes_upd>-class_object->get_header( ).

    " Check only the supplied class type
    IF ls_class_header-classtype <> iv_classtype.
      CONTINUE.
    ENDIF.

    READ TABLE lt_classification_data_upd ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>)
      WITH KEY classinternalid = <ls_assigned_classes_upd>-classinternalid.

    IF ls_classtype-engchangemgmtisallowed = abap_true AND <ls_classification_data_upd>-changenumber IS NOT INITIAL.
      " Fill class key as dynamic field and add to API results
      CREATE DATA lr_class_key.
      ASSIGN lr_class_key->* TO FIELD-SYMBOL(<ls_class_key>).
      <ls_class_key>-classinternalid = <ls_assigned_classes_upd>-classinternalid.

      " Error handling: Classification data can only be maintained using a change number
      MESSAGE e008(ngc_api_base) INTO DATA(lv_msg) ##NEEDED.
      lo_clf_api_result->add_message_from_sy( is_classification_key = ls_classification_key
                                              ir_ref_key            = lr_class_key
                                              iv_ref_type           = 'ngcs_class_key' ).

      " remove data from updated data list or set the object state back
      CASE <ls_assigned_classes_upd>-object_state.
        WHEN if_ngc_c=>gc_object_state-created.
          DELETE lt_assigned_classes_upd INDEX lv_class_idx.
          DELETE lt_classification_data_upd INDEX lv_class_idx.
        WHEN if_ngc_c=>gc_object_state-updated
          OR if_ngc_c=>gc_object_state-deleted.
          <ls_assigned_classes_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
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