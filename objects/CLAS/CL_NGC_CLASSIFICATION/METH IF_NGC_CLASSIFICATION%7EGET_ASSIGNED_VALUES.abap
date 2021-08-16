  METHOD if_ngc_classification~get_assigned_values.

    DATA:
      lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result.

    CLEAR: et_valuation_data, eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    IF iv_classtype IS NOT INITIAL.
      IF mv_valuation_hash_table IS NOT INITIAL.
        LOOP AT mt_valuation_data_h ASSIGNING FIELD-SYMBOL(<ls_valuation_data_upd>)
        WHERE object_state <> if_ngc_c=>gc_object_state-deleted
          AND classtype    =  iv_classtype.

          APPEND INITIAL LINE TO et_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data_exp>).
          MOVE-CORRESPONDING <ls_valuation_data_upd> TO <ls_valuation_data_exp>.

          IF <ls_valuation_data_upd>-charcvalue IS INITIAL.
            build_string_assigned_values(
              EXPORTING
                is_valuation_data = <ls_valuation_data_upd>
              IMPORTING
                ev_charcvalue     = DATA(lv_charcvalue)
                et_core_message   = DATA(lt_core_message)
            ).
            <ls_valuation_data_upd>-charcvalue = lv_charcvalue.
          ENDIF.

          lo_clf_api_result->add_messages_from_core(
            is_classification_key = ms_classification_key
            it_core_message       = lt_core_message ).

        ENDLOOP.
      ELSE.
        LOOP AT mt_valuation_data ASSIGNING <ls_valuation_data_upd>
          WHERE object_state <> if_ngc_c=>gc_object_state-deleted
            AND classtype    =  iv_classtype.

          APPEND INITIAL LINE TO et_valuation_data ASSIGNING <ls_valuation_data_exp>.
          MOVE-CORRESPONDING <ls_valuation_data_upd> TO <ls_valuation_data_exp>.

          IF <ls_valuation_data_upd>-charcvalue IS INITIAL.
            build_string_assigned_values(
              EXPORTING
                is_valuation_data = <ls_valuation_data_upd>
              IMPORTING
                ev_charcvalue     = lv_charcvalue
                et_core_message   = lt_core_message
            ).
            <ls_valuation_data_upd>-charcvalue = lv_charcvalue.
          ENDIF.

          lo_clf_api_result->add_messages_from_core(
            is_classification_key = ms_classification_key
            it_core_message       = lt_core_message ).

        ENDLOOP.
      ENDIF.
    ELSE.
      IF mv_valuation_hash_table IS NOT INITIAL.
        LOOP AT mt_valuation_data_h ASSIGNING <ls_valuation_data_upd>
         WHERE object_state <> if_ngc_c=>gc_object_state-deleted.

          APPEND INITIAL LINE TO et_valuation_data ASSIGNING <ls_valuation_data_exp>.
          MOVE-CORRESPONDING <ls_valuation_data_upd> TO <ls_valuation_data_exp>.

          IF <ls_valuation_data_upd>-charcvalue IS INITIAL.
            build_string_assigned_values(
              EXPORTING
                is_valuation_data = <ls_valuation_data_upd>
              IMPORTING
                ev_charcvalue     = lv_charcvalue
                et_core_message   = lt_core_message
            ).
            <ls_valuation_data_upd>-charcvalue = lv_charcvalue.
          ENDIF.

          lo_clf_api_result->add_messages_from_core(
            is_classification_key = ms_classification_key
            it_core_message       = lt_core_message ).

        ENDLOOP.
      ELSE.
        LOOP AT mt_valuation_data ASSIGNING <ls_valuation_data_upd>
          WHERE object_state <> if_ngc_c=>gc_object_state-deleted.

          APPEND INITIAL LINE TO et_valuation_data ASSIGNING <ls_valuation_data_exp>.
          MOVE-CORRESPONDING <ls_valuation_data_upd> TO <ls_valuation_data_exp>.

          IF <ls_valuation_data_upd>-charcvalue IS INITIAL.
            build_string_assigned_values(
              EXPORTING
                is_valuation_data = <ls_valuation_data_upd>
              IMPORTING
                ev_charcvalue     = lv_charcvalue
                et_core_message   = lt_core_message
            ).
            <ls_valuation_data_upd>-charcvalue = lv_charcvalue.
          ENDIF.

          lo_clf_api_result->add_messages_from_core(
            is_classification_key = ms_classification_key
            it_core_message       = lt_core_message ).

        ENDLOOP.
      ENDIF.
    ENDIF.

    SORT et_valuation_data ASCENDING BY classtype charcinternalid ASCENDING.

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.