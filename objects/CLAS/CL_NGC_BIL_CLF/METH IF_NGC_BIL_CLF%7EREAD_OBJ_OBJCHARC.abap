  METHOD if_ngc_bil_clf~read_obj_objcharc.

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
        ct_failed          = es_failed
        ct_reported        = es_reported ).

    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<ls_input>).
      DATA(ls_classification_object) = VALUE #( lt_classification_object[
        object_key       = <ls_input>-clfnobjectid
        technical_object = <ls_input>-clfnobjecttable
        key_date         = sy-datum
        change_number    = space ] ).

      IF ls_classification_object IS INITIAL.
        " There should be already messages returned by get_classifications
        CONTINUE.
      ENDIF.

      ls_classification_object-classification->get_characteristics(
        IMPORTING
          et_characteristic  = DATA(lt_characteristic)
          eo_clf_api_result  = lo_clf_api_result ).

      me->add_object_charc_msg(
        EXPORTING
          it_clfnobjectcharc = CORRESPONDING #( it_input )
          io_ngc_api_result  = lo_clf_api_result
        CHANGING
          ct_reported        = es_reported
          ct_failed          = es_failed ).

      DATA(lt_internal_object_number) = ls_classification_object-classification->get_internal_object_number( ).

      LOOP AT lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>)
        GROUP BY (
          classtype = <ls_characteristic>-classtype )
        REFERENCE INTO DATA(lr_entity_group).

        ls_internal_object_number = VALUE #(
          lt_internal_object_number[ classtype = lr_entity_group->classtype ] OPTIONAL ).

        LOOP AT GROUP lr_entity_group ASSIGNING FIELD-SYMBOL(<ls_entity>).
          APPEND INITIAL LINE TO et_result ASSIGNING FIELD-SYMBOL(<ls_result>).
          <ls_result>-clfnobjecttable      = <ls_input>-clfnobjecttable.
          <ls_result>-clfnobjectid         = <ls_input>-clfnobjectid.
          <ls_result>-classtype            = <ls_entity>-classtype.
          <ls_result>-charcinternalid      = <ls_entity>-charcinternalid.
          <ls_result>-clfnobjectinternalid = ls_internal_object_number-clfnobjectinternalid.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.