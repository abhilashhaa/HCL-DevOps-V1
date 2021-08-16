  METHOD if_ngc_bil_clf~read_obj_objclass.

    DATA:
      ls_internal_object_number TYPE ngcs_clf_obj_int_id,
      lt_classification_key     TYPE ngct_classification_key.

    CLEAR: et_result, et_link, es_failed, es_reported.

    me->get_classifications(
      EXPORTING
        it_classification_key    = CORRESPONDING #( it_input )
      IMPORTING
        et_classification_object = DATA(lt_classification_object)
        eo_clf_api_result        = DATA(lo_clf_api_result) ).

    me->add_object_msg(
      EXPORTING
        it_clfnobject     = CORRESPONDING #( it_input )
        io_ngc_api_result = lo_clf_api_result
      CHANGING
        ct_failed         = es_failed
        ct_reported       = es_reported ).

    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<ls_input>)
      GROUP BY (
        clfnobjectid     = <ls_input>-clfnobjectid
        clfnobjecttable  = <ls_input>-clfnobjecttable )
      REFERENCE INTO DATA(lr_entity_group).

      " get classification, based on classification key
      DATA(ls_classification_object) = VALUE #( lt_classification_object[
        object_key       = lr_entity_group->clfnobjectid
        technical_object = lr_entity_group->clfnobjecttable
        key_date         = sy-datum
        change_number    = space ] OPTIONAL ).

      IF ls_classification_object IS INITIAL.
        " There should be already messages by get_classifications
        CONTINUE.
      ENDIF.

      ls_classification_object-classification->get_assigned_classes(
        IMPORTING
          et_classification_data = DATA(lt_classification_data) ).

      DATA(lt_internal_object_number) = ls_classification_object-classification->get_internal_object_number( ).

      LOOP AT GROUP lr_entity_group ASSIGNING FIELD-SYMBOL(<ls_entity>).
        LOOP AT lt_classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data>).
          ls_internal_object_number = VALUE #( lt_internal_object_number[
            classtype = <ls_classification_data>-classtype
            clfnobjectid = lr_entity_group->clfnobjectid ] OPTIONAL ).

          APPEND INITIAL LINE TO et_result ASSIGNING FIELD-SYMBOL(<ls_result>).
          <ls_result>-clfnobjecttable      = lr_entity_group->clfnobjecttable.
          <ls_result>-clfnobjectid         = lr_entity_group->clfnobjectid.
          <ls_result>-classtype            = <ls_classification_data>-classtype.
          <ls_result>-classinternalid      = <ls_classification_data>-classinternalid.
          <ls_result>-clfnobjectinternalid = ls_internal_object_number-clfnobjectinternalid.

          APPEND INITIAL LINE TO et_link ASSIGNING FIELD-SYMBOL(<ls_link>).
          MOVE-CORRESPONDING <ls_entity>  TO <ls_link>-source.
          MOVE-CORRESPONDING <ls_result> TO <ls_link>-target.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.