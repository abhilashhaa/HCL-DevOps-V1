  METHOD if_ngc_clf_validation_dp~update_assigned_values.

    LOOP AT it_values ASSIGNING FIELD-SYMBOL(<ls_value>).
      IF mv_valuation_hash_table IS NOT INITIAL.
        READ TABLE mt_valuation_data_h
          ASSIGNING FIELD-SYMBOL(<ls_old_value>)
          WITH KEY
            charcinternalid = <ls_value>-charcinternalid
            charcvalue      = <ls_value>-charcvalueold
            classtype       = <ls_value>-classtype.
      ELSE.
        READ TABLE mt_valuation_data
          ASSIGNING <ls_old_value>
          WITH KEY
            charcinternalid = <ls_value>-charcinternalid
            charcvalue      = <ls_value>-charcvalueold
            classtype       = <ls_value>-classtype.
      ENDIF.
      IF sy-subrc = 0.
        <ls_old_value>-charcvalue = <ls_value>-charcvaluenew.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.