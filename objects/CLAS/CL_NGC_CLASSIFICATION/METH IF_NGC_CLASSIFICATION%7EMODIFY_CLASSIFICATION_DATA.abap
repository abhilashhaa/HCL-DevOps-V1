  METHOD if_ngc_classification~modify_classification_data.

    DATA:
      lo_clf_api_result           TYPE REF TO cl_ngc_clf_api_result,
      lr_class_key                TYPE REF TO ngcs_class_key,
      lv_reg_validation_classtype TYPE klassenart VALUE IS INITIAL.

    FIELD-SYMBOLS:
      <ls_class_key> TYPE ngcs_class_key.

    CLEAR: eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    READ TABLE it_classification_data_mod TRANSPORTING NO FIELDS WITH KEY classinternalid = '0000000000'.
    IF sy-subrc = 0.
      ASSERT 1 = 2.
    ENDIF.

    LOOP AT it_classification_data_mod ASSIGNING FIELD-SYMBOL(<ls_classification_data_mod>).

      CLEAR: lv_reg_validation_classtype.

      READ TABLE mt_classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>)
        WITH TABLE KEY classinternalid = <ls_classification_data_mod>-classinternalid.
      IF sy-subrc <> 0.
        CREATE DATA lr_class_key.
        ASSIGN lr_class_key->* TO <ls_class_key>.

        MOVE-CORRESPONDING <ls_classification_data_mod> TO <ls_class_key>.

        " Class with internal class no. &1 is not assigned
        MESSAGE e029(ngc_api_base) WITH <ls_classification_data_mod>-classinternalid INTO DATA(lv_msg) ##NEEDED.
        lo_clf_api_result->add_message_from_sy(
          is_classification_key = me->ms_classification_key
          ir_ref_key            = lr_class_key
          iv_ref_type           = 'NGCS_CLASS_KEY' ).

        CONTINUE.
      ENDIF.

      CASE <ls_classification_data_upd>-object_state.
        WHEN if_ngc_c=>gc_object_state-created
          OR if_ngc_c=>gc_object_state-updated.
          " don't override status if it is not supplied
          IF <ls_classification_data_mod>-clfnstatus IS NOT INITIAL.
            <ls_classification_data_upd>-clfnstatus = <ls_classification_data_mod>-clfnstatus.
          ENDIF.
          <ls_classification_data_upd>-classpositionnumber = <ls_classification_data_mod>-classpositionnumber.
          lv_reg_validation_classtype = abap_true.
        WHEN if_ngc_c=>gc_object_state-loaded.
          " don't override status if it is not supplied
          IF <ls_classification_data_mod>-clfnstatus IS NOT INITIAL.
            <ls_classification_data_upd>-clfnstatus = <ls_classification_data_mod>-clfnstatus.
          ENDIF.
          <ls_classification_data_upd>-classpositionnumber = <ls_classification_data_mod>-classpositionnumber.
          <ls_classification_data_upd>-object_state = if_ngc_c=>gc_object_state-updated.
          lv_reg_validation_classtype = abap_true.
          " WHEN if_ngc_c=>gc_object_state-deleted. - in this case don't need to do anything
        WHEN OTHERS.
      ENDCASE.

      READ TABLE mt_assigned_class ASSIGNING FIELD-SYMBOL(<ls_assigned_classes_upd>)
        WITH KEY classinternalid = <ls_classification_data_mod>-classinternalid.
      ASSERT sy-subrc = 0.

      CASE <ls_assigned_classes_upd>-object_state.
        WHEN if_ngc_c=>gc_object_state-loaded.
          <ls_assigned_classes_upd>-object_state = if_ngc_c=>gc_object_state-updated.
          lv_reg_validation_classtype = abap_true.
          " WHEN if_ngc_c=>gc_object_state-created.
          " WHEN if_ngc_c=>gc_object_state-updated.
          " WHEN if_ngc_c=>gc_object_state-deleted. - in these cases don't need to do anything
        WHEN OTHERS.
      ENDCASE.

      IF lv_reg_validation_classtype = abap_true.
        DATA(ls_class_header) = <ls_assigned_classes_upd>-class_object->get_header( ).
        register_validation_class_type( ls_class_header-classtype ).
      ENDIF.

    ENDLOOP.

    " Validate class assignment
    me->if_ngc_classification~validate( IMPORTING eo_clf_api_result = DATA(lo_clf_api_result_tmp) ).

    lo_clf_api_result->add_messages_from_api_result( io_clf_api_result = lo_clf_api_result_tmp ).
    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.