  METHOD if_ngc_classification~change_values.

    DATA:
      lo_clf_api_result       TYPE REF TO cl_ngc_clf_api_result,
      lt_valuation_data_all   TYPE ngct_valuation_data,
      lt_change_value_atwrt_i TYPE ngct_valuation_charcvalue_chgi,
      lt_input_table_index    TYPE int4_table,
      lv_input_table_index    TYPE syst_tabix,
      lv_index                TYPE syst_tabix,
      lt_classtype            TYPE ltt_classtype.

    CLEAR: eo_clf_api_result, et_change_value.

    et_change_value = it_change_value.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    " call BAdI for checking if class assignment is valid
    call_badi_change_values(
      EXPORTING
        it_change_value   = it_change_value
      IMPORTING
        ev_allowed        = DATA(lv_allowed)
        eo_clf_api_result = DATA(lo_clf_api_result_tmp)
    ).
    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).
    IF lv_allowed = abap_false OR lo_clf_api_result->if_ngc_clf_api_result~has_error_or_worse( ).
      eo_clf_api_result = lo_clf_api_result.
      RETURN.
    ENDIF.

    " check syntax with CTCV_SYNTAX_CHECK
    LOOP AT it_change_value ASSIGNING FIELD-SYMBOL(<ls_change_value>).

      IF NOT line_exists( it_change_value[ table_line = <ls_change_value>-classtype ] ).
        APPEND <ls_change_value>-classtype TO lt_classtype.
      ENDIF.

      " save input table index, to be able to bind the data
      " coming from check_syntax_and_convert to the input data
      lv_input_table_index = sy-tabix.

      " check if charc is assigned
      me->if_ngc_classification~get_characteristics(
        IMPORTING
          et_characteristic = DATA(lt_assigned_characteristic)
          eo_clf_api_result = lo_clf_api_result_tmp ).

      lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

      READ TABLE lt_assigned_characteristic ASSIGNING FIELD-SYMBOL(<ls_assigned_characteristic>)
        WITH KEY classtype       = <ls_change_value>-classtype
                 charcinternalid = <ls_change_value>-charcinternalid
                 key_date        = me->ms_classification_key-key_date.
      IF sy-subrc <> 0.
        " Error: Characteristic & not found or not valid
        " (Similar to C1/003)
        MESSAGE e010(ngc_api_base) WITH <ls_change_value>-charcinternalid INTO DATA(lv_msg) ##NEEDED.
        lo_clf_api_result->add_message_from_sy(
          is_classification_key = me->ms_classification_key ).
        CONTINUE.
      ENDIF.

      DATA(ls_charc_header) = <ls_assigned_characteristic>-characteristic_object->get_header( ).

      IF <ls_change_value>-charcvaluenew CA ';' AND
        ls_charc_header-multiplevaluesareallowed = abap_true.
        " Check if string is not in '.
        DATA(lv_value_last_char_idx) = strlen( <ls_change_value>-charcvaluenew ) - 1.
        IF <ls_change_value>-charcvaluenew(1) <> '''' OR
           <ls_change_value>-charcvaluenew+lv_value_last_char_idx(1) <> ''''.
          " issue error message: Using ; is not allowed for "&"
          MESSAGE e023(ngc_api_base) WITH ls_charc_header-characteristic INTO lv_msg ##NEEDED.
          lo_clf_api_result->add_message_from_sy( me->ms_classification_key ).
          CONTINUE.
        ENDIF.
      ENDIF.

      me->check_syntax_and_convert(
        EXPORTING
          is_value_change   = <ls_change_value>
          is_charc_header   = ls_charc_header
        IMPORTING
          et_valuation_data = DATA(lt_valuation_data)
          eo_clf_api_result = lo_clf_api_result_tmp
      ).

      lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

      IF lt_valuation_data IS NOT INITIAL.
        APPEND lv_input_table_index TO lt_input_table_index.
        APPEND LINES OF lt_valuation_data TO lt_valuation_data_all.
      ENDIF.

    ENDLOOP.

    IF lines( lt_valuation_data_all ) = 0.
      eo_clf_api_result = lo_clf_api_result.
      RETURN.
    ENDIF.

**********************************************************************
* In LT_CHANGE_VALUE_ATWRT_I:
*   - OLD_VALUE should be filled if IT_CHANGE_VALUE-old_value is filled
*   - NEW_VALUE should be filled if IT_CHANGE_VALUE-new_value is filled
*
* OLD_VALUE and NEW_VALUE are available in IT_CHANGE_VALUE
**********************************************************************

    " 2. Convert from NGCT_VALUATION_DATA to NGCT_VALUATION_CHARCVALUE_CHG
    LOOP AT lt_valuation_data_all ASSIGNING FIELD-SYMBOL(<ls_valuation_data>).
      lv_index = sy-tabix.

      READ TABLE lt_input_table_index INTO lv_input_table_index INDEX lv_index.
      ASSERT sy-subrc = 0.

      READ TABLE it_change_value ASSIGNING <ls_change_value> INDEX lv_input_table_index.
      ASSERT sy-subrc = 0.

      APPEND VALUE #( classtype            = <ls_valuation_data>-classtype
                      charcinternalid      = <ls_valuation_data>-charcinternalid
                      charcvalueold        = <ls_change_value>-charcvalueold
                      charcvaluenew        = <ls_valuation_data>-charcvalue
                      valuation_data_index = lv_index ) TO lt_change_value_atwrt_i.
    ENDLOOP.

    "4. check input - own validations
    " In the changing table only the successful entries remain
    check_change_values(
      IMPORTING
*     et_success_index  =
        eo_clf_api_result = lo_clf_api_result_tmp
      CHANGING
        ct_change_value_i = lt_change_value_atwrt_i
    ).

    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    " save buffer
    mt_valuation_data_h_prev = mt_valuation_data_h.

    LOOP AT lt_change_value_atwrt_i ASSIGNING FIELD-SYMBOL(<ls_change_value_atwrt_i>).

      lv_index = sy-tabix.

      et_change_value[ lv_index ]-charcvaluenew = lt_valuation_data_all[ <ls_change_value_atwrt_i>-valuation_data_index ]-charcvalue.

      READ TABLE lt_assigned_characteristic ASSIGNING <ls_assigned_characteristic>
        WITH KEY classtype       = <ls_change_value_atwrt_i>-classtype
                 charcinternalid = <ls_change_value_atwrt_i>-charcinternalid
                 key_date        = me->ms_classification_key-key_date.

      " this was checked earlier
      ASSERT sy-subrc = 0.

      ls_charc_header = <ls_assigned_characteristic>-characteristic_object->get_header( ).

      register_validation_class_type( <ls_change_value_atwrt_i>-classtype ).

      READ TABLE lt_valuation_data_all ASSIGNING FIELD-SYMBOL(<ls_new_valuation_data>)
        INDEX <ls_change_value_atwrt_i>-valuation_data_index.
      ASSERT sy-subrc = 0.

      update_valuation_data_buffer(
        EXPORTING
          is_change_value_atwrt_i = <ls_change_value_atwrt_i>
          is_charc_header         = ls_charc_header
        CHANGING
          cs_new_valuation_data   = <ls_new_valuation_data> ).

    ENDLOOP.

    SORT mt_valuation_data ASCENDING BY clfnobjectid classtype charcinternalid charcvaluepositionnumber timeintervalnumber.

    " Validate class assignment
    me->if_ngc_classification~validate( IMPORTING eo_clf_api_result = lo_clf_api_result_tmp ).

    " cleanup previous valuation data
    CLEAR: mt_valuation_data_h_prev.

    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    " If there was no error after validation, calculate the additional fields of valuation data
    IF lo_clf_api_result->if_ngc_clf_api_result~has_error_or_worse( ) = abap_false.
      calculate_valuation_extension( ).
    ENDIF.

    mo_clf_status->refresh_status(
      EXPORTING
        io_classification = me
      IMPORTING
        eo_clf_api_result = lo_clf_api_result_tmp ).

    me->refresh_classtype_statuses( ).

    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    lo_clf_api_result_tmp = me->lock_class_type( lt_classtype ).
    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.