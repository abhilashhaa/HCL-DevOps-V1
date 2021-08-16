  METHOD if_ngc_core_clf_persistency~write.

*--------------------------------------------------------------------*
* This method delegates the calls to write the changes made to INOB KSSK and AUSP tables.
* Assumption: MT_LOADED_DATA will contain the data corresponding to classifications which
* are written to the DB.
*--------------------------------------------------------------------*

    DATA:
          lv_classes_updated TYPE boole_d VALUE abap_false.

    CLEAR: et_message.

    " mt_classes should contain class data, this needs to be updated
    LOOP AT it_class ASSIGNING FIELD-SYMBOL(<ls_class>).
      READ TABLE mt_classes TRANSPORTING NO FIELDS
        WITH KEY key_date        = <ls_class>-key_date
                 classinternalid = <ls_class>-classinternalid
                 BINARY SEARCH.
      IF sy-subrc <> 0.
        APPEND <ls_class> TO mt_classes.
        lv_classes_updated = abap_true.
      ENDIF.
    ENDLOOP.
    IF lv_classes_updated = abap_true.
      SORT mt_classes ASCENDING BY key_date classinternalid.
    ENDIF.

    write_classification_data(
      EXPORTING
        it_classification = it_classification
        it_class          = it_class
      IMPORTING
        et_message        = DATA(lt_message)
    ).

    APPEND LINES OF lt_message TO et_message.

    write_valuation_data(
      EXPORTING
        it_classification = it_classification
      IMPORTING
        et_message        = lt_message
    ).

    APPEND LINES OF lt_message TO et_message.

  ENDMETHOD.