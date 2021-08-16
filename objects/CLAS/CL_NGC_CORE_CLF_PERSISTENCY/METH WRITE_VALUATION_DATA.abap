  METHOD write_valuation_data.

    DATA:
      lv_cuobj          TYPE cuobj,
      lt_classification TYPE ngct_core_classification_upd,
      lv_locking_error  TYPE boole_d VALUE abap_false.

    CLEAR: et_message.

    lt_classification = it_classification.

    " locking - all relevant classes which are already there in loaded data
    " Reason: when a class is assigned, the locking will be done. But when the data is only read, locking
    " might have been skipped. Therefore here we lock the class assignment which were already loaded and
    " stored in MT_LOADED_DATA.

    LOOP AT lt_classification ASSIGNING FIELD-SYMBOL(<ls_classification_upd>).
      DATA(lv_valuation_updated) = abap_false.
      LOOP AT mt_ausp_changes TRANSPORTING NO FIELDS
        WHERE
          object_key = <ls_classification_upd>-object_key AND
          technical_object = <ls_classification_upd>-technical_object AND
          object_state <> if_ngc_core_c=>gc_object_state-loaded.
        lv_valuation_updated = abap_true.
        EXIT.
      ENDLOOP.

      READ TABLE mt_loaded_data ASSIGNING FIELD-SYMBOL(<ls_loaded_data>)
        WITH KEY key = <ls_classification_upd>-key.

      IF sy-subrc = 0 AND lv_valuation_updated = abap_true.
        lv_locking_error = abap_false.
        LOOP AT <ls_loaded_data>-classification_data ASSIGNING FIELD-SYMBOL(<ls_loaded_classif_data>).
          " Locking
          lock( EXPORTING iv_classtype    = <ls_loaded_classif_data>-classtype
                          iv_class        = <ls_loaded_classif_data>-class
                          iv_clfnobjectid = <ls_classification_upd>-object_key
                          iv_write        = abap_true
                IMPORTING es_message      = DATA(ls_lock_message) ).
          IF ls_lock_message IS NOT INITIAL.
            " if there was at least one locking error, we don't process the value assignments
            " of this classification
            APPEND VALUE ngcs_core_classification_msg( object_key       = <ls_classification_upd>-object_key
                                                       technical_object = <ls_classification_upd>-technical_object
                                                       change_number    = <ls_classification_upd>-change_number
                                                       key_date         = <ls_classification_upd>-key_date
                                                       msgid            = ls_lock_message-msgid
                                                       msgty            = ls_lock_message-msgty
                                                       msgno            = ls_lock_message-msgno
                                                       msgv1            = ls_lock_message-msgv1
                                                       msgv2            = ls_lock_message-msgv2
                                                       msgv3            = ls_lock_message-msgv3
                                                       msgv4            = ls_lock_message-msgv4 ) TO et_message.
            lv_locking_error = abap_true.
            EXIT.
          ENDIF.
        ENDLOOP.
        IF lv_locking_error = abap_true.
          DELETE lt_classification.
        ENDIF.
      ENDIF.
    ENDLOOP.


    LOOP AT lt_classification ASSIGNING <ls_classification_upd>.

      " Process value assignemnts (created entries)
      LOOP AT <ls_classification_upd>-valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data_upd>)
        WHERE object_state = if_ngc_core_c=>gc_object_state-created.

        " Get class type - to be able to decide if INOB entry needs to be considered (for the key fields of AUSP)
        DATA(ls_classtype) = if_ngc_core_clf_persistency~read_classtype(
          iv_clfnobjecttable = <ls_classification_upd>-technical_object
          iv_classtype       = <ls_valuation_data_upd>-classtype ).

        get_cuobj(
          EXPORTING
            is_classtype          = ls_classtype
            is_classification_key = VALUE #( object_key       = <ls_classification_upd>-object_key
                                             technical_object = <ls_classification_upd>-technical_object
                                             change_number    = <ls_classification_upd>-change_number
                                             key_date         = <ls_classification_upd>-key_date )
          IMPORTING
            ev_cuobj              = lv_cuobj ).

        READ TABLE mt_ausp_changes ASSIGNING FIELD-SYMBOL(<ls_ausp_changes>)
          WITH KEY object_key               = <ls_classification_upd>-object_key
                   technical_object         = <ls_classification_upd>-technical_object
                   change_number            = <ls_classification_upd>-change_number
                   key_date                 = <ls_classification_upd>-key_date
                   clfnobjectid             = COND #( WHEN lv_cuobj IS NOT INITIAL THEN lv_cuobj ELSE <ls_classification_upd>-object_key )
                   charcinternalid          = <ls_valuation_data_upd>-charcinternalid
                   charcvaluepositionnumber = <ls_valuation_data_upd>-charcvaluepositionnumber
                   clfnobjecttype           = <ls_valuation_data_upd>-clfnobjecttype
                   classtype                = <ls_valuation_data_upd>-classtype
                   timeintervalnumber       = <ls_valuation_data_upd>-timeintervalnumber.
        IF sy-subrc = 0.
          CASE <ls_ausp_changes>-object_state.
            WHEN if_ngc_core_c=>gc_object_state-loaded
              OR if_ngc_core_c=>gc_object_state-updated.
              " If we create a new one, it should not be loaded or already updated
              ASSERT 1 = 2.

            WHEN if_ngc_core_c=>gc_object_state-deleted
              OR if_ngc_core_c=>gc_object_state-created.
              " Update this entry and set it to updated if it was deleted before

              " Key fields are not updated
*           <ls_ausp_changes>-clfnobjectid
*           <ls_ausp_changes>-charcinternalid
*           <ls_ausp_changes>-charcvaluepositionnumber
*           <ls_ausp_changes>-clfnobjecttype
*           <ls_ausp_changes>-classtype
*           <ls_ausp_changes>-timeintervalnumber
              <ls_ausp_changes>-charcvalue                = <ls_valuation_data_upd>-charcvalue.
              <ls_ausp_changes>-charcfromnumericvalue     = <ls_valuation_data_upd>-charcfromnumericvalue.
              <ls_ausp_changes>-charcfromnumericvalueunit = <ls_valuation_data_upd>-charcfromnumericvalueunit.
              <ls_ausp_changes>-charctonumericvalue       = <ls_valuation_data_upd>-charctonumericvalue.
              <ls_ausp_changes>-charctonumericvalueunit   = <ls_valuation_data_upd>-charctonumericvalueunit.
              <ls_ausp_changes>-charcvaluedependency      = <ls_valuation_data_upd>-charcvaluedependency.
              <ls_ausp_changes>-characteristicauthor      = <ls_valuation_data_upd>-characteristicauthor.
              <ls_ausp_changes>-changenumber              = <ls_valuation_data_upd>-changenumber.
              <ls_ausp_changes>-validitystartdate         = <ls_valuation_data_upd>-validitystartdate.
              <ls_ausp_changes>-ismarkedfordeletion       = <ls_valuation_data_upd>-ismarkedfordeletion.
              <ls_ausp_changes>-validityenddate           = <ls_valuation_data_upd>-validityenddate.
              <ls_ausp_changes>-charcfromdecimalvalue     = <ls_valuation_data_upd>-charcfromdecimalvalue.
              <ls_ausp_changes>-charctodecimalvalue       = <ls_valuation_data_upd>-charctodecimalvalue.
              <ls_ausp_changes>-charcfromamount           = <ls_valuation_data_upd>-charcfromamount.
              <ls_ausp_changes>-charctoamount             = <ls_valuation_data_upd>-charctoamount.
              <ls_ausp_changes>-currency                  = <ls_valuation_data_upd>-currency.
              <ls_ausp_changes>-charcfromdate             = <ls_valuation_data_upd>-charcfromdate.
              <ls_ausp_changes>-charctodate               = <ls_valuation_data_upd>-charctodate.
              <ls_ausp_changes>-charcfromtime             = <ls_valuation_data_upd>-charcfromtime.
              <ls_ausp_changes>-charctotime               = <ls_valuation_data_upd>-charctotime.
              IF <ls_ausp_changes>-object_state = if_ngc_core_c=>gc_object_state-deleted.
                <ls_ausp_changes>-object_state = if_ngc_core_c=>gc_object_state-updated.
              ENDIF.

*              IF <ls_ausp_changes>-charcvaluedependency CA '67'.
*                <ls_ausp_changes>-charctonumericvalue = <ls_ausp_changes>-charcfromnumericvalue.
*                CLEAR <ls_ausp_changes>-charcfromnumericvalue.
*              ENDIF.

          ENDCASE.

        ELSE.

          APPEND INITIAL LINE TO mt_ausp_changes ASSIGNING <ls_ausp_changes>.
          <ls_ausp_changes>-object_key                = <ls_classification_upd>-object_key.
          <ls_ausp_changes>-technical_object          = <ls_classification_upd>-technical_object.
          <ls_ausp_changes>-change_number             = <ls_classification_upd>-change_number.
          <ls_ausp_changes>-key_date                  = <ls_classification_upd>-key_date.
          <ls_ausp_changes>-clfnobjectid              = COND #( WHEN lv_cuobj IS NOT INITIAL THEN lv_cuobj ELSE <ls_classification_upd>-object_key ).
          <ls_ausp_changes>-charcinternalid           = <ls_valuation_data_upd>-charcinternalid.
          <ls_ausp_changes>-charcvaluepositionnumber  = <ls_valuation_data_upd>-charcvaluepositionnumber.
          <ls_ausp_changes>-clfnobjecttype            = <ls_valuation_data_upd>-clfnobjecttype.
          <ls_ausp_changes>-classtype                 = <ls_valuation_data_upd>-classtype.
          <ls_ausp_changes>-timeintervalnumber        = <ls_valuation_data_upd>-timeintervalnumber.
          <ls_ausp_changes>-charcvalue                = <ls_valuation_data_upd>-charcvalue.
          <ls_ausp_changes>-charcfromnumericvalue     = <ls_valuation_data_upd>-charcfromnumericvalue.
          <ls_ausp_changes>-charcfromnumericvalueunit = <ls_valuation_data_upd>-charcfromnumericvalueunit.
          <ls_ausp_changes>-charctonumericvalue       = <ls_valuation_data_upd>-charctonumericvalue.
          <ls_ausp_changes>-charctonumericvalueunit   = <ls_valuation_data_upd>-charctonumericvalueunit.
          <ls_ausp_changes>-charcvaluedependency      = <ls_valuation_data_upd>-charcvaluedependency.
          <ls_ausp_changes>-characteristicauthor      = <ls_valuation_data_upd>-characteristicauthor.
          <ls_ausp_changes>-changenumber              = <ls_valuation_data_upd>-changenumber.
          <ls_ausp_changes>-validitystartdate         = <ls_valuation_data_upd>-validitystartdate.
          <ls_ausp_changes>-ismarkedfordeletion       = <ls_valuation_data_upd>-ismarkedfordeletion.
          <ls_ausp_changes>-validityenddate           = <ls_valuation_data_upd>-validityenddate.
          <ls_ausp_changes>-charcfromdecimalvalue     = <ls_valuation_data_upd>-charcfromdecimalvalue.
          <ls_ausp_changes>-charctodecimalvalue       = <ls_valuation_data_upd>-charctodecimalvalue.
          <ls_ausp_changes>-charcfromamount           = <ls_valuation_data_upd>-charcfromamount.
          <ls_ausp_changes>-charctoamount             = <ls_valuation_data_upd>-charctoamount.
          <ls_ausp_changes>-currency                  = <ls_valuation_data_upd>-currency.
          <ls_ausp_changes>-charcfromdate             = <ls_valuation_data_upd>-charcfromdate.
          <ls_ausp_changes>-charctodate               = <ls_valuation_data_upd>-charctodate.
          <ls_ausp_changes>-charcfromtime             = <ls_valuation_data_upd>-charcfromtime.
          <ls_ausp_changes>-charctotime               = <ls_valuation_data_upd>-charctotime.
          <ls_ausp_changes>-object_state              = <ls_valuation_data_upd>-object_state.
*
*          IF <ls_ausp_changes>-charcvaluedependency CA '67'.
*            <ls_ausp_changes>-charctonumericvalue = <ls_ausp_changes>-charcfromnumericvalue.
*            CLEAR <ls_ausp_changes>-charcfromnumericvalue.
*          ENDIF.

        ENDIF.

      ENDLOOP.

      " Process value unassignments (deletions)
      LOOP AT <ls_classification_upd>-valuation_data ASSIGNING <ls_valuation_data_upd>
        WHERE object_state = if_ngc_core_c=>gc_object_state-deleted.

        " Get class type - to be able to decide if INOB entry needs to be considered (for the key fields of AUSP)
        ls_classtype = if_ngc_core_clf_persistency~read_classtype(
          iv_clfnobjecttable = <ls_classification_upd>-technical_object
          iv_classtype       = <ls_valuation_data_upd>-classtype ).

        get_cuobj(
          EXPORTING
            is_classtype          = ls_classtype
            is_classification_key = VALUE #( object_key       = <ls_classification_upd>-object_key
                                             technical_object = <ls_classification_upd>-technical_object
                                             change_number    = <ls_classification_upd>-change_number
                                             key_date         = <ls_classification_upd>-key_date )
          IMPORTING
            ev_cuobj              = lv_cuobj ).

        " merge changes to AUSP changes table
        READ TABLE mt_ausp_changes ASSIGNING <ls_ausp_changes>
          WITH KEY object_key               = <ls_classification_upd>-object_key
                   technical_object         = <ls_classification_upd>-technical_object
                   change_number            = <ls_classification_upd>-change_number
                   key_date                 = <ls_classification_upd>-key_date
                   clfnobjectid             = COND #( WHEN lv_cuobj IS NOT INITIAL THEN lv_cuobj ELSE <ls_classification_upd>-object_key )
                   charcinternalid          = <ls_valuation_data_upd>-charcinternalid
                   charcvaluepositionnumber = <ls_valuation_data_upd>-charcvaluepositionnumber
                   clfnobjecttype           = <ls_valuation_data_upd>-clfnobjecttype
                   classtype                = <ls_valuation_data_upd>-classtype
                   timeintervalnumber       = <ls_valuation_data_upd>-timeintervalnumber.
        IF sy-subrc = 0.
          CASE <ls_ausp_changes>-object_state.
            WHEN if_ngc_core_c=>gc_object_state-loaded
              OR if_ngc_core_c=>gc_object_state-updated.
              " Set entry to deleted
              <ls_ausp_changes>-object_state = if_ngc_core_c=>gc_object_state-deleted.
            WHEN if_ngc_core_c=>gc_object_state-created  " in this case IT_CLASSIFICATION will not contain the entry
              OR if_ngc_core_c=>gc_object_state-deleted. " if it has already been deleted, we do not need to do anything
              ASSERT 1 = 2.
          ENDCASE.
        ENDIF.

      ENDLOOP. " <ls_classification_upd>-valuation_data ---> removals
    ENDLOOP. " lt_classification

    " Process value changes (updates)
    LOOP AT lt_classification ASSIGNING <ls_classification_upd>.
      LOOP AT <ls_classification_upd>-valuation_data ASSIGNING <ls_valuation_data_upd>
        WHERE object_state = if_ngc_core_c=>gc_object_state-updated.

        " Get class type - to be able to decide if INOB entry needs to be considered (for the key fields of AUSP)
        ls_classtype = if_ngc_core_clf_persistency~read_classtype(
          iv_clfnobjecttable = <ls_classification_upd>-technical_object
          iv_classtype       = <ls_valuation_data_upd>-classtype ).

        get_cuobj(
          EXPORTING
            is_classtype          = ls_classtype
            is_classification_key = VALUE #( object_key       = <ls_classification_upd>-object_key
                                             technical_object = <ls_classification_upd>-technical_object
                                             change_number    = <ls_classification_upd>-change_number
                                             key_date         = <ls_classification_upd>-key_date )
          IMPORTING
            ev_cuobj              = lv_cuobj ).

        " merge changes to AUSP changes table --- here a read should be enough!
        READ TABLE mt_ausp_changes ASSIGNING <ls_ausp_changes>
          WITH KEY object_key               = <ls_classification_upd>-object_key
                   technical_object         = <ls_classification_upd>-technical_object
                   change_number            = <ls_classification_upd>-change_number
                   key_date                 = <ls_classification_upd>-key_date
                   clfnobjectid             = COND #( WHEN lv_cuobj IS NOT INITIAL THEN lv_cuobj ELSE <ls_classification_upd>-object_key )
                   charcinternalid          = <ls_valuation_data_upd>-charcinternalid
                   charcvaluepositionnumber = <ls_valuation_data_upd>-charcvaluepositionnumber
                   clfnobjecttype           = <ls_valuation_data_upd>-clfnobjecttype
                   classtype                = <ls_valuation_data_upd>-classtype.
*                 timeintervalnumber       = <ls_valuation_data_upd>-timeintervalnumber.
        IF sy-subrc = 0.

          CASE <ls_ausp_changes>-object_state.
            WHEN if_ngc_core_c=>gc_object_state-loaded
              OR if_ngc_core_c=>gc_object_state-created.
              " Update this entry and set it to updated
              <ls_ausp_changes>-charcvalue                = <ls_valuation_data_upd>-charcvalue.
              <ls_ausp_changes>-charcfromnumericvalue     = <ls_valuation_data_upd>-charcfromnumericvalue.
              <ls_ausp_changes>-charcfromnumericvalueunit = <ls_valuation_data_upd>-charcfromnumericvalueunit.
              <ls_ausp_changes>-charctonumericvalue       = <ls_valuation_data_upd>-charctonumericvalue.
              <ls_ausp_changes>-charctonumericvalueunit   = <ls_valuation_data_upd>-charctonumericvalueunit.
              <ls_ausp_changes>-charcvaluedependency      = <ls_valuation_data_upd>-charcvaluedependency.
              <ls_ausp_changes>-characteristicauthor      = <ls_valuation_data_upd>-characteristicauthor.
              <ls_ausp_changes>-changenumber              = <ls_valuation_data_upd>-changenumber.
              <ls_ausp_changes>-validitystartdate         = <ls_valuation_data_upd>-validitystartdate.
              <ls_ausp_changes>-ismarkedfordeletion       = <ls_valuation_data_upd>-ismarkedfordeletion.
              <ls_ausp_changes>-validityenddate           = <ls_valuation_data_upd>-validityenddate.
              <ls_ausp_changes>-charcfromdecimalvalue     = <ls_valuation_data_upd>-charcfromdecimalvalue.
              <ls_ausp_changes>-charctodecimalvalue       = <ls_valuation_data_upd>-charctodecimalvalue.
              <ls_ausp_changes>-charcfromamount           = <ls_valuation_data_upd>-charcfromamount.
              <ls_ausp_changes>-charctoamount             = <ls_valuation_data_upd>-charctoamount.
              <ls_ausp_changes>-currency                  = <ls_valuation_data_upd>-currency.
              <ls_ausp_changes>-charcfromdate             = <ls_valuation_data_upd>-charcfromdate.
              <ls_ausp_changes>-charctodate               = <ls_valuation_data_upd>-charctodate.
              <ls_ausp_changes>-charcfromtime             = <ls_valuation_data_upd>-charcfromtime.
              <ls_ausp_changes>-charctotime               = <ls_valuation_data_upd>-charctotime.

              IF <ls_ausp_changes>-object_state = if_ngc_core_c=>gc_object_state-loaded.
                <ls_ausp_changes>-object_state = if_ngc_core_c=>gc_object_state-updated.
              ENDIF.

            WHEN if_ngc_core_c=>gc_object_state-deleted.
              " If it was deleted, first it should be created if we would like to update it
              ASSERT 1 = 2.

            WHEN if_ngc_core_c=>gc_object_state-updated.
              " Update this entry but leave it as updated
              <ls_ausp_changes>-charcvalue                = <ls_valuation_data_upd>-charcvalue.
              <ls_ausp_changes>-charcfromnumericvalue     = <ls_valuation_data_upd>-charcfromnumericvalue.
              <ls_ausp_changes>-charcfromnumericvalueunit = <ls_valuation_data_upd>-charcfromnumericvalueunit.
              <ls_ausp_changes>-charctonumericvalue       = <ls_valuation_data_upd>-charctonumericvalue.
              <ls_ausp_changes>-charctonumericvalueunit   = <ls_valuation_data_upd>-charctonumericvalueunit.
              <ls_ausp_changes>-charcvaluedependency      = <ls_valuation_data_upd>-charcvaluedependency.
              <ls_ausp_changes>-characteristicauthor      = <ls_valuation_data_upd>-characteristicauthor.
              <ls_ausp_changes>-changenumber              = <ls_valuation_data_upd>-changenumber.
              <ls_ausp_changes>-validitystartdate         = <ls_valuation_data_upd>-validitystartdate.
              <ls_ausp_changes>-ismarkedfordeletion       = <ls_valuation_data_upd>-ismarkedfordeletion.
              <ls_ausp_changes>-validityenddate           = <ls_valuation_data_upd>-validityenddate.
              <ls_ausp_changes>-charcfromdecimalvalue     = <ls_valuation_data_upd>-charcfromdecimalvalue.
              <ls_ausp_changes>-charctodecimalvalue       = <ls_valuation_data_upd>-charctodecimalvalue.
              <ls_ausp_changes>-charcfromamount           = <ls_valuation_data_upd>-charcfromamount.
              <ls_ausp_changes>-charctoamount             = <ls_valuation_data_upd>-charctoamount.
              <ls_ausp_changes>-currency                  = <ls_valuation_data_upd>-currency.
              <ls_ausp_changes>-charcfromdate             = <ls_valuation_data_upd>-charcfromdate.
              <ls_ausp_changes>-charctodate               = <ls_valuation_data_upd>-charctodate.
              <ls_ausp_changes>-charcfromtime             = <ls_valuation_data_upd>-charcfromtime.
              <ls_ausp_changes>-charctotime               = <ls_valuation_data_upd>-charctotime.
              " <ls_ausp_changes>-object_state - leave it as it is

          ENDCASE.

        ELSE.
          " There was no assignment in the buffer yet - it cannot be updated!
          ASSERT 1 = 2.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.