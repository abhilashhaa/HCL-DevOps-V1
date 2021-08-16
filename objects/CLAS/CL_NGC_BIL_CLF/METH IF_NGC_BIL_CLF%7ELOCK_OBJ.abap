  METHOD if_ngc_bil_clf~lock_obj.

    DATA:
      lt_classification_key TYPE ngct_classification_key.

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

    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<ls_input>).
      " get classification, based on classification key
      DATA(ls_classification_object) = VALUE #( lt_classification_object[
        object_key       = <ls_input>-clfnobjectid
        technical_object = <ls_input>-clfnobjecttable
        key_date         = sy-datum
        change_number    = space ] OPTIONAL ).

      IF ls_classification_object IS INITIAL.
        CONTINUE.
      ENDIF.

      ls_classification_object-classification->lock_all(
        IMPORTING
          eo_clf_api_result = lo_clf_api_result ).

      IF lo_clf_api_result IS BOUND.
        add_object_msg(
          EXPORTING
            it_clfnobject     = CORRESPONDING #( it_input )
            io_ngc_api_result = lo_clf_api_result
          CHANGING
            ct_failed         = es_failed
            ct_reported       = es_reported ).

        IF lo_clf_api_result->has_error_or_worse( ) = abap_true.
          CONTINUE.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.