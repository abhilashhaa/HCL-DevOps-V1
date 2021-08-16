  METHOD if_ngc_bil_clf~create_objcharc_objcharcval.

    DATA:
      lt_classification_key TYPE ngct_classification_key,
      lt_char_change_value  TYPE ngct_valuation_charcv_char_chg,
      lt_char_success_value TYPE ngct_valuation_charcv_char_chg,
      lt_char_entity_fail   TYPE if_ngc_bil_clf~ts_objcharc-create_by-_objectcharcvalue-t_input,
      lt_char_entity_succ   TYPE if_ngc_bil_clf~ts_objcharc-create_by-_objectcharcvalue-t_input,
      lt_num_change_value   TYPE ngct_valuation_charcv_num_chg,
      lt_num_success_value  TYPE ngct_valuation_charcv_num_chg,
      lt_num_entity_fail    TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input,
      lt_num_entity_succ    TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input,
      lt_curr_change_value  TYPE ngct_valuation_charcv_curr_chg,
      lt_curr_success_value TYPE ngct_valuation_charcv_curr_chg,
      lt_curr_entity_fail   TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input,
      lt_curr_entity_succ   TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input,
      lt_date_change_value  TYPE ngct_valuation_charcv_date_chg,
      lt_date_success_value TYPE ngct_valuation_charcv_date_chg,
      lt_date_entity_succ   TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input,
      lt_date_entity_fail   TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input,
      lt_time_change_value  TYPE ngct_valuation_charcv_time_chg,
      lt_time_success_value TYPE ngct_valuation_charcv_time_chg,
      lt_time_entity_succ   TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input,
      lt_time_entity_fail   TYPE if_ngc_bil_clf~ts_objcharcval-create-t_input.
    DATA: lt_objectcharc TYPE lty_t_objectcharc.

    CLEAR: es_mapped, es_failed, es_reported.

    me->get_classifications(
      EXPORTING
        it_classification_key    = CORRESPONDING #( it_input MAPPING cid  = %cid_ref )
      IMPORTING
        et_classification_object = DATA(lt_classification_object)
        eo_clf_api_result        = DATA(lo_clf_api_result) ).

    DATA(lt_objcharcval) = me->get_charcval_from_charc( it_input ).

    me->add_object_charc_val_msg(
      EXPORTING
        it_clfnobjectcharcval = CORRESPONDING #( lt_objcharcval MAPPING cid = %cid )
        io_ngc_api_result     = lo_clf_api_result
      CHANGING
        ct_failed             = es_failed
        ct_reported           = es_reported ).

    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<ls_input>)
      GROUP BY ( clfnobjectid     = <ls_input>-clfnobjectid
                 clfnobjecttable  = <ls_input>-clfnobjecttable
                 classtype        = <ls_input>-classtype )
      REFERENCE INTO DATA(lr_entity_group).

      CLEAR: lt_char_change_value, lt_char_entity_fail, lt_char_entity_succ,
             lt_num_change_value,  lt_num_entity_fail, lt_num_entity_succ,
             lt_curr_change_value, lt_curr_entity_fail, lt_curr_entity_succ,
             lt_date_change_value, lt_date_entity_fail, lt_date_entity_succ,
             lt_time_change_value, lt_time_entity_fail, lt_time_entity_succ.

      " get classification, based on classification key
      DATA(ls_classification_object) = VALUE #( lt_classification_object[
        object_key       = lr_entity_group->clfnobjectid
        technical_object = lr_entity_group->clfnobjecttable
        key_date         = sy-datum
        change_number    = space ] OPTIONAL ).

      IF ls_classification_object IS INITIAL.
        " There should be already a message by get_classifications
        CONTINUE.
      ENDIF.

      " get all characteristics of a classified object
      ls_classification_object-classification->get_characteristics(
        EXPORTING
          iv_classtype        = lr_entity_group->classtype
        IMPORTING
          et_characteristic   = DATA(lt_characteristic)
          eo_clf_api_result   = lo_clf_api_result ).

      me->add_object_charc_val_msg(
        EXPORTING
          io_ngc_api_result     = lo_clf_api_result
          it_clfnobjectcharcval = CORRESPONDING #( lt_objcharcval MAPPING cid = %cid )
        CHANGING
          ct_failed             = es_failed
          ct_reported           = es_reported ).

      IF lo_clf_api_result->has_error_or_worse( ) = abap_true.
        CONTINUE.
      ENDIF.

      LOOP AT GROUP lr_entity_group ASSIGNING FIELD-SYMBOL(<ls_entity>).
        LOOP AT <ls_entity>-%target ASSIGNING FIELD-SYMBOL(<ls_target>).
          IF <ls_target>-%control-charcvaluepositionnumber = cl_abap_behavior_handler=>flag_changed.
            MESSAGE e055(ngc_rap) INTO DATA(lv_msg) ##NEEDED.
            me->add_object_charc_val_msg(
              EXPORTING
                it_clfnobjectcharcval = VALUE #( (
                  clfnobjectid             = lr_entity_group->clfnobjectid
                  clfnobjecttable          = lr_entity_group->clfnobjecttable
                  classtype                = lr_entity_group->classtype
                  charcinternalid          = <ls_target>-charcinternalid
                  charcvaluepositionnumber = <ls_target>-charcvaluepositionnumber
                  cid                      = <ls_target>-%cid ) )
              CHANGING
                ct_failed                  = es_failed
                ct_reported                = es_reported ).

            CONTINUE.
          ENDIF.

          ASSIGN lt_characteristic[ charcinternalid = <ls_entity>-charcinternalid ] TO FIELD-SYMBOL(<ls_characteristic>).

          IF <ls_characteristic> IS NOT ASSIGNED.
            MESSAGE e000(ngc_core_chr) WITH <ls_entity>-charcinternalid sy-datum INTO lv_msg ##NEEDED.
            me->add_object_charc_val_msg(
              EXPORTING
                it_clfnobjectcharcval = VALUE #( (
                  clfnobjectid             = lr_entity_group->clfnobjectid
                  clfnobjecttable          = lr_entity_group->clfnobjecttable
                  classtype                = lr_entity_group->classtype
                  charcinternalid          = <ls_target>-charcinternalid
                  charcvaluepositionnumber = <ls_target>-charcvaluepositionnumber
                  cid                      = <ls_target>-%cid ) )
              CHANGING
                ct_failed             = es_failed
                ct_reported           = es_reported ).

            CONTINUE.
          ENDIF.

          DATA(ls_characteristic_header) = <ls_characteristic>-characteristic_object->get_header( ).

          DATA(lv_fields_valid) = me->check_object_charc_val(
            iv_data_type = ls_characteristic_header-charcdatatype
            is_value     = CORRESPONDING #( <ls_target> ) ).

          IF lv_fields_valid = abap_false.
            MESSAGE e054(ngc_rap) INTO lv_msg ##NEEDED.
            me->add_object_charc_val_msg(
              EXPORTING
                it_clfnobjectcharcval = VALUE #( (
                  clfnobjectid             = lr_entity_group->clfnobjectid
                  clfnobjecttable          = lr_entity_group->clfnobjecttable
                  classtype                = lr_entity_group->classtype
                  charcinternalid          = <ls_target>-charcinternalid
                  charcvaluepositionnumber = <ls_target>-charcvaluepositionnumber
                  cid                      = <ls_target>-%cid ) )
              CHANGING
                ct_failed                  = es_failed
                ct_reported                = es_reported ).

            CONTINUE.
          ENDIF.

          DATA(ls_target) = <ls_target>.
          ls_target-charcinternalid = <ls_entity>-charcinternalid.
          ls_target-classtype       = <ls_entity>-classtype.
          ls_target-clfnobjectid    = <ls_entity>-clfnobjectid.
          ls_target-clfnobjecttable = <ls_entity>-clfnobjecttable.

          DATA(lt_clfncharcvalue) = VALUE lty_t_objectcharcval(
            ( clfnobjectid             = <ls_target>-clfnobjectid
              clfnobjecttable          = <ls_target>-clfnobjecttable
              classtype                = <ls_target>-classtype
              charcinternalid          = <ls_target>-charcinternalid
              charcvaluepositionnumber = <ls_target>-charcvaluepositionnumber
              cid                      = <ls_target>-%cid ) ).

          CASE ls_characteristic_header-charcdatatype.
            WHEN if_ngc_c=>gc_charcdatatype-char.
              ls_classification_object-classification->set_character_value(
                EXPORTING
                  it_change_value   = VALUE #(
                    ( classtype       = ls_target-classtype
                      charcinternalid = ls_target-charcinternalid
                      charcvalue      = ls_target-charcvalue ) )
                IMPORTING
                  eo_clf_api_result = lo_clf_api_result
                  et_success_value  = lt_char_success_value ).

              me->add_object_charc_val_msg(
                EXPORTING
                  io_ngc_api_result     = lo_clf_api_result
                  it_clfnobjectcharcval = lt_clfncharcvalue
                CHANGING
                  ct_failed            = es_failed
                  ct_reported          = es_reported ).

              IF lo_clf_api_result->has_error_or_worse( ) = abap_false AND lines( lt_char_success_value ) > 0.
                APPEND INITIAL LINE TO es_mapped-objectcharcvalue ASSIGNING FIELD-SYMBOL(<ls_mapped>).
                MOVE-CORRESPONDING lt_char_success_value[ 1 ] TO <ls_mapped>.
                <ls_mapped>-clfnobjectid    = lr_entity_group->clfnobjectid.
                <ls_mapped>-clfnobjecttable = lr_entity_group->clfnobjecttable.
                <ls_mapped>-%cid            = <ls_target>-%cid.
              ENDIF.

            WHEN if_ngc_c=>gc_charcdatatype-num.
              ls_classification_object-classification->set_numeric_value(
                EXPORTING
                  it_change_value   = VALUE #(
                    ( classtype                 = ls_target-classtype
                      charcinternalid           = ls_target-charcinternalid
                      charcvaluedependency      = ls_target-charcvaluedependency
                      charcfromdecimalvalue     = ls_target-charcfromdecimalvalue
                      charcfromnumericvalueunit = ls_target-charcfromnumericvalueunit
                      charctodecimalvalue       = ls_target-charctodecimalvalue
                      charctonumericvalueunit   = ls_target-charctonumericvalueunit ) )
                IMPORTING
                  eo_clf_api_result = lo_clf_api_result
                  et_success_value  = lt_num_success_value ).

              me->add_object_charc_val_msg(
                EXPORTING
                  io_ngc_api_result     = lo_clf_api_result
                  it_clfnobjectcharcval = lt_clfncharcvalue
                CHANGING
                  ct_failed            = es_failed
                  ct_reported          = es_reported ).

              IF lo_clf_api_result->has_error_or_worse( ) = abap_false AND lines( lt_num_success_value ) > 0.
                APPEND INITIAL LINE TO es_mapped-objectcharcvalue ASSIGNING <ls_mapped>.
                MOVE-CORRESPONDING lt_num_success_value[ 1 ] TO <ls_mapped>.
                <ls_mapped>-clfnobjectid    = lr_entity_group->clfnobjectid.
                <ls_mapped>-clfnobjecttable = lr_entity_group->clfnobjecttable.
                <ls_mapped>-%cid            = <ls_target>-%cid.
              ENDIF.

            WHEN if_ngc_c=>gc_charcdatatype-curr.
              ls_classification_object-classification->set_currency_value(
                EXPORTING
                  it_change_value   = VALUE #(
                    ( classtype            = ls_target-classtype
                      charcinternalid      = ls_target-charcinternalid
                      charcvaluedependency = ls_target-charcvaluedependency
                      charcfromamount      = ls_target-charcfromamount
                      charctoamount        = ls_target-charctoamount ) )
                IMPORTING
                  eo_clf_api_result = lo_clf_api_result
                  et_success_value  = lt_curr_success_value ).

              me->add_object_charc_val_msg(
                EXPORTING
                  io_ngc_api_result     = lo_clf_api_result
                  it_clfnobjectcharcval = lt_clfncharcvalue
                CHANGING
                  ct_failed            = es_failed
                  ct_reported          = es_reported ).

              IF lo_clf_api_result->has_error_or_worse( ) = abap_false AND lines( lt_curr_success_value ) > 0.
                APPEND INITIAL LINE TO es_mapped-objectcharcvalue ASSIGNING <ls_mapped>.
                MOVE-CORRESPONDING lt_curr_success_value[ 1 ] TO <ls_mapped>.
                <ls_mapped>-clfnobjectid    = lr_entity_group->clfnobjectid.
                <ls_mapped>-clfnobjecttable = lr_entity_group->clfnobjecttable.
                <ls_mapped>-%cid            = <ls_target>-%cid.
              ENDIF.

            WHEN if_ngc_c=>gc_charcdatatype-date.
              ls_classification_object-classification->set_date_value(
                EXPORTING
                  it_change_value   = VALUE #(
                    ( classtype            = ls_target-classtype
                      charcinternalid      = ls_target-charcinternalid
                      charcvaluedependency = ls_target-charcvaluedependency
                      charcfromdate        = ls_target-charcfromdate
                      charctodate          = ls_target-charctodate ) )
                IMPORTING
                  eo_clf_api_result = lo_clf_api_result
                  et_success_value  = lt_date_success_value ).

              me->add_object_charc_val_msg(
                EXPORTING
                  io_ngc_api_result     = lo_clf_api_result
                  it_clfnobjectcharcval = lt_clfncharcvalue
                CHANGING
                  ct_failed            = es_failed
                  ct_reported          = es_reported ).

              IF lo_clf_api_result->has_error_or_worse( ) = abap_false AND lines( lt_date_success_value ) > 0.
                APPEND INITIAL LINE TO es_mapped-objectcharcvalue ASSIGNING <ls_mapped>.
                MOVE-CORRESPONDING lt_date_success_value[ 1 ] TO <ls_mapped>.
                <ls_mapped>-clfnobjectid    = lr_entity_group->clfnobjectid.
                <ls_mapped>-clfnobjecttable = lr_entity_group->clfnobjecttable.
                <ls_mapped>-%cid            = <ls_target>-%cid.
              ENDIF.

            WHEN if_ngc_c=>gc_charcdatatype-time.
              ls_classification_object-classification->set_time_value(
                EXPORTING
                  it_change_value   = VALUE #(
                    ( classtype            = ls_target-classtype
                      charcinternalid      = ls_target-charcinternalid
                      charcvaluedependency = ls_target-charcvaluedependency
                      charcfromtime        = ls_target-charcfromtime
                      charctotime          = ls_target-charctotime ) )
                IMPORTING
                  eo_clf_api_result = lo_clf_api_result
                  et_success_value  = lt_time_success_value ).

              me->add_object_charc_val_msg(
                EXPORTING
                  io_ngc_api_result     = lo_clf_api_result
                  it_clfnobjectcharcval = lt_clfncharcvalue
                CHANGING
                  ct_failed            = es_failed
                  ct_reported          = es_reported ).

              IF lo_clf_api_result->has_error_or_worse( ) = abap_false AND lines( lt_time_success_value ) > 0.
                APPEND INITIAL LINE TO es_mapped-objectcharcvalue ASSIGNING <ls_mapped>.
                MOVE-CORRESPONDING lt_time_success_value[ 1 ] TO <ls_mapped>.
                <ls_mapped>-clfnobjectid    = lr_entity_group->clfnobjectid.
                <ls_mapped>-clfnobjecttable = lr_entity_group->clfnobjecttable.
                <ls_mapped>-%cid            = <ls_target>-%cid.
              ENDIF.

            WHEN OTHERS.
              ASSERT FIELDS 'Invalid charc data type' ls_characteristic_header-charcdatatype CONDITION 1 = 2 ##NO_TEXT.

          ENDCASE.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.