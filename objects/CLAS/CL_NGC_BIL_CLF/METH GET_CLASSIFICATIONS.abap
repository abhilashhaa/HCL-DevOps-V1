  METHOD get_classifications.

    DATA:
      lt_classification_key TYPE ngct_classification_key.

    LOOP AT it_classification_key ASSIGNING FIELD-SYMBOL(<ls_classification_key>).
      APPEND INITIAL LINE TO lt_classification_key ASSIGNING FIELD-SYMBOL(<ls_classification_key_in>).
      <ls_classification_key_in>-object_key       = <ls_classification_key>-clfnobjectid.
      <ls_classification_key_in>-technical_object = <ls_classification_key>-clfnobjecttable.
      <ls_classification_key_in>-key_date         = sy-datum.
    ENDLOOP.

    LOOP AT lt_classification_key ASSIGNING <ls_classification_key_in>.
      DATA(ls_classification_object) = VALUE #( mt_classification[
        technical_object  = <ls_classification_key_in>-technical_object
        object_key        = <ls_classification_key_in>-object_key
        key_date          = <ls_classification_key_in>-key_date
        change_number     = <ls_classification_key_in>-change_number ] OPTIONAL ).

      IF ls_classification_object IS NOT INITIAL.
        DELETE lt_classification_key.
        APPEND ls_classification_object TO et_classification_object.
      ENDIF.
    ENDLOOP.

    IF lt_classification_key IS NOT INITIAL.
      mo_ngc_api->if_ngc_clf_api_read~read(
        EXPORTING
          it_classification_key    = lt_classification_key
        IMPORTING
          et_classification_object = DATA(lt_classification_object)
          eo_clf_api_result        = eo_clf_api_result ).

      APPEND LINES OF lt_classification_object TO: mt_classification, et_classification_object.
    ENDIF.

  ENDMETHOD.