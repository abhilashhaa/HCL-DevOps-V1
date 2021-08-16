  METHOD if_ngc_bil_clf~update_objcharcval.

    DATA:
      lt_classification_key TYPE ngct_classification_key,
      lt_char_change_value  TYPE ngct_valuation_charcv_char_chg,
      lt_char_success_value TYPE ngct_valuation_charcv_char_chg,
      lt_char_entity_fail   TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input,
      lt_num_change_value   TYPE ngct_valuation_charcv_num_chg,
      lt_num_success_value  TYPE ngct_valuation_charcv_num_chg,
      lt_num_entity_fail    TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input,
      lt_curr_change_value  TYPE ngct_valuation_charcv_curr_chg,
      lt_curr_success_value TYPE ngct_valuation_charcv_curr_chg,
      lt_curr_entity_fail   TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input,
      lt_date_change_value  TYPE ngct_valuation_charcv_date_chg,
      lt_date_success_value TYPE ngct_valuation_charcv_date_chg,
      lt_date_entity_fail   TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input,
      lt_time_change_value  TYPE ngct_valuation_charcv_time_chg,
      lt_time_success_value TYPE ngct_valuation_charcv_time_chg,
      lt_time_entity_fail   TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input.

    CLEAR: es_failed, es_reported.

    me->get_classifications(
      EXPORTING
        it_classification_key    = CORRESPONDING #( it_input MAPPING cid  = %cid_ref )
      IMPORTING
        et_classification_object = DATA(lt_classification_object)
        eo_clf_api_result        = DATA(lo_clf_api_result) ).

    me->add_object_charc_val_msg(
      EXPORTING
        it_clfnobjectcharcval = CORRESPONDING #( it_input MAPPING cid = %cid_ref )
        io_ngc_api_result     = lo_clf_api_result
      CHANGING
        ct_failed             = es_failed
        ct_reported           = es_reported ).

    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<ls_input>)
      GROUP BY ( clfnobjectid     = <ls_input>-clfnobjectid
                 clfnobjecttable  = <ls_input>-clfnobjecttable
                 classtype        = <ls_input>-classtype )
      REFERENCE INTO DATA(lr_entity_group).

      CLEAR: lt_char_change_value, lt_char_entity_fail,
             lt_num_change_value,  lt_num_entity_fail,
             lt_curr_change_value, lt_curr_entity_fail,
             lt_date_change_value, lt_date_entity_fail,
             lt_time_change_value, lt_time_entity_fail.

      " get classification, based on classification key
      DATA(ls_classification_object) = VALUE #( lt_classification_object[
        object_key       = lr_entity_group->clfnobjectid
        technical_object = lr_entity_group->clfnobjecttable
        key_date         = sy-datum
        change_number    = space ] OPTIONAL ).

      IF ls_classification_object IS INITIAL.
        " There should be already messages returned by get_classifications
        CONTINUE.
      ENDIF.

      " get all characteristics of a classified object
      ls_classification_object-classification->get_characteristics(
        EXPORTING
          iv_classtype       = lr_entity_group->classtype
        IMPORTING
          et_characteristic  = DATA(lt_characteristic)
          eo_clf_api_result  = lo_clf_api_result ).

      me->add_object_charc_val_msg(
        EXPORTING
          it_clfnobjectcharcval = CORRESPONDING #( it_input MAPPING cid = %cid_ref )
          io_ngc_api_result     = lo_clf_api_result
        CHANGING
          ct_reported           = es_reported
          ct_failed             = es_failed ).

      IF lo_clf_api_result->has_error_or_worse( ) = abap_true.
        CONTINUE.
      ENDIF.

      " get all assigned values
      ls_classification_object-classification->get_assigned_values(
        EXPORTING
          iv_classtype      = lr_entity_group->classtype
        IMPORTING
          et_valuation_data = DATA(lt_valuation_data)
          eo_clf_api_result = lo_clf_api_result ).

      me->add_object_charc_val_msg(
        EXPORTING
          it_clfnobjectcharcval = CORRESPONDING #( it_input MAPPING cid = %cid_ref )
          io_ngc_api_result     = lo_clf_api_result
        CHANGING
          ct_reported           = es_reported
          ct_failed             = es_failed ).

      IF lo_clf_api_result->has_error_or_worse( ) = abap_true.
        CONTINUE.
      ENDIF.

      LOOP AT GROUP lr_entity_group ASSIGNING FIELD-SYMBOL(<ls_entity>).
        ASSIGN lt_characteristic[ charcinternalid = <ls_entity>-charcinternalid ] TO FIELD-SYMBOL(<ls_characteristic>).

        IF <ls_characteristic> IS NOT ASSIGNED.
          MESSAGE e000(ngc_core_chr) WITH <ls_entity>-charcinternalid sy-datum INTO DATA(lv_msg) ##NEEDED.
          me->add_object_charc_val_msg(
            EXPORTING
              it_clfnobjectcharcval = VALUE #( (
                clfnobjectid             = <ls_entity>-clfnobjectid
                clfnobjecttable          = <ls_entity>-clfnobjecttable
                charcinternalid          = <ls_entity>-charcinternalid
                charcvaluepositionnumber = <ls_entity>-charcvaluepositionnumber
                classtype                = <ls_entity>-classtype
                cid                      = <ls_entity>-%cid_ref ) )
            CHANGING
              ct_reported           = es_reported
              ct_failed             = es_failed ).

          CONTINUE.
        ENDIF.

        DATA(ls_characteristic_header) = <ls_characteristic>-characteristic_object->get_header( ).

        ASSIGN lt_valuation_data[
          clfnobjectid              = <ls_entity>-clfnobjectid
          charcinternalid           = <ls_entity>-charcinternalid
          classtype                 = <ls_entity>-classtype
          charcvaluepositionnumber  = <ls_entity>-charcvaluepositionnumber ] TO FIELD-SYMBOL(<ls_valuation_data>).

        IF <ls_valuation_data> IS NOT ASSIGNED.
          MESSAGE e016(ngc_rap) WITH <ls_entity>-charcvaluepositionnumber INTO lv_msg ##NEEDED.
          me->add_object_charc_val_msg(
            EXPORTING
              it_clfnobjectcharcval = VALUE #( (
                clfnobjectid             = <ls_entity>-clfnobjectid
                clfnobjecttable          = <ls_entity>-clfnobjecttable
                charcinternalid          = <ls_entity>-charcinternalid
                charcvaluepositionnumber = <ls_entity>-charcvaluepositionnumber
                classtype                = <ls_entity>-classtype
                cid                      = <ls_entity>-%cid_ref ) )
            CHANGING
              ct_reported           = es_reported
              ct_failed             = es_failed ).

          CONTINUE.
        ENDIF.

        DATA(lv_fields_valid) = me->check_object_charc_val(
          iv_data_type = ls_characteristic_header-charcdatatype
          is_value     = CORRESPONDING #( <ls_entity> ) ).

        IF lv_fields_valid = abap_false.
          MESSAGE e054(ngc_rap) INTO lv_msg ##NEEDED.
          me->add_object_charc_val_msg(
            EXPORTING
              it_clfnobjectcharcval = VALUE #( (
                clfnobjectid             = <ls_entity>-clfnobjectid
                clfnobjecttable          = <ls_entity>-clfnobjecttable
                charcinternalid          = <ls_entity>-charcinternalid
                charcvaluepositionnumber = <ls_entity>-charcvaluepositionnumber
                classtype                = <ls_entity>-classtype
                cid                      = <ls_entity>-%cid_ref ) )
            CHANGING
              ct_reported           = es_reported
              ct_failed             = es_failed ).

          CONTINUE.
        ENDIF.

        DATA(lt_clfncharcvalue) = VALUE lty_t_objectcharcval(
          ( clfnobjectid             = <ls_entity>-clfnobjectid
            clfnobjecttable          = <ls_entity>-clfnobjecttable
            classtype                = <ls_entity>-classtype
            charcinternalid          = <ls_entity>-charcinternalid
            charcvaluepositionnumber = <ls_entity>-charcinternalid
            cid                      = <ls_entity>-%cid_ref ) ).

        CASE ls_characteristic_header-charcdatatype.
          WHEN if_ngc_c=>gc_charcdatatype-char.
            IF <ls_entity>-%control-charcvalue = cl_abap_behavior_handler=>flag_changed.
              ls_classification_object-classification->change_character_value(
                EXPORTING
                  it_change_value   = VALUE #(
                    ( charcvaluepositionnumber = <ls_entity>-charcvaluepositionnumber
                      classtype                = <ls_entity>-classtype
                      charcinternalid          = <ls_entity>-charcinternalid
                      charcvalue               = <ls_entity>-charcvalue ) )
                IMPORTING
                  eo_clf_api_result = lo_clf_api_result ).
            ENDIF.

          WHEN if_ngc_c=>gc_charcdatatype-num.
            DATA(lv_charcvaluedependency) = COND #(
              WHEN <ls_entity>-%control-charcvaluedependency = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charcvaluedependency
              ELSE <ls_valuation_data>-charcvaluedependency ).

            DATA(lv_charcfromdecimalvalue) = COND #(
              WHEN <ls_entity>-%control-charcfromdecimalvalue = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charcfromdecimalvalue
              ELSE <ls_valuation_data>-charcfromdecimalvalue ).

            DATA(lv_charcfromnumericvalueunit) = COND #(
              WHEN <ls_entity>-%control-charcfromnumericvalueunit = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charcfromnumericvalueunit
              ELSE <ls_valuation_data>-charcfromnumericvalueunit ).

            DATA(lv_charctodecimalvalue) = COND #(
              WHEN <ls_entity>-%control-charctodecimalvalue = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charctodecimalvalue
              ELSE <ls_valuation_data>-charctodecimalvalue ).

            DATA(lv_charctonumericvalueunit) = COND #(
              WHEN <ls_entity>-%control-charctonumericvalueunit = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charctonumericvalueunit
              ELSE <ls_valuation_data>-charctonumericvalueunit ).

            ls_classification_object-classification->change_numeric_value(
                EXPORTING
                  it_change_value   = VALUE #(
                    ( charcvaluepositionnumber  = <ls_entity>-charcvaluepositionnumber
                      classtype                 = <ls_entity>-classtype
                      charcinternalid           = <ls_entity>-charcinternalid
                      charcvaluedependency      = lv_charcvaluedependency
                      charcfromdecimalvalue     = lv_charcfromdecimalvalue
                      charcfromnumericvalueunit = lv_charcfromnumericvalueunit
                      charctodecimalvalue       = lv_charctodecimalvalue
                      charctonumericvalueunit   = lv_charctonumericvalueunit ) )
                IMPORTING
                  eo_clf_api_result = lo_clf_api_result ).

          WHEN if_ngc_c=>gc_charcdatatype-curr.
            lv_charcvaluedependency = COND #(
              WHEN <ls_entity>-%control-charcvaluedependency = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charcvaluedependency
              ELSE <ls_valuation_data>-charcvaluedependency ).

            DATA(lv_charcfromamount) = COND #(
              WHEN <ls_entity>-%control-charcfromamount = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charcfromamount
              ELSE <ls_valuation_data>-charcfromamount ).

            DATA(lv_charctoamount) = COND #(
              WHEN <ls_entity>-%control-charctoamount = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charctoamount
              ELSE <ls_valuation_data>-charctoamount ).

            ls_classification_object-classification->change_currency_value(
                EXPORTING
                  it_change_value   = VALUE #(
                    ( charcvaluepositionnumber = <ls_entity>-charcvaluepositionnumber
                      classtype                = <ls_entity>-classtype
                      charcinternalid          = <ls_entity>-charcinternalid
                      charcvaluedependency     = lv_charcvaluedependency
                      charcfromamount          = lv_charcfromamount
                      charctoamount            = lv_charctoamount ) )
                IMPORTING
                  eo_clf_api_result = lo_clf_api_result ).

          WHEN if_ngc_c=>gc_charcdatatype-date.
            lv_charcvaluedependency = COND #(
              WHEN <ls_entity>-%control-charcvaluedependency = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charcvaluedependency
              ELSE <ls_valuation_data>-charcvaluedependency ).

            DATA(lv_charcfromdate) = COND #(
              WHEN <ls_entity>-%control-charcfromdate = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charcfromdate
              ELSE <ls_valuation_data>-charcfromdate ).

            DATA(lv_charctodate) = COND #(
              WHEN <ls_entity>-%control-charctodate = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charctodate
              ELSE <ls_valuation_data>-charctodate ).

            ls_classification_object-classification->change_date_value(
                EXPORTING
                  it_change_value   = VALUE #(
                    ( charcvaluepositionnumber = <ls_entity>-charcvaluepositionnumber
                      classtype                = <ls_entity>-classtype
                      charcinternalid          = <ls_entity>-charcinternalid
                      charcvaluedependency     = lv_charcvaluedependency
                      charcfromdate            = lv_charcfromdate
                      charctodate              = lv_charctodate ) )
                IMPORTING
                  eo_clf_api_result = lo_clf_api_result ).

          WHEN if_ngc_c=>gc_charcdatatype-time.
            lv_charcvaluedependency = COND #(
              WHEN <ls_entity>-%control-charcvaluedependency = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charcvaluedependency
              ELSE <ls_valuation_data>-charcvaluedependency ).

            DATA(lv_charcfromtime) = COND #(
              WHEN <ls_entity>-%control-charcfromtime = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charcfromtime
              ELSE <ls_valuation_data>-charcfromtime ).

            DATA(lv_charctotime) = COND #(
              WHEN <ls_entity>-%control-charctotime = cl_abap_behavior_handler=>flag_changed
              THEN <ls_entity>-charctotime
              ELSE <ls_valuation_data>-charctotime ).

            ls_classification_object-classification->change_time_value(
                EXPORTING
                  it_change_value   = VALUE #(
                    ( charcvaluepositionnumber = <ls_entity>-charcvaluepositionnumber
                      classtype                = <ls_entity>-classtype
                      charcinternalid          = <ls_entity>-charcinternalid
                      charcvaluedependency     = lv_charcvaluedependency
                      charcfromtime            = lv_charcfromtime
                      charctotime              = lv_charctotime ) )
                IMPORTING
                  eo_clf_api_result = lo_clf_api_result ).

          WHEN OTHERS.
            ASSERT FIELDS 'Invalid charc data type' ls_characteristic_header-charcdatatype CONDITION 1 = 2 ##NO_TEXT.

        ENDCASE.

        me->add_object_charc_val_msg(
          EXPORTING
            io_ngc_api_result     = lo_clf_api_result
            it_clfnobjectcharcval = lt_clfncharcvalue
          CHANGING
            ct_failed            = es_failed
            ct_reported          = es_reported ).
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.