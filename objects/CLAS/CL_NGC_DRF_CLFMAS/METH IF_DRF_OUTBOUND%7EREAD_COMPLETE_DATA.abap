METHOD IF_DRF_OUTBOUND~READ_COMPLETE_DATA.

  DATA:
    lt_relevant_objects TYPE ngct_drf_clfmas_object_key.

  lt_relevant_objects = ct_relevant_objects.

  LOOP AT lt_relevant_objects ASSIGNING FIELD-SYMBOL(<ls_relevant_object>).
    APPEND VALUE #( objekt = <ls_relevant_object>-objkey
                    mafid  = COND #( WHEN <ls_relevant_object>-object_table IS NOT INITIAL
                                     THEN if_ngc_drf_c=>gc_classification_type_object
                                     ELSE if_ngc_drf_c=>gc_classification_type_class )
                    obtab  = <ls_relevant_object>-object_table
                    klart  = <ls_relevant_object>-klart )
      TO mt_clf_data.
  ENDLOOP.

ENDMETHOD.