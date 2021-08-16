METHOD get_classes_by_classification.

  DATA:
    ls_class_key      TYPE ngcs_class_key,
    lt_class_keys     TYPE ngct_class_key,
    lt_class_of_clf   TYPE lty_t_class_of_classification,
    ls_class_of_clf   TYPE lty_s_class_of_classification,
    lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
    ls_message        TYPE ngcs_classification_msg,
    lt_message        TYPE ngct_classification_msg.

  CLEAR: et_class, eo_clf_api_result.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  eo_clf_api_result = lo_clf_api_result.

* collect class keys from the classification data
  LOOP AT it_classification ASSIGNING FIELD-SYMBOL(<ls_classification>).
    LOOP AT <ls_classification>-classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data>).
      MOVE-CORRESPONDING <ls_classification_data> TO ls_class_key.
      ls_class_key-key_date = <ls_classification>-key_date.
      APPEND ls_class_key TO lt_class_keys.
      APPEND VALUE #( class_key          = ls_class_key
                      classification_key = CORRESPONDING #( <ls_classification>-key ) ) TO lt_class_of_clf.
    ENDLOOP.
  ENDLOOP.

* one class can be assigned to multiple objects, so we need to filter out duplicates
  SORT lt_class_keys ASCENDING BY classinternalid key_date.
  DELETE ADJACENT DUPLICATES FROM lt_class_keys COMPARING classinternalid key_date.

* get class data from class read API
  if_ngc_cls_api_read~read(
    EXPORTING it_class_key      = lt_class_keys
    IMPORTING et_class          = et_class
              eo_cls_api_result = DATA(lo_cls_api_result) ).

  IF lo_cls_api_result->has_message( ) = abap_true.
    DATA(lt_cls_messages) = lo_cls_api_result->get_messages( ).
    LOOP AT lt_cls_messages ASSIGNING FIELD-SYMBOL(<ls_cls_message>).
      " there can be multple classifications with this class
      LOOP AT lt_class_of_clf ASSIGNING FIELD-SYMBOL(<ls_class_of_clf>)
        WHERE class_key-classinternalid = <ls_cls_message>-classinternalid
          AND class_key-key_date        = <ls_cls_message>-key_date.
        ls_message = VALUE ngcs_classification_msg( object_key       = <ls_class_of_clf>-classification_key-object_key
                                                    technical_object = <ls_class_of_clf>-classification_key-technical_object
                                                    change_number    = <ls_class_of_clf>-classification_key-change_number
                                                    key_date         = <ls_class_of_clf>-classification_key-key_date
                                                    msgid            = <ls_cls_message>-msgid
                                                    msgty            = <ls_cls_message>-msgty
                                                    msgno            = <ls_cls_message>-msgno
                                                    msgv1            = <ls_cls_message>-msgv1
                                                    msgv2            = <ls_cls_message>-msgv2
                                                    msgv3            = <ls_cls_message>-msgv3
                                                    msgv4            = <ls_cls_message>-msgv4 ).
        APPEND ls_message TO lt_message.
      ENDLOOP.
    ENDLOOP.
    lo_clf_api_result->add_messages( lt_message ).
  ENDIF.

ENDMETHOD.