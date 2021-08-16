  METHOD if_ngc_clf_validation_dp~set_updated_data.

    IF it_classification_data_upd IS SUPPLIED.
      " Overwrite it also if initial (or contains less rows than original)
      CLEAR: mt_classification_data.
      LOOP AT it_classification_data_upd ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>).
        INSERT <ls_classification_data_upd> INTO TABLE mt_classification_data.
      ENDLOOP.
    ENDIF.

    IF it_assigned_class_upd IS SUPPLIED.
      " Overwrite it also if initial (or contains less rows than original)
      mt_assigned_class = it_assigned_class_upd.
    ENDIF.

    IF it_assigned_values IS SUPPLIED.
      IF mv_valuation_hash_table IS NOT INITIAL.
        CLEAR: mt_valuation_data_h.
        LOOP AT it_assigned_values ASSIGNING FIELD-SYMBOL(<ls_assigned_value>).
          INSERT <ls_assigned_value> INTO TABLE mt_valuation_data_h.
        ENDLOOP.
      ELSE.
        mt_valuation_data = it_assigned_values.
      ENDIF.
    ENDIF.

  ENDMETHOD.