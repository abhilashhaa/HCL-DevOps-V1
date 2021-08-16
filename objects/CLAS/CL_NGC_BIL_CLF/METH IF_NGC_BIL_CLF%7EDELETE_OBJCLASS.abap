  METHOD if_ngc_bil_clf~delete_objclass.

    DATA:
      lt_classification_key TYPE ngct_classification_key,
      lt_class_int_key      TYPE ngct_class_key.

    CLEAR: es_failed, es_reported.

    me->get_classifications(
      EXPORTING
        it_classification_key    = CORRESPONDING #( it_input MAPPING cid  = %cid_ref )
      IMPORTING
        et_classification_object = DATA(lt_classification_object)
        eo_clf_api_result        = DATA(lo_clf_api_result) ).

    me->add_object_class_msg(
      EXPORTING
        it_clfnobjectclass = CORRESPONDING #( it_input MAPPING cid = %cid_ref )
        io_ngc_api_result  = lo_clf_api_result
      CHANGING
        ct_failed          = es_failed
        ct_reported        = es_reported ).

    " grouping of the entities to be processed, by classification key (object id, object table)
    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<ls_input>)
      GROUP BY ( clfnobjectid     = <ls_input>-clfnobjectid
                 clfnobjecttable  = <ls_input>-clfnobjecttable )
      REFERENCE INTO DATA(lr_entity_group).

      CLEAR: lt_class_int_key.

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

      LOOP AT GROUP lr_entity_group ASSIGNING FIELD-SYMBOL(<ls_entity>).
        APPEND VALUE #( classinternalid = <ls_entity>-classinternalid key_date = sy-datum ) TO lt_class_int_key.
      ENDLOOP.

      IF lt_class_int_key IS NOT INITIAL.
        ls_classification_object-classification->remove_classes_by_int_key(
          EXPORTING
            it_class_int_key  = lt_class_int_key
          IMPORTING
            eo_clf_api_result = lo_clf_api_result ).

        me->add_object_class_msg(
          EXPORTING
            it_clfnobjectclass = CORRESPONDING #( it_input MAPPING cid = %cid_ref )
            io_ngc_api_result  = lo_clf_api_result
          CHANGING
            ct_reported        = es_reported
            ct_failed          = es_failed ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.