  METHOD if_ngc_classification~remove_classes.

    DATA:
      lo_clf_api_result  TYPE REF TO cl_ngc_clf_api_result,
      lt_charcinternalid TYPE SORTED TABLE OF atinn WITH UNIQUE DEFAULT KEY,
      lr_class_key       TYPE REF TO ngcs_class_key,
      lt_classtype       TYPE ltt_classtype.

    CLEAR: eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    " Check: both fields in the input table should be filled
    LOOP AT it_class ASSIGNING FIELD-SYMBOL(<ls_class>) WHERE classinternalid IS INITIAL
                                                             OR class_object    IS NOT BOUND.
      ASSERT 1 = 2.
    ENDLOOP.

    " call BAdI for checking if class assignment is valid
    call_badi_remove_classes(
      EXPORTING
        it_class          = it_class
      IMPORTING
        ev_allowed        = DATA(lv_allowed)
        eo_clf_api_result = DATA(lo_clf_api_result_tmp)
    ).
    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).
    IF lv_allowed = abap_false OR lo_clf_api_result->if_ngc_clf_api_result~has_error_or_worse( ).
      eo_clf_api_result = lo_clf_api_result.
      RETURN.
    ENDIF.

    " Process input
    LOOP AT it_class ASSIGNING <ls_class>.

      READ TABLE mt_assigned_class ASSIGNING FIELD-SYMBOL(<ls_assigned_class_upd>)
        WITH KEY classinternalid = <ls_class>-classinternalid.

      IF sy-subrc <> 0.
        " Error: Class &1 of class type &2 not found or not valid
        DATA(ls_class_header) = <ls_class>-class_object->get_header( ).

        CREATE DATA lr_class_key.
        ASSIGN lr_class_key->* TO FIELD-SYMBOL(<ls_class_key>).
        <ls_class_key>-classinternalid = <ls_class>-classinternalid.

        MESSAGE e024(ngc_api_base) WITH <ls_class>-classinternalid ls_class_header-classtype INTO DATA(lv_msg) ##NEEDED.
        lo_clf_api_result->add_message_from_sy(
          is_classification_key = me->ms_classification_key
          ir_ref_key            = lr_class_key
          iv_ref_type           = 'ngcs_class_key' ).

        CONTINUE.
      ENDIF.

      DATA(lv_index) = sy-tabix.

      " Save the original object state of class assignment (before deletion of the class assignment)
      DATA(lv_state) = <ls_assigned_class_upd>-object_state.

      ls_class_header = <ls_class>-class_object->get_header( ).

      IF NOT line_exists( lt_classtype[ table_line = ls_class_header-classtype ] ).
        APPEND ls_class_header-classtype TO lt_classtype.
      ENDIF.

      <ls_class>-class_object->get_characteristics(
        IMPORTING
          et_characteristic = DATA(lt_characteristic)
      ).

      CASE lv_state.
        WHEN if_ngc_c=>gc_object_state-created.
          DELETE mt_assigned_class INDEX lv_index.
        WHEN if_ngc_c=>gc_object_state-updated
          OR if_ngc_c=>gc_object_state-loaded.
          <ls_assigned_class_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
          register_validation_class_type( ls_class_header-classtype ).
          mo_clf_util_intersect->recalculate( ls_class_header-classtype ).
          " WHEN if_ngc_c=>gc_object_state-deleted. in this case don't need to do anything
        WHEN OTHERS.
      ENDCASE.

      " adjust valuation of the assigned characteristic: delete or set state deleted
      IF lv_state NE if_ngc_c=>gc_object_state-deleted. " for states L/C/U
        LOOP AT mt_assigned_class ASSIGNING FIELD-SYMBOL(<ls_assigned_classes>)
        WHERE object_state <> if_ngc_c=>gc_object_state-deleted.
          DATA(ls_class_header_all) = <ls_assigned_classes>-class_object->get_header( ).
          IF ls_class_header_all-classtype <> ls_class_header-classtype.
            CONTINUE.
          ENDIF.
          " collect all assigned characteristic of the current class type
          <ls_assigned_classes>-class_object->get_characteristics(
            IMPORTING
              et_characteristic = DATA(lt_class_characteristic) ).
          LOOP AT lt_class_characteristic ASSIGNING FIELD-SYMBOL(<ls_class_characteristic>).
            " lt_charcinternalid will contain those characteristics which are left after the removal of this class
            INSERT <ls_class_characteristic>-charcinternalid INTO TABLE lt_charcinternalid.
          ENDLOOP.
        ENDLOOP.

        LOOP AT lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
          READ TABLE lt_charcinternalid TRANSPORTING NO FIELDS
          WITH KEY table_line = <ls_characteristic>-charcinternalid.
          IF sy-subrc <> 0.
            IF mv_valuation_hash_table IS NOT INITIAL.
              LOOP AT mt_valuation_data_h ASSIGNING FIELD-SYMBOL(<ls_valuation_data>)
                WHERE
                  charcinternalid = <ls_characteristic>-charcinternalid AND
                  classtype       = ls_class_header-classtype.
                " with status created: delete form table
                IF <ls_valuation_data>-object_state EQ if_ngc_c=>gc_object_state-created.
                  DELETE TABLE mt_valuation_data_h WITH TABLE KEY clfnobjectid = <ls_valuation_data>-clfnobjectid
                                                                  charcinternalid = <ls_valuation_data>-charcinternalid
                                                                  charcvaluepositionnumber = <ls_valuation_data>-charcvaluepositionnumber
                                                                  classtype                = <ls_valuation_data>-classtype
                                                                  timeintervalnumber       = <ls_valuation_data>-timeintervalnumber.
                ELSEIF <ls_valuation_data>-object_state <> if_ngc_c=>gc_object_state-deleted.
                  " with status loaded/updated: set state for deleted
                  <ls_valuation_data>-object_state = if_ngc_c=>gc_object_state-deleted.
                ENDIF.
              ENDLOOP.
            ELSE.
              LOOP AT mt_valuation_data ASSIGNING <ls_valuation_data>
                WHERE
                  charcinternalid = <ls_characteristic>-charcinternalid AND
                  classtype       = ls_class_header-classtype.
                " with status created: delete form table
                IF <ls_valuation_data>-object_state EQ if_ngc_c=>gc_object_state-created.
                  DELETE mt_valuation_data.
                ELSEIF <ls_valuation_data>-object_state <> if_ngc_c=>gc_object_state-deleted.
                  " with status loaded/updated: set state for deleted
                  <ls_valuation_data>-object_state = if_ngc_c=>gc_object_state-deleted.
                ENDIF.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDLOOP.
        " Initialize lt_charcinternalid for the next loop
        CLEAR: lt_charcinternalid.
      ENDIF.

      READ TABLE mt_classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>)
        WITH TABLE KEY classinternalid = <ls_class>-classinternalid.
      ASSERT sy-subrc = 0.
      lv_index = sy-tabix.

      CASE <ls_classification_data_upd>-object_state.
        WHEN if_ngc_c=>gc_object_state-created.
          DELETE mt_classification_data WHERE classinternalid = <ls_class>-classinternalid.
        WHEN if_ngc_c=>gc_object_state-updated
          OR if_ngc_c=>gc_object_state-loaded.
          <ls_classification_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
          register_validation_class_type( ls_class_header-classtype ).
          mo_clf_util_intersect->recalculate( ls_class_header-classtype ).
          " WHEN if_ngc_c=>gc_object_state-deleted. in this case don't need to do anything
        WHEN OTHERS.
      ENDCASE.

    ENDLOOP.

    " Validate class assignment
    me->if_ngc_classification~validate( IMPORTING eo_clf_api_result = lo_clf_api_result_tmp ).
    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    me->if_ngc_classification~refresh_clf_status(
      IMPORTING
        eo_clf_api_result = lo_clf_api_result_tmp ).

    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    lo_clf_api_result_tmp = me->lock_class_type( lt_classtype ).
    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.