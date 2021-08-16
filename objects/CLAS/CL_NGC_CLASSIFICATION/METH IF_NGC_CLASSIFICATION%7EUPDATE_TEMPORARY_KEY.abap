  METHOD if_ngc_classification~update_temporary_key.

    " Don't allow object that already has classification
    mo_clf_persistency->read(
      EXPORTING
        it_keys           = VALUE #( ( object_key       = iv_clfnobjectid
                                       technical_object = ms_classification_key-technical_object
                                       key_date         = ms_classification_key-key_date
                                       change_number    = ms_classification_key-change_number ) )
      IMPORTING
        et_classification = DATA(lt_classification) ).

    IF lines( lt_classification ) <> 1 OR
       lines( lt_classification[ 1 ]-classification_data ) <> 0 OR
       lines( lt_classification[ 1 ]-valuation_data ) <> 0.
      RAISE EXCEPTION TYPE cx_ngc_api.
    ENDIF.

    ms_classification_key-object_key = iv_clfnobjectid.

  ENDMETHOD.