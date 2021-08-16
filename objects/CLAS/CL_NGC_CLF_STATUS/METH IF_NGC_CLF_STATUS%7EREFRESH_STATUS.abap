  METHOD if_ngc_clf_status~refresh_status.

    DATA:
      lo_clf_api_result            TYPE REF TO cl_ngc_clf_api_result,
      lt_classification_data_mod   TYPE ngct_classification_data_mod,
      lt_incomplete_characteristic TYPE ngct_characteristic,
      lv_status_updated            TYPE abap_bool VALUE abap_false.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    io_classification->get_assigned_classes(
      IMPORTING
        et_classification_data = DATA(lt_classification_data) ).

    LOOP AT lt_classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data>).
      me->get_statuses_for_classtype(
        EXPORTING
          iv_classtype                = <ls_classification_data>-classtype
        IMPORTING
          es_released_status          = DATA(ls_released_status)
          es_incomplete_system_status = DATA(ls_incomplete_system_status) ).

      IF <ls_classification_data>-clfnstatus = ls_released_status-statu OR
         <ls_classification_data>-clfnstatus = ls_incomplete_system_status-statu.
        lv_status_updated = abap_true.

        DATA(lt_incomplete_char_for_class) = me->check_incomplete_by_system(
          io_classification      = io_classification
          is_classification_data = <ls_classification_data> ).

        IF lt_incomplete_char_for_class IS INITIAL.
          IF <ls_classification_data>-clfnstatus <> ls_released_status-statu.
            APPEND
              VALUE #(
                classinternalid     = <ls_classification_data>-classinternalid
                classpositionnumber = <ls_classification_data>-classpositionnumber
                clfnstatus          = ls_released_status-statu )
              TO lt_classification_data_mod.
          ENDIF.
        ELSE.
          IF <ls_classification_data>-clfnstatus <> ls_incomplete_system_status-statu.
            APPEND
              VALUE #(
                classinternalid     = <ls_classification_data>-classinternalid
                classpositionnumber = <ls_classification_data>-classpositionnumber
                clfnstatus          = ls_incomplete_system_status-statu )
              TO lt_classification_data_mod.
          ENDIF.

          LOOP AT lt_incomplete_char_for_class ASSIGNING FIELD-SYMBOL(<ls_incomplete_char_for_class>).
            READ TABLE lt_incomplete_characteristic
              TRANSPORTING NO FIELDS
              WITH KEY
                charcinternalid = <ls_incomplete_char_for_class>-charcinternalid.

            IF sy-subrc <> 0.
              APPEND <ls_incomplete_char_for_class> TO lt_incomplete_characteristic.

              MESSAGE w015(ngc_api_base) WITH <ls_incomplete_char_for_class>-charcdescription INTO DATA(lv_msg) ##NEEDED.
              lo_clf_api_result->add_message_from_sy( io_classification->get_classification_key( ) ).
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDLOOP.

    IF lv_status_updated = abap_true.
      io_classification->modify_classification_data(
        EXPORTING
          it_classification_data_mod = lt_classification_data_mod
        IMPORTING
          eo_clf_api_result          = DATA(lo_clf_api_result_tmp) ).

      lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).
    ENDIF.

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.