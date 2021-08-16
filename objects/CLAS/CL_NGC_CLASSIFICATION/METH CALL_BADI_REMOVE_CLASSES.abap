  METHOD call_badi_remove_classes.

    DATA:
      lo_clf_api_result	    TYPE REF TO cl_ngc_clf_api_result,
      lo_badi               TYPE REF TO ngc_clf_check_remove_classes,
      lt_class              TYPE ngct_class_object,
      lv_allowed            TYPE boole_d VALUE abap_true,
      lt_message            TYPE ngct_msg_with_index,
      lt_message_all        TYPE ngct_msg_with_index,
      lt_classification_msg TYPE ngct_classification_msg,
      lr_clint              TYPE REF TO clint.

    FIELD-SYMBOLS:
      <lv_clint> TYPE clint.

    CLEAR: ev_allowed, eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    LOOP AT mt_classtype ASSIGNING FIELD-SYMBOL(<ls_classtype>).

      TRY.
          GET BADI lo_badi
            FILTERS
              technical_object = ms_classification_key-technical_object
              classtype        = <ls_classtype>-classtype.

          CLEAR: lt_class.

          LOOP AT it_class ASSIGNING FIELD-SYMBOL(<ls_class>).
            IF <ls_class>-class_object->get_header( )-classtype = <ls_classtype>-classtype.
              APPEND <ls_class> TO lt_class.
            ENDIF.
          ENDLOOP.

          IF lt_class IS INITIAL.
            CONTINUE.
          ENDIF.

          TEST-SEAM badi_check_remove_classes.
            CALL BADI lo_badi->check_remove_classes
              EXPORTING
                iv_classtype               = <ls_classtype>-classtype
                is_classification_key      = ms_classification_key
                it_classification_ref_data = mt_reference_data
                it_class                   = lt_class
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
      UNASSIGN <lv_clint>.
      IF <ls_message>-msg_index IS NOT INITIAL.
        READ TABLE it_class INDEX <ls_message>-msg_index ASSIGNING <ls_class>.
        IF sy-subrc = 0.
          CREATE DATA lr_clint TYPE clint.
          ASSIGN lr_clint->* TO <lv_clint>.
          <lv_clint> = <ls_class>-classinternalid.
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
        ref_key          = COND #( WHEN <lv_clint> IS ASSIGNED THEN lr_clint )
        ref_type         = 'CLINT'
      ) TO lt_classification_msg.
    ENDLOOP.

    lo_clf_api_result->add_messages( lt_classification_msg ).

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.