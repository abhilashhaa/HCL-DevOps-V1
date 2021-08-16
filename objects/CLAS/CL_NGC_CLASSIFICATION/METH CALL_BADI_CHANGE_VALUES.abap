  METHOD call_badi_change_values.

    DATA:
      lo_clf_api_result     TYPE REF TO cl_ngc_clf_api_result,
      lo_badi               TYPE REF TO ngc_clf_check_change_values,
      lt_change_value       TYPE ngct_valuation_charcvalue_chg,
      lv_allowed            TYPE boole_d VALUE abap_true,
      lt_message            TYPE ngct_msg_with_index,
      lt_message_all        TYPE ngct_msg_with_index,
      lr_atinn              TYPE REF TO atinn,
      lt_classification_msg TYPE ngct_classification_msg.

    FIELD-SYMBOLS:
      <lv_atinn> TYPE atinn.

    CLEAR: ev_allowed, eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    LOOP AT mt_classtype ASSIGNING FIELD-SYMBOL(<ls_classtype>).

      TRY.
          GET BADI lo_badi
            FILTERS
              technical_object = ms_classification_key-technical_object
              classtype        = <ls_classtype>-classtype.

          CLEAR: lt_change_value.

          LOOP AT it_change_value ASSIGNING FIELD-SYMBOL(<ls_change_value>).
            IF <ls_change_value>-classtype = <ls_classtype>-classtype.
              APPEND <ls_change_value> TO lt_change_value.
            ENDIF.
          ENDLOOP.

          IF lt_change_value IS INITIAL.
            CONTINUE.
          ENDIF.

          TEST-SEAM badi_check_change_values.
            CALL BADI lo_badi->check_change_values
              EXPORTING
                iv_classtype               = <ls_classtype>-classtype
                is_classification_key      = ms_classification_key
                it_classification_ref_data = mt_reference_data
                it_change_value            = lt_change_value
              CHANGING
                cv_allowed                 = lv_allowed
                ct_message                 = lt_message.
          END-TEST-SEAM.
          APPEND LINES OF lt_message TO lt_message_all.

        CATCH cx_badi ##no_handler.
      ENDTRY.

      IF lv_allowed = abap_false.
        EXIT.
      ENDIF.

    ENDLOOP.

    ev_allowed = lv_allowed.

    LOOP AT lt_message_all ASSIGNING FIELD-SYMBOL(<ls_message>).
      UNASSIGN <lv_atinn>.
      IF <ls_message>-msg_index IS NOT INITIAL.
        READ TABLE it_change_value INDEX <ls_message>-msg_index ASSIGNING <ls_change_value>.
        IF sy-subrc = 0.
          CREATE DATA lr_atinn TYPE atinn.
          ASSIGN lr_atinn->* TO <lv_atinn>.
          <lv_atinn> = <ls_change_value>-charcinternalid.
        ENDIF.
      ENDIF.
      APPEND VALUE #(
        object_key       = ms_classification_key-object_key
        technical_object = ms_classification_key-technical_object
        change_number    = ms_classification_key-change_number
        key_date         = ms_classification_key-key_date
        msgty            = <ls_message>-msgty
        msgid            = <ls_message>-msgid
        msgno            = <ls_message>-msgno
        msgv1            = <ls_message>-msgv1
        msgv2            = <ls_message>-msgv2
        msgv3            = <ls_message>-msgv3
        msgv4            = <ls_message>-msgv4
        ref_key          = COND #( WHEN <lv_atinn> IS ASSIGNED THEN lr_atinn )
        ref_type         = COND #( WHEN <lv_atinn> IS ASSIGNED THEN 'ATINN' )
      ) TO lt_classification_msg.
    ENDLOOP.

    lo_clf_api_result->add_messages( lt_classification_msg ).

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.