METHOD get_max_positionnumber.

  CLEAR:
    rv_max_positionnumber.

  LOOP AT it_classification_data_upd ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>)
    WHERE object_state <> if_ngc_c=>gc_object_state-deleted.
    IF rv_max_positionnumber < <ls_classification_data_upd>-classpositionnumber.
      rv_max_positionnumber = <ls_classification_data_upd>-classpositionnumber.
    ENDIF.
  ENDLOOP.

ENDMETHOD.