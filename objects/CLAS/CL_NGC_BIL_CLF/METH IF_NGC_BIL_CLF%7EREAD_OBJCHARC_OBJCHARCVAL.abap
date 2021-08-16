  METHOD if_ngc_bil_clf~read_objcharc_objcharcval.

    DATA:
      lt_classification_key     TYPE ngct_classification_key,
      ls_internal_object_number TYPE ngcs_clf_obj_int_id.

    CLEAR: et_result, et_link, es_failed, es_reported.

    me->get_classifications(
      EXPORTING
        it_classification_key    = CORRESPONDING #( it_input )
      IMPORTING
        et_classification_object = DATA(lt_classification_object)
        eo_clf_api_result        = DATA(lo_clf_api_result) ).

    me->add_object_charc_msg(
      EXPORTING
        it_clfnobjectcharc = CORRESPONDING #( it_input )
        io_ngc_api_result  = lo_clf_api_result
      CHANGING
        ct_reported        = es_reported
        ct_failed          = es_failed ).

    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<ls_input>)
      GROUP BY (
        clfnobjectid     = <ls_input>-clfnobjectid
        clfnobjecttable  = <ls_input>-clfnobjecttable
        classtype        = <ls_input>-classtype )
      REFERENCE INTO DATA(lr_entity_group).

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

      ls_classification_object-classification->get_characteristics(
        EXPORTING
          iv_classtype      = lr_entity_group->classtype
        IMPORTING
          et_characteristic = DATA(lt_characteristic)
          eo_clf_api_result = lo_clf_api_result ).

      me->add_object_charc_msg(
        EXPORTING
          it_clfnobjectcharc = CORRESPONDING #( it_input )
          io_ngc_api_result  = lo_clf_api_result
        CHANGING
          ct_reported        = es_reported
          ct_failed          = es_failed ).

      ls_classification_object-classification->get_assigned_values(
        EXPORTING
          iv_classtype      = lr_entity_group->classtype
        IMPORTING
          et_valuation_data = DATA(lt_valuation)
          eo_clf_api_result  = lo_clf_api_result ).

      me->add_object_charc_msg(
        EXPORTING
          it_clfnobjectcharc = CORRESPONDING #( it_input )
          io_ngc_api_result  = lo_clf_api_result
        CHANGING
          ct_reported        = es_reported
          ct_failed          = es_failed ).

      DATA(lt_internal_object_number) = ls_classification_object-classification->get_internal_object_number( ).

      ls_internal_object_number = VALUE #( lt_internal_object_number[ classtype = lr_entity_group->classtype ] OPTIONAL ).

      LOOP AT GROUP lr_entity_group ASSIGNING FIELD-SYMBOL(<ls_entity>).
        DATA(ls_characteristic) = VALUE #( lt_characteristic[ charcinternalid = <ls_entity>-charcinternalid ] OPTIONAL ).

        IF ls_characteristic IS INITIAL.
          CONTINUE.
        ENDIF.

        LOOP AT lt_valuation ASSIGNING FIELD-SYMBOL(<ls_valuation>)
          WHERE
            charcinternalid = <ls_entity>-charcinternalid.
          APPEND INITIAL LINE TO et_result ASSIGNING FIELD-SYMBOL(<ls_result>).
          MOVE-CORRESPONDING <ls_valuation> TO <ls_result>.

          <ls_result>-clfnobjecttable      = lr_entity_group->clfnobjecttable.
          <ls_result>-clfnobjectinternalid = ls_internal_object_number-clfnobjectinternalid.

          " Clear charc value if type is nat character to have the same value as in CDS
          IF ls_characteristic-characteristic_object->get_header( )-charcdatatype <> if_ngc_c=>gc_charcdatatype-char.
            CLEAR: <ls_result>-charcvalue.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.