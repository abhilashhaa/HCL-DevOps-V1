METHOD if_ngc_clf_validator~validate.

*--------------------------------------------------------------------*
* Checking the authorization for classification
*--------------------------------------------------------------------*

  DATA:
    lo_clf_api_result    TYPE REF TO cl_ngc_clf_api_result,
    lv_has_authorization TYPE boole_d VALUE abap_false,
    lv_was_error         TYPE boole_d VALUE abap_false,
    lr_class_key         TYPE REF TO ngcs_class_key.

  " Get updated data from validation data provider
  io_classification->get_updated_data(
    IMPORTING
      et_classification_data_upd = DATA(lt_classification_data_upd)
      et_assigned_class_upd      = DATA(lt_assigned_classes_upd) ).

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  LOOP AT lt_assigned_classes_upd
    ASSIGNING FIELD-SYMBOL(<ls_assigned_classes_upd>)
    WHERE object_state = if_ngc_c=>gc_object_state-created
       OR object_state = if_ngc_c=>gc_object_state-updated
       OR object_state = if_ngc_c=>gc_object_state-deleted.

    " Save index if this row. We need this to be able to remove the same row from classification data table, if needed.
    DATA(lv_class_idx) = sy-tabix.

    " Class header is needed to get class status
    DATA(ls_class_header) = <ls_assigned_classes_upd>-class_object->get_header( ).

    " Check only the supplied class type
    IF ls_class_header-classtype <> iv_classtype.
      CONTINUE.
    ENDIF.

    lv_has_authorization = auth_check( iv_classclassfctnauthgrp = ls_class_header-classclassfctnauthgrp
                                       iv_object_state          = <ls_assigned_classes_upd>-object_state ).

    IF lv_has_authorization = abap_false.
      " Fill class key as dynamic field and add to API results
      CREATE DATA lr_class_key.
      ASSIGN lr_class_key->* TO FIELD-SYMBOL(<ls_class_key>).
      <ls_class_key>-classinternalid = <ls_assigned_classes_upd>-classinternalid.

      " Error handling: You are not authorized to use class &1 for classification
      MESSAGE e006(ngc_api_base) WITH ls_class_header-class INTO DATA(lv_msg) ##NEEDED.
      lo_clf_api_result->add_message_from_sy(
        is_classification_key = io_classification->get_classification_key( )
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
    io_data_provider->set_updated_data(
      it_classification_data_upd = lt_classification_data_upd
      it_assigned_class_upd      = lt_assigned_classes_upd ).
  ENDIF.

  ro_clf_api_result = lo_clf_api_result.

ENDMETHOD.