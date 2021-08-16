  METHOD if_ngc_classification~remove_classes_by_int_key.

    DATA:
      lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
      lt_message        TYPE ngct_classification_msg.

    FIELD-SYMBOLS:
      <ls_class_key> TYPE ngcs_class_key.

    CLEAR: eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    mo_ngc_api_factory->get_api( )->if_ngc_cls_api_read~read(
      EXPORTING
        it_class_key      = it_class_int_key
      IMPORTING
        et_class          = DATA(lt_class)
        eo_cls_api_result = DATA(lo_cls_api_result)
    ).

    DATA(lt_cls_messages) = lo_cls_api_result->get_messages( ).

    LOOP AT lt_cls_messages ASSIGNING FIELD-SYMBOL(<ls_cls_messages>).
      APPEND INITIAL LINE TO lt_message ASSIGNING FIELD-SYMBOL(<ls_message>).
      <ls_message> = VALUE #( object_key       = me->ms_classification_key-object_key
                              technical_object = me->ms_classification_key-technical_object
                              change_number    = me->ms_classification_key-change_number
                              key_date         = me->ms_classification_key-key_date
                              msgty            = <ls_cls_messages>-msgty
                              msgid            = <ls_cls_messages>-msgid
                              msgno            = <ls_cls_messages>-msgno
                              msgv1            = <ls_cls_messages>-msgv1
                              msgv2            = <ls_cls_messages>-msgv2
                              msgv3            = <ls_cls_messages>-msgv3
                              msgv4            = <ls_cls_messages>-msgv4 ).
      " fill reference key: it will be the reference given back by the class API
      " or the class key
      IF <ls_cls_messages>-ref_type IS NOT INITIAL.
        <ls_message>-ref_key  = <ls_cls_messages>-ref_key.
        <ls_message>-ref_type = <ls_cls_messages>-ref_type.
      ELSE.
        ASSIGN <ls_message>-ref_key->* TO <ls_class_key>.
        MOVE-CORRESPONDING <ls_cls_messages> TO <ls_class_key>.
        <ls_message>-ref_type = 'NGCS_CLASS_KEY'.
      ENDIF.
    ENDLOOP.

    lo_clf_api_result->add_messages( lt_message ).

    me->if_ngc_classification~remove_classes(
      EXPORTING
        it_class          = lt_class
      IMPORTING
        eo_clf_api_result = DATA(lo_clf_api_result_remove)
    ).

    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_remove ).

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.