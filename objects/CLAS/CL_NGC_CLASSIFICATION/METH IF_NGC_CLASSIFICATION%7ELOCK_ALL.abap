  METHOD if_ngc_classification~lock_all.

    TYPES:
      BEGIN OF lts_clf_class,
        class           TYPE klasse_d,
        classtype       TYPE klassenart,
        classinternalid TYPE clint,
      END OF lts_clf_class,
      ltt_clf_class TYPE STANDARD TABLE OF lts_clf_class WITH EMPTY KEY.

    DATA:
      lt_classification_lock TYPE ngct_core_classification_lock,
      lo_clf_api_result      TYPE REF TO cl_ngc_clf_api_result,
      lt_message             TYPE ngct_classification_msg,
      lr_class_key           TYPE REF TO data,
      ls_class_key           TYPE ngcs_class_key,
      lt_clf_class           TYPE ltt_clf_class.

    FIELD-SYMBOLS:
      <ls_class_key> TYPE ngcs_class_key.


    CLEAR eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    LOOP AT mt_assigned_class ASSIGNING FIELD-SYMBOL(<ls_assigned_class>).
      DATA(ls_class_header) = <ls_assigned_class>-class_object->get_header( ).

      IF iv_classtype IS NOT INITIAL AND
         ls_class_header-classtype <> iv_classtype.
        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO lt_classification_lock ASSIGNING FIELD-SYMBOL(<ls_classification_lock>).
      <ls_classification_lock>-class      = ls_class_header-class.
      <ls_classification_lock>-classtype  = ls_class_header-classtype.
      <ls_classification_lock>-object_key = ms_classification_key-object_key.

      APPEND INITIAL LINE TO lt_clf_class ASSIGNING FIELD-SYMBOL(<ls_clf_class>).
      <ls_clf_class>-class           = ls_class_header-class.
      <ls_clf_class>-classtype       = ls_class_header-classtype.
      <ls_clf_class>-classinternalid = ls_class_header-classinternalid.
    ENDLOOP.

    mo_clf_persistency->lock_by_data(
      EXPORTING
        it_classfication_lock = lt_classification_lock
      IMPORTING
        et_message            = DATA(lt_core_message) ).

    LOOP AT lt_core_message ASSIGNING FIELD-SYMBOL(<ls_core_message>).
      <ls_core_message>-technical_object = me->ms_classification_key-technical_object.
      <ls_core_message>-object_key       = me->ms_classification_key-object_key.

      ls_class_key = VALUE #( classinternalid = lt_clf_class[
        class     = <ls_core_message>-class
        classtype = <ls_core_message>-classtype ] ).
      CREATE DATA lr_class_key TYPE ngcs_class_key.
      ASSIGN lr_class_key->* TO <ls_class_key>.
      <ls_class_key> = ls_class_key.

      APPEND INITIAL LINE TO lt_message ASSIGNING FIELD-SYMBOL(<ls_message>).
      <ls_message> = CORRESPONDING #( <ls_core_message> ).
      <ls_message>-ref_type = 'NGCS_CLASS_KEY'.
      <ls_message>-ref_key  = lr_class_key.
    ENDLOOP.

    lo_clf_api_result->add_messages( lt_message ).

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.