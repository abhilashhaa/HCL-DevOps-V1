  METHOD if_ngc_clf_validator~validate.

    DATA:
      lo_clf_api_result     TYPE REF TO cl_ngc_clf_api_result,
      lt_new_valuation_data TYPE ngct_valuation_data_upd,
      ls_interval_merged    TYPE ngcs_valuation_data_upd,
      lv_merged             TYPE abap_bool VALUE abap_false,
      lv_merged_current     TYPE abap_bool VALUE abap_false,
      lt_valuation_grouped  TYPE ngct_valuation_data_upd,
      lv_interval_relation  TYPE c LENGTH 1.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    io_classification->get_updated_data(
      IMPORTING
        et_valuation_data_upd = DATA(lt_valuation_data) ).

    DELETE lt_valuation_data WHERE object_state = if_ngc_c=>gc_object_state-deleted.

    io_classification->get_characteristics(
      IMPORTING
        et_characteristic = DATA(lt_characteristics) ).

    LOOP AT lt_valuation_data INTO DATA(ls_valuation_data)
      GROUP BY ( charcinternalid = ls_valuation_data-charcinternalid )
      REFERENCE INTO DATA(ls_valuation_group).

      CLEAR lt_valuation_grouped.

      " Check if merge is required
      READ TABLE lt_characteristics
        INTO DATA(ls_characteristic)
        WITH KEY
          charcinternalid = ls_valuation_group->charcinternalid.

      IF sy-subrc = 0.
        DATA(ls_char_header) = ls_characteristic-characteristic_object->get_header( ).

        IF ls_char_header-charcdatatype          <> if_ngc_c=>gc_charcdatatype-num OR
           ls_char_header-valueintervalisallowed =  abap_false OR
           ls_char_header-multiplevaluesareallowed = abap_false.
          LOOP AT GROUP ls_valuation_group INTO DATA(ls_valuation_for_char).
            APPEND ls_valuation_for_char TO lt_new_valuation_data.
          ENDLOOP.

          CONTINUE.
        ENDIF.
      ELSE.
        ASSERT 1 = 2.
      ENDIF.

      " Collect not deleted values
      LOOP AT GROUP ls_valuation_group INTO ls_valuation_for_char
        WHERE
          object_state         <> if_ngc_c=>gc_object_state-deleted.
        APPEND ls_valuation_for_char TO lt_valuation_grouped.
      ENDLOOP.

      " Add deleted values to valuation data
      LOOP AT GROUP ls_valuation_group INTO ls_valuation_for_char
        WHERE
          object_state         = if_ngc_c=>gc_object_state-deleted.
        APPEND ls_valuation_for_char TO lt_new_valuation_data.
      ENDLOOP.

      CHECK lt_valuation_grouped IS NOT INITIAL.

      me->conv_sing_to_mult_relations(
        CHANGING
          ct_valuation_data = lt_valuation_grouped ).

      " New code starts here
      DO.
        lv_merged_current = abap_false.

        READ TABLE lt_valuation_grouped
          INTO DATA(ls_assigned_value_1)
          INDEX 1.

        IF sy-subrc IS NOT INITIAL.
          EXIT.
        ENDIF.

        LOOP AT lt_valuation_grouped FROM 2 INTO DATA(ls_assigned_value_2).
          DATA(lv_index) = sy-tabix.

          CALL FUNCTION 'CTCV_COMPARE_INTERVALS'
            EXPORTING
              int1_low           = ls_assigned_value_1-charcfromnumericvalue
              int1_high          = ls_assigned_value_1-charctonumericvalue
              int1_operator      = ls_assigned_value_1-charcvaluedependency
              int2_low           = ls_assigned_value_2-charcfromnumericvalue
              int2_high          = ls_assigned_value_2-charctonumericvalue
              int2_operator      = ls_assigned_value_2-charcvaluedependency
            IMPORTING
              int_merge_operator = ls_interval_merged-charcvaluedependency
              interval_relation  = lv_interval_relation.

          IF ls_interval_merged-charcvaluedependency IS NOT INITIAL.
            IF lv_interval_relation = 3.
              " 1st interval includes 2nd: ( i1 ( i2 ) )

              lv_merged = abap_true.

              DELETE lt_valuation_grouped INDEX lv_index.

              IF ls_assigned_value_2-object_state = if_ngc_c=>gc_object_state-loaded OR
                 ls_assigned_value_2-object_state = if_ngc_c=>gc_object_state-updated.
                ls_assigned_value_2-object_state = if_ngc_c=>gc_object_state-deleted.
                APPEND ls_assigned_value_2 TO lt_new_valuation_data.
              ENDIF.
            ELSEIF lv_interval_relation = 5.
              " 2nd interval includes 1st: ( i2 ( i1 ) )

              lv_merged = abap_true.
              lv_merged_current = abap_true.

              DELETE lt_valuation_grouped INDEX 1.

              IF ls_assigned_value_1-object_state = if_ngc_c=>gc_object_state-loaded OR
                 ls_assigned_value_1-object_state = if_ngc_c=>gc_object_state-updated.
                ls_assigned_value_1-object_state = if_ngc_c=>gc_object_state-deleted.
                APPEND ls_assigned_value_1 TO lt_new_valuation_data.
              ENDIF.

              EXIT.
            ELSEIF lv_interval_relation = 4.
              " Equivalent values
              lv_merged = abap_true.
              lv_merged_current = abap_true.

              DELETE lt_valuation_grouped INDEX lv_index.
            ENDIF.
          ENDIF.
        ENDLOOP.

        IF lv_merged_current = abap_false.
          APPEND ls_assigned_value_1 TO lt_new_valuation_data.
          DELETE lt_valuation_grouped INDEX 1.
        ENDIF.

      ENDDO.
    ENDLOOP.

    me->conv_mult_to_sing_relations(
      CHANGING
        ct_valuation_data = lt_new_valuation_data ).

    IF lv_merged = abap_true.
      io_data_provider->set_updated_data(
        it_assigned_values = lt_new_valuation_data ).

      DATA(ls_classification_key) = io_classification->get_classification_key( ).

      MESSAGE i016(ngc_api_base) INTO DATA(ls_message) ##NEEDED.
      lo_clf_api_result->add_message_from_sy(
        is_classification_key = ls_classification_key ).
    ENDIF.

    ro_clf_api_result = lo_clf_api_result.

  ENDMETHOD.