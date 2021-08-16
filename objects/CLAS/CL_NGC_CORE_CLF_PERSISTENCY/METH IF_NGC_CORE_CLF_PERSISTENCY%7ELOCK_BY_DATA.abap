  METHOD if_ngc_core_clf_persistency~lock_by_data.

    CLEAR: et_message.

    LOOP AT it_classfication_lock ASSIGNING FIELD-SYMBOL(<ls_classification_lock>).
      me->lock(
        EXPORTING
          iv_class        = <ls_classification_lock>-class
          iv_classtype    = <ls_classification_lock>-classtype
          iv_clfnobjectid = <ls_classification_lock>-object_key
        IMPORTING
          es_message = DATA(ls_message) ).

      IF ls_message IS NOT INITIAL.
        APPEND INITIAL LINE TO et_message ASSIGNING FIELD-SYMBOL(<ls_message>).
        <ls_message> = CORRESPONDING #( ls_message ).
        <ls_message>-object_key = <ls_classification_lock>-object_key.
        <ls_message>-class      = <ls_classification_lock>-class.
        <ls_message>-classtype  = <ls_classification_lock>-classtype.
      ENDIF.
    ENDLOOP.

    SORT et_message BY object_key technical_object.
    DELETE ADJACENT DUPLICATES FROM et_message.

  ENDMETHOD.