  METHOD if_ngc_classification~assign_classes.

    DATA:
      lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
      ls_clf_status     TYPE tclc,
      lr_class_key      TYPE REF TO ngcs_class_key,
      lt_value_change   TYPE ngct_valuation_charcvalue_chg,
      lt_classtype      TYPE ltt_classtype.

    FIELD-SYMBOLS:
      <ls_class_key> TYPE ngcs_class_key.

    CLEAR: eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    " Check: both fields in the input table should be filled
    LOOP AT it_class TRANSPORTING NO FIELDS WHERE classinternalid IS INITIAL
                                               OR class_object    IS NOT BOUND.
      ASSERT 1 = 2.
    ENDLOOP.

    " call BAdI for checking if class assignment is valid
    call_badi_assign_classes(
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
    LOOP AT it_class ASSIGNING FIELD-SYMBOL(<ls_class>).

      DATA(ls_class_header) = <ls_class>-class_object->get_header( ).

      IF NOT line_exists( lt_classtype[ table_line = ls_class_header-classtype ] ).
        APPEND ls_class_header-classtype TO lt_classtype.
      ENDIF.

      READ TABLE mt_assigned_class ASSIGNING FIELD-SYMBOL(<ls_assigned_class_upd>)
        WITH KEY classinternalid = <ls_class>-classinternalid.
      IF sy-subrc = 0.

        " In case the assignment was deleted, we set it back to loaded.
        " In other cases (created, updated, loaded) we don't need to do anything.
        IF <ls_assigned_class_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
          <ls_assigned_class_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
          register_validation_class_type( ls_class_header-classtype ).
        ENDIF.

        READ TABLE mt_classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>)
          WITH TABLE KEY classinternalid = <ls_class>-classinternalid.
        ASSERT sy-subrc = 0.

        " In case it was deleted, we set it to updated.
        " In other cases (created, updated, loaded) we don't need to do anything.
        IF <ls_classification_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
          " Set released status as default
          DATA(lt_clf_statuses) = mo_clf_persistency->read_clf_statuses( ls_class_header-classtype ).
          CLEAR: ls_clf_status.
          READ TABLE lt_clf_statuses INTO ls_clf_status WITH KEY frei = abap_true.
          " These 3 fields are not updated:
*         <ls_classification_data_upd>-classinternalid
*         <ls_classification_data_upd>-class
*         <ls_classification_data_upd>-classtype
          <ls_classification_data_upd>-clfnstatus            = ls_clf_status-statu.
          <ls_classification_data_upd>-clfnstatusdescription = mo_clf_persistency->read_clf_status_description(
                                                                 iv_classtype  = ls_class_header-classtype
                                                                 iv_clfnstatus = ls_clf_status-statu ).
          <ls_classification_data_upd>-classpositionnumber   = if_ngc_c=>gc_positionnumber_default.
          " These 2 fields are not updated:
*         <ls_classification_data_upd>-classisstandardclass
*         <ls_classification_data_upd>-changenumber
          <ls_classification_data_upd>-object_state          = if_ngc_c=>gc_object_state-updated.

          " Register class type for validation
          register_validation_class_type( ls_class_header-classtype ).

          " recalculate domain values because new assignment can change the intersection
          mo_clf_util_intersect->recalculate( ls_class_header-classtype ).

          " fill successfully assigned class table
        ELSE.
          CREATE DATA lr_class_key.
          ASSIGN lr_class_key->* TO <ls_class_key>.

          MOVE-CORRESPONDING <ls_class> TO <ls_class_key>.

          " Class type &: Classification & already exists
          MESSAGE e021(ngc_api_base) WITH ls_class_header-classtype ls_class_header-class INTO DATA(lv_msg) ##NEEDED.
          lo_clf_api_result->add_message_from_sy(
            is_classification_key = me->ms_classification_key
            ir_ref_key            = lr_class_key
            iv_ref_type           = 'ngcs_class_key' ).

          CONTINUE.
        ENDIF.

      ELSE.

        " Add to updated classes
        APPEND VALUE
          ngcs_class_object_upd( classinternalid = <ls_class>-classinternalid
                                 key_date        = <ls_class>-key_date
                                 class_object    = <ls_class>-class_object
                                 object_state    = if_ngc_c=>gc_object_state-created )
          TO mt_assigned_class.

        " Register class type for validation
        register_validation_class_type( ls_class_header-classtype ).

        " recalculate domain values because new assignment can change the intersection
        mo_clf_util_intersect->recalculate( ls_class_header-classtype ).

        " Set released status as default
        lt_clf_statuses = mo_clf_persistency->read_clf_statuses( ls_class_header-classtype ).
        CLEAR: ls_clf_status.
        READ TABLE lt_clf_statuses INTO ls_clf_status WITH KEY frei = abap_true.

        " Add new entry to the updated classification data
        INSERT VALUE
          ngcs_classification_data_upd( classinternalid       = <ls_class>-classinternalid
                                        class                 = ls_class_header-class
                                        classtype             = ls_class_header-classtype
                                        clfnstatus            = ls_clf_status-statu
                                        clfnstatusdescription = mo_clf_persistency->read_clf_status_description(
                                                                  iv_classtype  = ls_class_header-classtype
                                                                  iv_clfnstatus = ls_clf_status-statu )
                                        " The following 3 fields are left empty:
*                                       classpositionnumber
*                                       classisstandardclass
*                                       changenumber
                                        object_state          = if_ngc_c=>gc_object_state-created )
          INTO TABLE mt_classification_data.

        " create valuation for reference characteristic
        set_reference_charc_valuation( <ls_class> ).
      ENDIF.

      " Handle default value assignment
      <ls_class>-class_object->get_characteristics(
        IMPORTING
          et_characteristic = DATA(lt_characteristic) ).

      me->if_ngc_classification~get_assigned_values(
        EXPORTING
          iv_classtype      = ls_class_header-classtype
        IMPORTING
          et_valuation_data = DATA(lt_valuation_data) ).

      LOOP AT lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
        " Check if characteristic doesn't have an assignment yet
        CHECK NOT line_exists( lt_valuation_data[ charcinternalid = <ls_characteristic>-charcinternalid ] ).

        DATA(ls_charc_header) = <ls_characteristic>-characteristic_object->get_header( ).

        IF ls_charc_header-charccheckfunctionmodule IS NOT INITIAL OR
           ls_charc_header-charcchecktable IS NOT INITIAL.
          CONTINUE.
        ENDIF.

        DATA(lt_domain_value) = <ls_characteristic>-characteristic_object->get_domain_values( ).

        LOOP AT lt_domain_value ASSIGNING FIELD-SYMBOL(<ls_domain_value>)
          WHERE isdefaultvalue = abap_true.

          APPEND VALUE #( charcinternalid = <ls_characteristic>-charcinternalid
                          classtype       = ls_class_header-classtype
                          charcvaluenew   = <ls_domain_value>-charcvalue
          ) TO lt_value_change.

          IF ls_charc_header-multiplevaluesareallowed = abap_false.
            EXIT.
          ENDIF.
        ENDLOOP.
      ENDLOOP.

      me->if_ngc_classification~change_values(
        EXPORTING
          it_change_value = lt_value_change
        IMPORTING
          eo_clf_api_result = lo_clf_api_result_tmp ).

      lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

      CLEAR lt_value_change.

    ENDLOOP.

    " Validate class assignment
    me->if_ngc_classification~validate( IMPORTING eo_clf_api_result = lo_clf_api_result_tmp ).
    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    me->if_ngc_classification~refresh_clf_status(
      IMPORTING
        eo_clf_api_result = lo_clf_api_result_tmp ).
    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    " handle node leaf information for assigned classes
    handle_classtypes_node_leaf( IMPORTING eo_clf_api_result = lo_clf_api_result_tmp ).
    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    lo_clf_api_result_tmp = me->lock_class_type( lt_classtype ).
    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.