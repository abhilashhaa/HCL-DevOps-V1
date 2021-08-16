  METHOD if_ngc_bil_clf~delete_objcharcval.

    DATA:
      lt_classification_key TYPE ngct_classification_key,
      lt_char_value         TYPE ngct_valuation_charcv_char_chg,
      lt_num_value          TYPE ngct_valuation_charcv_num_chg,
      lt_curr_value         TYPE ngct_valuation_charcv_curr_chg,
      lt_date_value         TYPE ngct_valuation_charcv_date_chg,
      lt_time_value         TYPE ngct_valuation_charcv_time_chg,
      lt_char_entity_fail   TYPE if_ngc_bil_clf~ts_objcharcval-delete-t_input,
      lt_num_entity_fail    TYPE if_ngc_bil_clf~ts_objcharcval-delete-t_input,
      lt_curr_entity_fail   TYPE if_ngc_bil_clf~ts_objcharcval-delete-t_input,
      lt_date_entity_fail   TYPE if_ngc_bil_clf~ts_objcharcval-delete-t_input,
      lt_time_entity_fail   TYPE if_ngc_bil_clf~ts_objcharcval-delete-t_input.

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
      GROUP BY (
        clfnobjectid     = <ls_input>-clfnobjectid
        clfnobjecttable  = <ls_input>-clfnobjecttable
        classtype        = <ls_input>-classtype )
      REFERENCE INTO DATA(lr_entity_group).

      CLEAR: lt_char_value, lt_char_entity_fail,
             lt_num_value,  lt_num_entity_fail,
             lt_curr_value, lt_curr_entity_fail,
             lt_date_value, lt_date_entity_fail,
             lt_time_value, lt_time_entity_fail.

      DATA(ls_classification_object) = VALUE #( lt_classification_object[
        object_key       = lr_entity_group->clfnobjectid
        technical_object = lr_entity_group->clfnobjecttable
        key_date         = sy-datum
        change_number    = space ] OPTIONAL ).

      IF ls_classification_object IS INITIAL.
        " There should be already messages returned by get_classifications
        CONTINUE.
      ENDIF.

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
          MESSAGE e050(ngc_rap) WITH <ls_entity>-charcinternalid <ls_entity>-clfnobjectid <ls_entity>-clfnobjecttable INTO DATA(lv_msg) ##NEEDED.
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

        ASSIGN lt_valuation_data[
          charcinternalid          = <ls_entity>-charcinternalid
          charcvaluepositionnumber = <ls_entity>-charcvaluepositionnumber
          clfnobjecttype           = 'O'
          classtype                = <ls_entity>-classtype ] TO FIELD-SYMBOL(<ls_valuation_data>).

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

        DATA(ls_charc_hader) = <ls_characteristic>-characteristic_object->get_header( ).

        CASE ls_charc_hader-charcdatatype.
          WHEN if_ngc_c=>gc_charcdatatype-char.
            ls_classification_object-classification->delete_character_value(
              EXPORTING
                it_change_value   = VALUE #(
                  ( classtype       = <ls_entity>-classtype
                    charcinternalid = <ls_entity>-charcinternalid
                    charcvalue      = <ls_valuation_data>-charcvalue ) )
              IMPORTING
                eo_clf_api_result = lo_clf_api_result ).

          WHEN if_ngc_c=>gc_charcdatatype-num.
            ls_classification_object-classification->delete_numeric_value(
              EXPORTING
                it_change_value   = VALUE #(
                  ( classtype                  = <ls_entity>-classtype
                    charcinternalid            = <ls_entity>-charcinternalid
                    charcvaluedependency       = <ls_valuation_data>-charcvaluedependency
                    charcfromdecimalvalue      = <ls_valuation_data>-charcfromdecimalvalue
                    charcfromnumericvalueunit  = <ls_valuation_data>-charcfromnumericvalueunit
                    charctodecimalvalue        = <ls_valuation_data>-charctodecimalvalue
                    charctonumericvalueunit    = <ls_valuation_data>-charctonumericvalueunit ) )
              IMPORTING
                eo_clf_api_result = lo_clf_api_result ).

          WHEN if_ngc_c=>gc_charcdatatype-curr.
            ls_classification_object-classification->delete_currency_value(
              EXPORTING
                it_change_value   = VALUE #(
                  ( classtype            = <ls_entity>-classtype
                    charcinternalid      = <ls_entity>-charcinternalid
                    charcvaluedependency = <ls_valuation_data>-charcvaluedependency
                    charcfromamount      = <ls_valuation_data>-charcfromamount
                    charctoamount        = <ls_valuation_data>-charctoamount ) )
              IMPORTING
                eo_clf_api_result = lo_clf_api_result ).

          WHEN if_ngc_c=>gc_charcdatatype-date.
            ls_classification_object-classification->delete_date_value(
              EXPORTING
                it_change_value   = VALUE #(
                  ( classtype            = <ls_entity>-classtype
                    charcinternalid      = <ls_entity>-charcinternalid
                    charcvaluedependency = <ls_valuation_data>-charcvaluedependency
                    charcfromdate        = <ls_valuation_data>-charcfromdate
                    charctodate          = <ls_valuation_data>-charctodate ) )
              IMPORTING
                eo_clf_api_result = lo_clf_api_result ).

          WHEN if_ngc_c=>gc_charcdatatype-time.
            ls_classification_object-classification->delete_time_value(
              EXPORTING
                it_change_value   = VALUE #(
                  ( classtype            = <ls_entity>-classtype
                    charcinternalid      = <ls_entity>-charcinternalid
                    charcvaluedependency = <ls_valuation_data>-charcvaluedependency
                    charcfromtime        = <ls_valuation_data>-charcfromtime
                    charctotime          = <ls_valuation_data>-charctotime ) )
              IMPORTING
                eo_clf_api_result = lo_clf_api_result ).

          WHEN OTHERS.
            ASSERT FIELDS 'Invalid charc data type' ls_charc_hader-charcdatatype CONDITION 1 = 2 ##NO_TEXT.
        ENDCASE.

        DATA(lt_clfncharcvalue) = VALUE lty_t_objectcharcval(
          ( clfnobjectid             = <ls_entity>-clfnobjectid
            clfnobjecttable          = <ls_entity>-clfnobjecttable
            classtype                = <ls_entity>-classtype
            charcinternalid          = <ls_entity>-charcinternalid
            charcvaluepositionnumber = <ls_entity>-charcinternalid
            cid                      = <ls_entity>-%cid_ref ) ).

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