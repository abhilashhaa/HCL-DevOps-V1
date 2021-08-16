  METHOD if_ngc_clf_api_write~lock_all.

    DATA:
      lo_ngc_clf_api_result      TYPE REF TO cl_ngc_clf_api_result,
      lt_core_classification_key TYPE ngct_core_classification_key.

    CREATE OBJECT lo_ngc_clf_api_result.

    MOVE-CORRESPONDING it_classification_object TO lt_core_classification_key.

    mo_clf_persistency->lock_all(
      EXPORTING
        it_classification_key = lt_core_classification_key
      IMPORTING
        et_message            = DATA(lt_message)
    ).

    lo_ngc_clf_api_result->add_messages_from_core_clf( lt_message ).

    eo_clf_api_result = lo_ngc_clf_api_result.

  ENDMETHOD.