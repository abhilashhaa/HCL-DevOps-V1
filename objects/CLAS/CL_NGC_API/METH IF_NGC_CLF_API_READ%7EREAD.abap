METHOD if_ngc_clf_api_read~read.

  DATA:
    lo_clf_api_result          TYPE REF TO cl_ngc_clf_api_result,
    lt_core_classification_key TYPE ngct_core_classification_key,
    ls_core_classification_key LIKE LINE OF lt_core_classification_key,
    lt_assigned_classes        TYPE ngct_class_object,
    lt_valuation_data          TYPE ngct_valuation_data,
    ls_valuation_data          LIKE LINE OF lt_valuation_data,
    ls_classification_object   TYPE ngcs_classification_object,
    lt_classification_data     TYPE ngct_classification_data,
    ls_classification_data     LIKE LINE OF lt_classification_data.

  CLEAR: et_classification_object, eo_clf_api_result.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

* Check input table
  IF it_classification_key IS INITIAL.
    RETURN.
  ENDIF.

* convert to core table, remove duplicates
  MOVE-CORRESPONDING it_classification_key TO lt_core_classification_key.
  SORT lt_core_classification_key ASCENDING BY object_key technical_object change_number key_date.
  DELETE ADJACENT DUPLICATES FROM lt_core_classification_key COMPARING object_key technical_object change_number key_date.

  LOOP AT lt_core_classification_key ASSIGNING FIELD-SYMBOL(<ls_core_classification_key>)
    WHERE
      object_key IS INITIAL OR
      technical_object IS INITIAL.
    MESSAGE e022(ngc_api_base) INTO DATA(lv_message).
    lo_clf_api_result->add_message_from_sy( is_classification_key = <ls_core_classification_key> ).
    DELETE lt_core_classification_key.
  ENDLOOP.

* get classification data
  mo_clf_persistency->read(
    EXPORTING it_keys           = lt_core_classification_key
              iv_lock           = abap_false
    IMPORTING et_classification = DATA(lt_classification)
              et_message        = DATA(lt_core_message) ).

  lo_clf_api_result->add_messages_from_core_clf( lt_core_message ).

* get classes
  get_classes_by_classification(
    EXPORTING it_classification = lt_classification
    IMPORTING et_class          = DATA(lt_class)
              eo_clf_api_result = DATA(lo_clf_classes_api_result) ).

  lo_clf_api_result->add_messages_from_api_result( lo_clf_classes_api_result ).

* sort classes by internal ID so that binary search will work
  SORT lt_class ASCENDING BY classinternalid key_date.

* convert classification data to objects
  LOOP AT lt_core_classification_key ASSIGNING <ls_core_classification_key>.
    CLEAR: ls_classification_object.
    MOVE-CORRESPONDING <ls_core_classification_key> TO ls_classification_object.

    LOOP AT lt_classification ASSIGNING FIELD-SYMBOL(<ls_classification>)
      WHERE key-object_key       = <ls_core_classification_key>-object_key
        AND key-technical_object = <ls_core_classification_key>-technical_object
        AND key-key_date         = <ls_core_classification_key>-key_date
        AND key-change_number    = <ls_core_classification_key>-change_number.

      CLEAR: lt_assigned_classes, lt_classification_data, lt_valuation_data.

      LOOP AT <ls_classification>-classification_data ASSIGNING FIELD-SYMBOL(<ls_core_classification_data>).
        READ TABLE lt_class ASSIGNING FIELD-SYMBOL(<ls_class>)
          WITH KEY classinternalid = <ls_core_classification_data>-classinternalid
                   key_date        = <ls_classification>-key_date
          BINARY SEARCH.
        " (if the class is not found in LT_CLASSES, this can mean that
        "   - class is not valid on the given key date
        "   - authorization is missing for the class
        "   - class is locked, cannot be read)
        IF sy-subrc = 0.
          APPEND <ls_class> TO lt_assigned_classes.
        ENDIF.
        MOVE-CORRESPONDING <ls_core_classification_data> TO ls_classification_data.
        APPEND ls_classification_data TO lt_classification_data.
        CLEAR: ls_classification_data.
      ENDLOOP.

      LOOP AT <ls_classification>-valuation_data ASSIGNING FIELD-SYMBOL(<ls_core_valuation_data>).
        MOVE-CORRESPONDING <ls_core_valuation_data> TO ls_valuation_data.
        APPEND ls_valuation_data TO lt_valuation_data.
        CLEAR: ls_valuation_data.
      ENDLOOP.

      ls_classification_object-classification = mo_api_factory->create_classification(
                                                  is_classification_key  = CORRESPONDING #( <ls_core_classification_key> )
                                                  it_classification_data = lt_classification_data
                                                  it_assigned_classes    = lt_assigned_classes
                                                  it_valuation_data      = lt_valuation_data ).
    ENDLOOP.

    ls_classification_object-classification->refresh_clf_status(
      IMPORTING
        eo_clf_api_result = DATA(lo_clf_status_api_result) ).

    lo_clf_api_result->add_messages_from_api_result( lo_clf_status_api_result ).

    APPEND ls_classification_object TO et_classification_object.
  ENDLOOP.

  eo_clf_api_result = lo_clf_api_result.

ENDMETHOD.