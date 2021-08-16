METHOD if_ngc_clf_validator~validate.

**********************************************************************
* Change number checks
* 1. ECN should exist
* 2. ECN object type check
* 3. ECN specified but ECN cannot be used for class type
**********************************************************************

  DATA:
    lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
    lv_was_error      TYPE boole_d VALUE abap_false,
    lr_class_key      TYPE REF TO ngcs_class_key.

  ro_clf_api_result = NEW cl_ngc_clf_api_result( ).

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  DATA(ls_classification_key) = io_classification->get_classification_key( ).

* These checks are only relevant if change number is filled
  IF ls_classification_key-change_number IS INITIAL.
    ro_clf_api_result = lo_clf_api_result.
    RETURN.
  ENDIF.

* Get updated data from validation data provider
  io_classification->get_updated_data( IMPORTING et_classification_data_upd = DATA(lt_classification_data_upd)
                                                 et_assigned_class_upd      = DATA(lt_assigned_classes_upd) ).

* ECN existence check
  mo_ecn_bo->get_ecn(
    EXPORTING
      iv_change_no = ls_classification_key-change_number
    IMPORTING
      es_ecn       = DATA(ls_ecn)
      et_message   = DATA(lt_spi_msg)
      ev_severity  = DATA(lv_spi_msg_severity)
  ).
  IF lv_spi_msg_severity CA if_ngc_c=>gc_msg_severity_category-error_or_worse.
    " Error handling -> ECN does not exist.
    lo_clf_api_result->add_messages_from_spi( is_classification_key = ls_classification_key
                                              it_spi_msg            = lt_spi_msg ).
    ro_clf_api_result = lo_clf_api_result.
    RETURN.
  ENDIF.

* ECN object type check
  READ TABLE ls_ecn-obj_type TRANSPORTING NO FIELDS
    WITH KEY obj_cat = if_ngc_c=>gc_obj_clf_ecn_obj_type
             active  = abap_true.
  IF sy-subrc <> 0.
*   Error handling: Change number &1 does not support classification
    MESSAGE e002(ngc_api_base) WITH ls_classification_key-change_number INTO DATA(lv_msg).
    lo_clf_api_result->add_message_from_sy( is_classification_key = ls_classification_key ).
    ro_clf_api_result = lo_clf_api_result.
    RETURN.
  ENDIF.

  " Check if class type is available for this technical object
  DATA(ls_classtype) = mo_clf_persistency->read_classtype( iv_clfnobjecttable = ls_classification_key-technical_object
                                                           iv_classtype       = iv_classtype ).
  IF ls_classtype IS INITIAL.
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

    IF ls_classtype-engchangemgmtisallowed = abap_false.
      " Fill class key as dynamic field and add to API results
      CREATE DATA lr_class_key.
      ASSIGN lr_class_key->* TO FIELD-SYMBOL(<ls_class_key>).
      <ls_class_key>-classinternalid = <ls_assigned_classes_upd>-classinternalid.

      " Error handling: Class type &1 does not support using of change number
      MESSAGE e003(ngc_api_base) WITH ls_class_header-classtype INTO lv_msg.
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