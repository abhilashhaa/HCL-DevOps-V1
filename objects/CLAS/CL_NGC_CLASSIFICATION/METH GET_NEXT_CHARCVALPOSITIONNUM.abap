  METHOD get_next_charcvalpositionnum.

    DATA:
      lv_previous_positionnumber TYPE wzaehl,
      lt_valuation_data          TYPE ngct_valuation_data_upd.

    IF mv_valuation_hash_table  IS NOT INITIAL.
      " If we use hash tables, we need to have a table where the sorting is correct.
      " In case of hash tables the rows in the loop are processed in the order in
      " which they were inserted in the table. Therefore we copy the hash table to a local
      " table and sort it, then process the copy.
      lt_valuation_data = mt_valuation_data_h.
      SORT lt_valuation_data ASCENDING BY clfnobjectid classtype charcinternalid charcvaluepositionnumber timeintervalnumber.

      LOOP AT lt_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data>)
        WHERE classtype       =  iv_classtype
        AND charcinternalid =  is_characteristic_header-charcinternalid
        AND object_state    <> if_ngc_c=>gc_object_state-deleted.
        IF sy-tabix <> 1.
          IF ( <ls_valuation_data>-charcvaluepositionnumber - lv_previous_positionnumber > 1 ).
            rv_charcvaluepositionnumber = lv_previous_positionnumber.
            EXIT.
          ELSE.
            lv_previous_positionnumber = <ls_valuation_data>-charcvaluepositionnumber.
          ENDIF.
        ELSE.
          lv_previous_positionnumber = <ls_valuation_data>-charcvaluepositionnumber.
        ENDIF.
        IF rv_charcvaluepositionnumber < <ls_valuation_data>-charcvaluepositionnumber.
          rv_charcvaluepositionnumber = <ls_valuation_data>-charcvaluepositionnumber.
        ENDIF.
      ENDLOOP.

    ELSE.
      LOOP AT mt_valuation_data ASSIGNING <ls_valuation_data>
        WHERE classtype       =  iv_classtype
          AND charcinternalid =  is_characteristic_header-charcinternalid
          AND object_state    <> if_ngc_c=>gc_object_state-deleted.
        IF sy-tabix <> 1.
          IF ( <ls_valuation_data>-charcvaluepositionnumber - lv_previous_positionnumber > 1 ).
            rv_charcvaluepositionnumber = lv_previous_positionnumber.
            EXIT.
          ELSE.
            lv_previous_positionnumber = <ls_valuation_data>-charcvaluepositionnumber.
          ENDIF.
        ELSE.
          lv_previous_positionnumber = <ls_valuation_data>-charcvaluepositionnumber.
        ENDIF.
        IF rv_charcvaluepositionnumber < <ls_valuation_data>-charcvaluepositionnumber.
          rv_charcvaluepositionnumber = <ls_valuation_data>-charcvaluepositionnumber.
        ENDIF.
      ENDLOOP.
    ENDIF.

    IF sy-subrc = 0.
      rv_charcvaluepositionnumber = rv_charcvaluepositionnumber + 1.
    ELSE. " if there was no assignment, set initial value
      DATA(ls_classtype) = mo_clf_persistency->read_classtype(
        iv_clfnobjecttable = ms_classification_key-technical_object
        iv_classtype       = iv_classtype ).

      IF ls_classtype-clfnnewnumberingisallowed = abap_true.
        IF is_characteristic_header-multiplevaluesareallowed = abap_false.
          rv_charcvaluepositionnumber = '001'.
        ELSE.
          rv_charcvaluepositionnumber = '002'.
        ENDIF.
      ELSE.
        rv_charcvaluepositionnumber = '001'.
      ENDIF.
    ENDIF.

  ENDMETHOD.