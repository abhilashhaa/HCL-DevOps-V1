  METHOD delete_characteristic_value.

    DATA:
      lo_clf_api_result       TYPE REF TO cl_ngc_clf_api_result,
      lt_valuation_data       TYPE ngct_valuation_data,
      lt_valuation_data_in    TYPE ngct_valuation_data,
      lt_change_value_atwrt   TYPE ngct_valuation_charcvalue_chg,
      lt_change_value_atwrt_i TYPE ngct_valuation_charcvalue_chgi,
      ls_core_charc_header    TYPE ngcs_core_charc,
      ls_charc_value          TYPE ngcs_core_charc_value,
      lv_index                TYPE syst_tabix,
      lt_classtype            TYPE ltt_classtype.

    CLEAR: eo_clf_api_result, et_success_value.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    " get characteristics assigned to the object
    me->if_ngc_classification~get_characteristics(
      IMPORTING
        et_characteristic = DATA(lt_assigned_characteristic)
        eo_clf_api_result = DATA(lo_clf_api_result_tmp) ).

    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    " 1. Convert IT_CHANGE_VALUE --> lt_valuation_data_in
    MOVE-CORRESPONDING it_change_value TO lt_valuation_data_in.

    LOOP AT lt_valuation_data_in ASSIGNING FIELD-SYMBOL(<ls_valuation_data_in>).
      IF NOT line_exists( lt_classtype[ table_line = <ls_valuation_data_in>-classtype ] ).
        APPEND <ls_valuation_data_in>-classtype TO lt_classtype.
      ENDIF.

      fill_valuation_data(
        EXPORTING
          iv_charc_type     = iv_charc_type
        CHANGING
          cs_valuation_data = <ls_valuation_data_in>
      ).

      READ TABLE lt_assigned_characteristic ASSIGNING FIELD-SYMBOL(<ls_assigned_characteristic>)
        WITH KEY classtype       = <ls_valuation_data_in>-classtype
                 charcinternalid = <ls_valuation_data_in>-charcinternalid
                 key_date        = me->ms_classification_key-key_date.
      IF sy-subrc <> 0.
        " Error: Characteristic & not found or not valid
        " (Similar to C1/003)
        MESSAGE e010(ngc_api_base) WITH <ls_valuation_data_in>-charcinternalid INTO DATA(lv_msg) ##NEEDED.
        lo_clf_api_result->add_message_from_sy( me->ms_classification_key ).
        CONTINUE.
      ENDIF.

      DATA(ls_charc_header) = <ls_assigned_characteristic>-characteristic_object->get_header( ).

      CLEAR: ls_core_charc_header.
      MOVE-CORRESPONDING ls_charc_header TO ls_core_charc_header.

      TRY.
          " get instance via factory
          DATA(lo_value_check) = cl_ngc_core_chr_check_factory=>get_instance( iv_charc_type ).
          CLEAR: ls_charc_value.
          MOVE-CORRESPONDING <ls_valuation_data_in> TO ls_charc_value.
          lo_value_check->check_value(
            EXPORTING
              is_charc_header   = ls_core_charc_header
            IMPORTING
              et_message        = DATA(lt_core_chr_message)
            CHANGING
              cs_charc_value    = ls_charc_value
          ).
          MOVE-CORRESPONDING ls_charc_value TO <ls_valuation_data_in>.
          cl_ngc_util_message=>convert_msg_corechr_to_coreclf(
            EXPORTING
              is_classification_key      = me->ms_classification_key
              it_core_charc_msg          = lt_core_chr_message
            IMPORTING
              et_core_classification_msg = DATA(lt_core_clf_message)
          ).
          lo_clf_api_result->add_messages_from_core_clf( lt_core_clf_message ).
          IF lo_clf_api_result->if_ngc_clf_api_result~has_error_or_worse( ) = abap_false.
            APPEND <ls_valuation_data_in> TO lt_valuation_data.
          ENDIF.
        CATCH cx_ngc_core_chr_exception.
          " TODO - give back some kind of error
          CONTINUE.
      ENDTRY.
    ENDLOOP.

    IF lines( lt_valuation_data ) = 0.
      eo_clf_api_result = lo_clf_api_result.
      RETURN.
    ENDIF.

    " 2. Convert from NGCT_VALUATION_DATA to NGCT_VALUATION_CHARCVALUE_CHG
    LOOP AT lt_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data>).
      lv_index = sy-tabix.
      APPEND VALUE #( classtype            = <ls_valuation_data>-classtype
                      charcinternalid      = <ls_valuation_data>-charcinternalid
                      charcvalueold        = <ls_valuation_data>-charcvalue
*                   charcvaluenew        = should be initial!
                      valuation_data_index = lv_index ) TO lt_change_value_atwrt_i.
      APPEND VALUE #( classtype            = <ls_valuation_data>-classtype
                      charcinternalid      = <ls_valuation_data>-charcinternalid
                      charcvalueold        = <ls_valuation_data>-charcvalue
*                   charcvaluenew        = should be initial!
                    ) TO lt_change_value_atwrt.
    ENDLOOP.

    " 3. Call BAdI:
    " call BAdI for checking if class assignment is valid
    call_badi_change_values(
      EXPORTING
        it_change_value   = lt_change_value_atwrt
      IMPORTING
        ev_allowed        = DATA(lv_allowed)
        eo_clf_api_result = lo_clf_api_result_tmp
    ).

    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    IF lv_allowed = abap_false.
      eo_clf_api_result = lo_clf_api_result.
      RETURN.
    ENDIF.

    "4. check input - own validations
    " In the changing table only the successful entries remain
    check_change_values(
      IMPORTING
        et_success_index  = DATA(lt_success_index)
        eo_clf_api_result = lo_clf_api_result_tmp
      CHANGING
        ct_change_value_i = lt_change_value_atwrt_i
    ).

    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    " 5. update buffers

    " 5.1. save buffer
    mt_valuation_data_h_prev = mt_valuation_data_h.

    LOOP AT lt_change_value_atwrt_i ASSIGNING FIELD-SYMBOL(<ls_change_value_atwrt_i>).

      lv_index = sy-tabix.
      READ TABLE lt_success_index INTO DATA(lv_success_index) INDEX lv_index.
      ASSERT sy-subrc = 0.

      " fill et_change_value table with successfully processed inputs
      READ TABLE it_change_value ASSIGNING FIELD-SYMBOL(<ls_change_value_in>) INDEX lv_success_index.
      ASSERT sy-subrc = 0.
      APPEND <ls_change_value_in> TO et_success_value.

      READ TABLE lt_assigned_characteristic ASSIGNING <ls_assigned_characteristic>
        WITH KEY classtype       = <ls_change_value_atwrt_i>-classtype
                 charcinternalid = <ls_change_value_atwrt_i>-charcinternalid
                 key_date        = me->ms_classification_key-key_date.

      " this was checked earlier
      ASSERT sy-subrc = 0.

      ls_charc_header = <ls_assigned_characteristic>-characteristic_object->get_header( ).

      register_validation_class_type( <ls_change_value_atwrt_i>-classtype ).

      READ TABLE lt_valuation_data ASSIGNING FIELD-SYMBOL(<ls_new_valuation_data>)
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