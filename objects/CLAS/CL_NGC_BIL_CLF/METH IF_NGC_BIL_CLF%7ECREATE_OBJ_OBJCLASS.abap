  METHOD if_ngc_bil_clf~create_obj_objclass.

    DATA:
      lt_classification_key TYPE ngct_classification_key,
      lt_class_int_key      TYPE ngct_class_key,
      lt_objectclass        TYPE lty_t_objectclass.

    CLEAR: es_mapped, es_failed, es_reported.

    me->get_classifications(
      EXPORTING
        it_classification_key    = CORRESPONDING #( it_input MAPPING cid  = %cid_ref )
      IMPORTING
        et_classification_object = DATA(lt_classification_object)
        eo_clf_api_result        = DATA(lo_clf_api_result) ).

    DATA(lt_objclass) = me->get_class_from_objclass( it_input ).

    me->add_object_class_msg(
      EXPORTING
        it_clfnobjectclass = CORRESPONDING #( lt_objclass MAPPING cid = %cid )
        io_ngc_api_result = lo_clf_api_result
      CHANGING
        ct_failed   = es_failed
        ct_reported = es_reported ).

    LOOP AT lt_classification_object ASSIGNING FIELD-SYMBOL(<ls_classification_object>).
      DATA(ls_input) = VALUE #( it_input[
        clfnobjectid    = <ls_classification_object>-object_key
        clfnobjecttable = <ls_classification_object>-technical_object ] OPTIONAL ).

      ASSERT FIELDS 'Input should exist for each classification object' CONDITION ls_input IS NOT INITIAL.

      LOOP AT ls_input-%target ASSIGNING FIELD-SYMBOL(<ls_entity>).
        APPEND INITIAL LINE TO lt_class_int_key ASSIGNING FIELD-SYMBOL(<ls_class_int_key>).
        <ls_class_int_key>-classinternalid = <ls_entity>-classinternalid.
        <ls_class_int_key>-key_date        = sy-datum.
      ENDLOOP.

      <ls_classification_object>-classification->assign_classes_by_int_key(
        EXPORTING
          it_class_int_key  = lt_class_int_key
        IMPORTING
          eo_clf_api_result = lo_clf_api_result ).

      me->add_object_class_msg(
        EXPORTING
          it_clfnobjectclass = CORRESPONDING #( lt_objclass MAPPING cid = %cid )
          io_ngc_api_result  = lo_clf_api_result
        CHANGING
          ct_reported        = es_reported
          ct_failed          = es_failed ).

      LOOP AT ls_input-%target ASSIGNING <ls_entity>.
        DATA(lv_class_failed_exists) = xsdbool( VALUE #( es_failed-objectclass[
            clfnobjectid    = ls_input-clfnobjectid
            clfnobjecttable = ls_input-clfnobjecttable
            classinternalid = <ls_entity>-classinternalid ] OPTIONAL ) IS NOT INITIAL ).
        DATA(lv_object_failed_exists) = xsdbool( VALUE #( es_failed-object[
            clfnobjectid    = ls_input-clfnobjectid
            clfnobjecttable = ls_input-clfnobjecttable ] OPTIONAL ) IS NOT INITIAL ).

        IF lv_class_failed_exists = abap_false AND lv_object_failed_exists = abap_false.
          APPEND INITIAL LINE TO es_mapped-objectclass ASSIGNING FIELD-SYMBOL(<ls_mapped>).
          <ls_mapped> = CORRESPONDING #( <ls_entity> ).
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.