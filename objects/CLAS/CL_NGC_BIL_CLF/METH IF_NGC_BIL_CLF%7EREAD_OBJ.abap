  METHOD if_ngc_bil_clf~read_obj.

    DATA:
      lt_classification_key     TYPE ngct_classification_key.

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
      READ TABLE lt_classification_object TRANSPORTING NO FIELDS WITH KEY
        technical_object = <ls_input>-clfnobjecttable
        object_key       = <ls_input>-clfnobjectid.

      " failed entires are handled above
      IF sy-subrc = 0.
        APPEND INITIAL LINE TO et_result ASSIGNING FIELD-SYMBOL(<ls_result>).
        MOVE-CORRESPONDING <ls_input> TO <ls_result>.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.