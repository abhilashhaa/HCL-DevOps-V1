  METHOD update_valuation_data_buffer.

    DATA:
      lv_index              TYPE syst_tabix,
      ls_valuation_data_upd TYPE ngcs_valuation_data_upd.

    GET RUN TIME FIELD DATA(t1).

    IF mv_valuation_hash_table IS NOT INITIAL.

      IF is_charc_header-multiplevaluesareallowed = abap_false.
        " single value

        IF is_change_value_atwrt_i-charcvalueold IS NOT INITIAL.
          " old value filled:
          IF is_change_value_atwrt_i-charcvaluenew IS NOT INITIAL.
            " ignore old value, assign new value
            READ TABLE mt_valuation_data_h ASSIGNING FIELD-SYMBOL(<ls_valuation_data_upd>)
              WITH KEY charcinternalid =  is_change_value_atwrt_i-charcinternalid
                       classtype       =  is_change_value_atwrt_i-classtype.
            IF sy-subrc = 0.
              <ls_valuation_data_upd>-charcvalue                = cs_new_valuation_data-charcvalue.
              <ls_valuation_data_upd>-charcfromnumericvalue     = cs_new_valuation_data-charcfromnumericvalue.
              <ls_valuation_data_upd>-charcfromnumericvalueunit = cs_new_valuation_data-charcfromnumericvalueunit.
              <ls_valuation_data_upd>-charctonumericvalue       = cs_new_valuation_data-charctonumericvalue.
              <ls_valuation_data_upd>-charctonumericvalueunit   = cs_new_valuation_data-charctonumericvalueunit.
              <ls_valuation_data_upd>-charcvaluedependency      = cs_new_valuation_data-charcvaluedependency.
              <ls_valuation_data_upd>-characteristicauthor      = cs_new_valuation_data-characteristicauthor.

              " value is assigned, check object state
              IF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded
              OR <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
                <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-updated.
              ENDIF.
            ELSE.
              " no value was assigned, we assign a new one
              MOVE-CORRESPONDING cs_new_valuation_data TO <ls_valuation_data_upd>.

              cs_new_valuation_data-charcvaluepositionnumber =  get_next_charcvalpositionnum(
                is_characteristic_header = is_charc_header
                iv_classtype             = is_change_value_atwrt_i-classtype ).
              cs_new_valuation_data-timeintervalnumber = get_next_charcvaltimeintervaln(
                iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
                iv_classtype       = is_change_value_atwrt_i-classtype ).

              <ls_valuation_data_upd>-charcvaluepositionnumber = cs_new_valuation_data-charcvaluepositionnumber.
              <ls_valuation_data_upd>-timeintervalnumber = cs_new_valuation_data-timeintervalnumber.
              <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-created.
              INSERT ls_valuation_data_upd INTO TABLE mt_valuation_data_h.
            ENDIF.

          ELSE.
            " new value is empty, delete assignment
            READ TABLE mt_valuation_data_h ASSIGNING <ls_valuation_data_upd>
              WITH KEY charcinternalid = is_change_value_atwrt_i-charcinternalid
                       classtype       = is_change_value_atwrt_i-classtype
                       charcvalue      = is_change_value_atwrt_i-charcvalueold.
            IF sy-subrc = 0.
              IF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
                <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
              ELSEIF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-created
                  OR <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-updated.
                DELETE TABLE mt_valuation_data_h
                  WITH TABLE KEY clfnobjectid             = <ls_valuation_data_upd>-clfnobjectid
                                 charcinternalid          = <ls_valuation_data_upd>-charcinternalid
                                 charcvaluepositionnumber = <ls_valuation_data_upd>-charcvaluepositionnumber
                                 classtype                = <ls_valuation_data_upd>-classtype
                                 timeintervalnumber       = <ls_valuation_data_upd>-timeintervalnumber.
              ELSE.
                " deleted - do nothing
              ENDIF.
            ELSE.
              " not found by old value - ignore, do nothing
            ENDIF.
          ENDIF.

        ELSE.
          " old value empty

          IF is_change_value_atwrt_i-charcvaluenew IS NOT INITIAL.
            CLEAR ls_valuation_data_upd.
            " new value filled, replace
            READ TABLE mt_valuation_data_h ASSIGNING <ls_valuation_data_upd>
              WITH KEY charcinternalid = is_change_value_atwrt_i-charcinternalid
                       classtype       = is_change_value_atwrt_i-classtype.
            IF sy-subrc = 0.
              MOVE-CORRESPONDING <ls_valuation_data_upd> TO ls_valuation_data_upd.
              MOVE-CORRESPONDING cs_new_valuation_data TO ls_valuation_data_upd.

              IF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded
              OR <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
                ls_valuation_data_upd-object_state = if_ngc_c=>gc_object_state-updated.
                ls_valuation_data_upd-charcvaluepositionnumber = <ls_valuation_data_upd>-charcvaluepositionnumber."tempolary
*                ls_valuation_data_upd-charcvaluepositionnumber = get_next_charcvalpositionnum(
*                  is_characteristic_header = is_charc_header
*                  iv_classtype             = is_change_value_atwrt_i-classtype ).
*                ls_valuation_data_upd-timeintervalnumber = get_next_charcvaltimeintervaln(
*                  iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
*                  iv_classtype       = is_change_value_atwrt_i-classtype ).
              ENDIF.
              DELETE TABLE mt_valuation_data_h
                  WITH TABLE KEY clfnobjectid             = <ls_valuation_data_upd>-clfnobjectid
                                 charcinternalid          = <ls_valuation_data_upd>-charcinternalid
                                 charcvaluepositionnumber = <ls_valuation_data_upd>-charcvaluepositionnumber
                                 classtype                = <ls_valuation_data_upd>-classtype
                                 timeintervalnumber       = <ls_valuation_data_upd>-timeintervalnumber.
              INSERT ls_valuation_data_upd INTO TABLE mt_valuation_data_h.
            ELSE.
              MOVE-CORRESPONDING cs_new_valuation_data TO ls_valuation_data_upd.

              cs_new_valuation_data-charcvaluepositionnumber = get_next_charcvalpositionnum(
                is_characteristic_header = is_charc_header
                iv_classtype             = is_change_value_atwrt_i-classtype ).
              cs_new_valuation_data-timeintervalnumber = get_next_charcvaltimeintervaln(
                iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
                iv_classtype       = is_change_value_atwrt_i-classtype ).

              ls_valuation_data_upd-charcvaluepositionnumber = cs_new_valuation_data-charcvaluepositionnumber.
              ls_valuation_data_upd-timeintervalnumber = cs_new_valuation_data-timeintervalnumber.
              ls_valuation_data_upd-object_state = if_ngc_c=>gc_object_state-created.
              INSERT ls_valuation_data_upd INTO TABLE mt_valuation_data_h.
            ENDIF.

          ELSE.
            " new value is empty, delete assignment if exists
            READ TABLE mt_valuation_data_h ASSIGNING <ls_valuation_data_upd>
              WITH KEY charcinternalid = is_change_value_atwrt_i-charcinternalid
                       classtype       = is_change_value_atwrt_i-classtype.
            IF sy-subrc = 0.
              IF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
                <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
              ELSEIF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-created
                  OR <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-updated.
                DELETE TABLE mt_valuation_data_h
                  WITH TABLE KEY clfnobjectid             = <ls_valuation_data_upd>-clfnobjectid
                                 charcinternalid          = <ls_valuation_data_upd>-charcinternalid
                                 charcvaluepositionnumber = <ls_valuation_data_upd>-charcvaluepositionnumber
                                 classtype                = <ls_valuation_data_upd>-classtype
                                 timeintervalnumber       = <ls_valuation_data_upd>-timeintervalnumber.
              ELSE.
                " deleted - do nothing
              ENDIF.
            ELSE.
              " not found by old value - ignore, do nothing
            ENDIF.
          ENDIF.
        ENDIF.

      ELSE.
        " multi value

        IF is_change_value_atwrt_i-charcvalueold IS NOT INITIAL.

          " old value filled: find row by old value
          LOOP AT mt_valuation_data_h ASSIGNING <ls_valuation_data_upd>
            WHERE charcinternalid =  is_change_value_atwrt_i-charcinternalid
              AND classtype       =  is_change_value_atwrt_i-classtype
              AND charcvalue      =  is_change_value_atwrt_i-charcvalueold.
            EXIT. " only 1 of such entry is possible
          ENDLOOP.
          IF sy-subrc = 0.
            IF is_change_value_atwrt_i-charcvaluenew IS NOT INITIAL.
              " replace value
              CLEAR ls_valuation_data_upd.
              MOVE-CORRESPONDING <ls_valuation_data_upd> TO ls_valuation_data_upd.
              IF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded
              OR <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
                ls_valuation_data_upd-object_state = if_ngc_c=>gc_object_state-updated.
              ENDIF.

              DATA(lv_positionnumber) = <ls_valuation_data_upd>-charcvaluepositionnumber.
              MOVE-CORRESPONDING cs_new_valuation_data TO ls_valuation_data_upd.

              cs_new_valuation_data-charcvaluepositionnumber = lv_positionnumber.
              cs_new_valuation_data-timeintervalnumber       = get_next_charcvaltimeintervaln(
                iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
                iv_classtype       = is_change_value_atwrt_i-classtype ).

              ls_valuation_data_upd-charcvaluepositionnumber = cs_new_valuation_data-charcvaluepositionnumber.
              ls_valuation_data_upd-timeintervalnumber = cs_new_valuation_data-timeintervalnumber.
              ls_valuation_data_upd-clfnobjectid = <ls_valuation_data_upd>-clfnobjectid.

              DELETE TABLE mt_valuation_data_h
                WITH TABLE KEY clfnobjectid             = <ls_valuation_data_upd>-clfnobjectid
                               charcinternalid          = <ls_valuation_data_upd>-charcinternalid
                               charcvaluepositionnumber = <ls_valuation_data_upd>-charcvaluepositionnumber
                               classtype                = <ls_valuation_data_upd>-classtype
                               timeintervalnumber       = <ls_valuation_data_upd>-timeintervalnumber.
              INSERT ls_valuation_data_upd INTO TABLE mt_valuation_data_h.
            ELSE.
              " delete old
              <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
            ENDIF.
          ELSE.
            IF is_change_value_atwrt_i-charcvaluenew IS NOT INITIAL.
              " create new
              CLEAR ls_valuation_data_upd.
              MOVE-CORRESPONDING cs_new_valuation_data TO ls_valuation_data_upd.

              cs_new_valuation_data-charcvaluepositionnumber = get_next_charcvalpositionnum(
                is_characteristic_header = is_charc_header
                iv_classtype             = is_change_value_atwrt_i-classtype ).
              cs_new_valuation_data-timeintervalnumber = get_next_charcvaltimeintervaln(
                iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
                iv_classtype       = is_change_value_atwrt_i-classtype ).

              ls_valuation_data_upd-charcvaluepositionnumber = cs_new_valuation_data-charcvaluepositionnumber.
              ls_valuation_data_upd-timeintervalnumber = cs_new_valuation_data-timeintervalnumber.

              DATA(ls_existing_value) = VALUE #( mt_valuation_data_h[
                  charcinternalid          = ls_valuation_data_upd-charcinternalid
                  charcvaluepositionnumber = ls_valuation_data_upd-charcvaluepositionnumber
                  classtype                = ls_valuation_data_upd-classtype
                  timeintervalnumber       = ls_valuation_data_upd-timeintervalnumber ] OPTIONAL ).

              IF ls_existing_value IS INITIAL.
                ls_valuation_data_upd-object_state = if_ngc_c=>gc_object_state-created.
                INSERT ls_valuation_data_upd INTO TABLE mt_valuation_data_h.
              ELSE.
                DELETE TABLE mt_valuation_data_h
                  WITH TABLE KEY clfnobjectid             = ls_existing_value-clfnobjectid
                                 charcinternalid          = ls_existing_value-charcinternalid
                                 charcvaluepositionnumber = ls_existing_value-charcvaluepositionnumber
                                 classtype                = ls_existing_value-classtype
                                 timeintervalnumber       = ls_existing_value-timeintervalnumber.
                ls_valuation_data_upd-object_state = if_ngc_c=>gc_object_state-updated.
                INSERT ls_valuation_data_upd INTO TABLE mt_valuation_data_h.
              ENDIF.
            ELSE.
              " ignore the whole change
            ENDIF.
          ENDIF.
        ELSE.
          " old value empty
          IF is_change_value_atwrt_i-charcvaluenew IS NOT INITIAL.
            " Create new value assignment.
            CLEAR ls_valuation_data_upd.
            MOVE-CORRESPONDING cs_new_valuation_data TO ls_valuation_data_upd.

            " In this case it is possible that the provided new value is the same as the already set old value,
            " even if the old value in the input was not set by the caller.
            " In this case we ignore the provided new value, as it was already set.
            LOOP AT mt_valuation_data_h INTO ls_existing_value
              WHERE charcinternalid    = ls_valuation_data_upd-charcinternalid
                AND classtype          = ls_valuation_data_upd-classtype
                AND timeintervalnumber = ls_valuation_data_upd-timeintervalnumber
                AND charcvalue         = ls_valuation_data_upd-charcvalue
                AND object_state       <> if_ngc_c=>gc_object_state-deleted.
              EXIT.
            ENDLOOP.

            IF ls_existing_value IS INITIAL.

              cs_new_valuation_data-charcvaluepositionnumber = get_next_charcvalpositionnum(
              is_characteristic_header = is_charc_header
              iv_classtype             = is_change_value_atwrt_i-classtype ).
            cs_new_valuation_data-timeintervalnumber = get_next_charcvaltimeintervaln(
              iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
              iv_classtype       = is_change_value_atwrt_i-classtype ).

            ls_valuation_data_upd-charcvaluepositionnumber = cs_new_valuation_data-charcvaluepositionnumber.
            ls_valuation_data_upd-timeintervalnumber = cs_new_valuation_data-timeintervalnumber.

              CLEAR: ls_existing_value.
              ls_existing_value = VALUE #( mt_valuation_data_h[
                  charcinternalid          = ls_valuation_data_upd-charcinternalid
                  charcvaluepositionnumber = ls_valuation_data_upd-charcvaluepositionnumber
                  classtype                = ls_valuation_data_upd-classtype
                  timeintervalnumber       = ls_valuation_data_upd-timeintervalnumber ] OPTIONAL ).

            IF ls_existing_value IS INITIAL.
              ls_valuation_data_upd-object_state = if_ngc_c=>gc_object_state-created.
              INSERT ls_valuation_data_upd INTO TABLE mt_valuation_data_h.
            ELSE.
              DELETE TABLE mt_valuation_data_h
                WITH TABLE KEY clfnobjectid             = ls_existing_value-clfnobjectid
                               charcinternalid          = ls_existing_value-charcinternalid
                               charcvaluepositionnumber = ls_existing_value-charcvaluepositionnumber
                               classtype                = ls_existing_value-classtype
                               timeintervalnumber       = ls_existing_value-timeintervalnumber.
              ls_valuation_data_upd-object_state = if_ngc_c=>gc_object_state-updated.
              INSERT ls_valuation_data_upd INTO TABLE mt_valuation_data_h.
              ENDIF.

            ELSE.
              " The same char. value was already set to the multi-value characteristic -> ignore.
            ENDIF.

          ELSE.
            " ignore the whole change
          ENDIF.
        ENDIF.

      ENDIF.


    ELSE.
      IF is_charc_header-multiplevaluesareallowed = abap_false.
        " single value

        IF is_change_value_atwrt_i-charcvalueold IS NOT INITIAL.
          " old value filled:
          IF is_change_value_atwrt_i-charcvaluenew IS NOT INITIAL.
            " ignore old value, assign new value
            READ TABLE mt_valuation_data ASSIGNING <ls_valuation_data_upd>
              WITH KEY charcinternalid =  is_change_value_atwrt_i-charcinternalid
                       classtype       =  is_change_value_atwrt_i-classtype.
            IF sy-subrc = 0.
              <ls_valuation_data_upd>-charcvalue                = cs_new_valuation_data-charcvalue.
              <ls_valuation_data_upd>-charcfromnumericvalue     = cs_new_valuation_data-charcfromnumericvalue.
              <ls_valuation_data_upd>-charcfromnumericvalueunit = cs_new_valuation_data-charcfromnumericvalueunit.
              <ls_valuation_data_upd>-charctonumericvalue       = cs_new_valuation_data-charctonumericvalue.
              <ls_valuation_data_upd>-charctonumericvalueunit   = cs_new_valuation_data-charctonumericvalueunit.
              <ls_valuation_data_upd>-charcvaluedependency      = cs_new_valuation_data-charcvaluedependency.
              <ls_valuation_data_upd>-characteristicauthor      = cs_new_valuation_data-characteristicauthor.

              " value is assigned, check object state
              IF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded
              OR <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
                <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-updated.
              ENDIF.
            ELSE.
              " no value was assigned, we assign a new one
              APPEND INITIAL LINE TO mt_valuation_data ASSIGNING <ls_valuation_data_upd>.
              MOVE-CORRESPONDING cs_new_valuation_data TO <ls_valuation_data_upd>.

              cs_new_valuation_data-charcvaluepositionnumber = get_next_charcvalpositionnum(
                is_characteristic_header = is_charc_header
                iv_classtype             = is_change_value_atwrt_i-classtype ).
              cs_new_valuation_data-timeintervalnumber = get_next_charcvaltimeintervaln(
                iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
                iv_classtype       = is_change_value_atwrt_i-classtype ).

              <ls_valuation_data_upd>-charcvaluepositionnumber = cs_new_valuation_data-charcvaluepositionnumber.
              <ls_valuation_data_upd>-timeintervalnumber = cs_new_valuation_data-timeintervalnumber.
              <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-created.
            ENDIF.

          ELSE.
            " new value is empty, delete assignment
            READ TABLE mt_valuation_data ASSIGNING <ls_valuation_data_upd>
              WITH KEY charcinternalid = is_change_value_atwrt_i-charcinternalid
                       classtype       = is_change_value_atwrt_i-classtype
                       charcvalue      = is_change_value_atwrt_i-charcvalueold.
            lv_index = sy-tabix.
            IF sy-subrc = 0.
              IF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
                <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
              ELSEIF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-created
                  OR <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-updated.
                DELETE mt_valuation_data INDEX lv_index.
              ELSE.
                " deleted - do nothing
              ENDIF.
            ELSE.
              " not found by old value - ignore, do nothing
            ENDIF.
          ENDIF.

        ELSE.
          " old value empty

          IF is_change_value_atwrt_i-charcvaluenew IS NOT INITIAL.
            " new value filled, replace
            READ TABLE mt_valuation_data ASSIGNING <ls_valuation_data_upd>
              WITH KEY charcinternalid = is_change_value_atwrt_i-charcinternalid
                       classtype       = is_change_value_atwrt_i-classtype.
            IF sy-subrc = 0.
              MOVE-CORRESPONDING cs_new_valuation_data TO <ls_valuation_data_upd>.

              IF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded
              OR <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
                <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-updated.
                cs_new_valuation_data-charcvaluepositionnumber = get_next_charcvalpositionnum(
                  is_characteristic_header = is_charc_header
                  iv_classtype             = is_change_value_atwrt_i-classtype ).
                cs_new_valuation_data-timeintervalnumber = get_next_charcvaltimeintervaln(
                  iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
                  iv_classtype       = is_change_value_atwrt_i-classtype ).

                <ls_valuation_data_upd>-charcvaluepositionnumber = cs_new_valuation_data-charcvaluepositionnumber.
                <ls_valuation_data_upd>-timeintervalnumber = cs_new_valuation_data-timeintervalnumber.
              ENDIF.
            ELSE.
              APPEND INITIAL LINE TO mt_valuation_data ASSIGNING <ls_valuation_data_upd>.
              MOVE-CORRESPONDING cs_new_valuation_data TO <ls_valuation_data_upd>.

              cs_new_valuation_data-charcvaluepositionnumber = get_next_charcvalpositionnum(
                is_characteristic_header = is_charc_header
                iv_classtype             = is_change_value_atwrt_i-classtype ).
              cs_new_valuation_data-timeintervalnumber = get_next_charcvaltimeintervaln(
                iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
                iv_classtype       = is_change_value_atwrt_i-classtype ).

              <ls_valuation_data_upd>-charcvaluepositionnumber = cs_new_valuation_data-charcvaluepositionnumber.
              <ls_valuation_data_upd>-timeintervalnumber = cs_new_valuation_data-timeintervalnumber.
              <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-created.
            ENDIF.

          ELSE.
            " new value is empty, delete assignment if exists
            READ TABLE mt_valuation_data ASSIGNING <ls_valuation_data_upd>
              WITH KEY charcinternalid = is_change_value_atwrt_i-charcinternalid
                       classtype       = is_change_value_atwrt_i-classtype.

            lv_index = sy-tabix.

            IF sy-subrc = 0.
              IF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
                <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
              ELSEIF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-created
                  OR <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-updated.
                DELETE mt_valuation_data INDEX lv_index.
              ELSE.
                " deleted - do nothing
              ENDIF.
            ELSE.
              " not found by old value - ignore, do nothing
            ENDIF.
          ENDIF.
        ENDIF.

      ELSE.
        " multi value

        IF is_change_value_atwrt_i-charcvalueold IS NOT INITIAL.

          " old value filled: find row by old value
          LOOP AT mt_valuation_data ASSIGNING <ls_valuation_data_upd>
            WHERE charcinternalid =  is_change_value_atwrt_i-charcinternalid
              AND classtype       =  is_change_value_atwrt_i-classtype
              AND charcvalue      =  is_change_value_atwrt_i-charcvalueold.
            EXIT. " only 1 of such entry is possible
          ENDLOOP.
          IF sy-subrc = 0.
            IF is_change_value_atwrt_i-charcvaluenew IS NOT INITIAL.
              " replace value
              IF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-loaded
              OR <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
                <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-updated.
              ENDIF.
              lv_positionnumber = <ls_valuation_data_upd>-charcvaluepositionnumber.
              MOVE-CORRESPONDING cs_new_valuation_data TO <ls_valuation_data_upd>.

              cs_new_valuation_data-charcvaluepositionnumber = lv_positionnumber.
              cs_new_valuation_data-timeintervalnumber = get_next_charcvaltimeintervaln(
                iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
                iv_classtype       = is_change_value_atwrt_i-classtype ).

              <ls_valuation_data_upd>-charcvaluepositionnumber = cs_new_valuation_data-charcvaluepositionnumber.
              <ls_valuation_data_upd>-timeintervalnumber = cs_new_valuation_data-timeintervalnumber.
            ELSE.
              " delete old
              <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-deleted.
            ENDIF.
          ELSE.
            IF is_change_value_atwrt_i-charcvaluenew IS NOT INITIAL.
              " create new
              APPEND INITIAL LINE TO mt_valuation_data ASSIGNING <ls_valuation_data_upd>.
              MOVE-CORRESPONDING cs_new_valuation_data TO <ls_valuation_data_upd>.

              cs_new_valuation_data-charcvaluepositionnumber = get_next_charcvalpositionnum(
                is_characteristic_header = is_charc_header
                iv_classtype             = is_change_value_atwrt_i-classtype ).
              cs_new_valuation_data-timeintervalnumber = get_next_charcvaltimeintervaln(
                iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
                iv_classtype       = is_change_value_atwrt_i-classtype ).

              <ls_valuation_data_upd>-charcvaluepositionnumber = cs_new_valuation_data-charcvaluepositionnumber.
              <ls_valuation_data_upd>-timeintervalnumber = cs_new_valuation_data-timeintervalnumber.
              <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-created.
            ELSE.
              " ignore the whole change
            ENDIF.
          ENDIF.
        ELSE.
          " old value empty
          IF is_change_value_atwrt_i-charcvaluenew IS NOT INITIAL.
            " Create new value assignment.
            APPEND INITIAL LINE TO mt_valuation_data ASSIGNING <ls_valuation_data_upd>.
            MOVE-CORRESPONDING cs_new_valuation_data TO <ls_valuation_data_upd>.

            " In this case it is possible that the provided new value is the same as the already set old value,
            " even if the old value in the input was not set by the caller.
            " In this case we ignore the provided new value, as it was already set.
            LOOP AT mt_valuation_data INTO ls_existing_value
              WHERE charcinternalid    = ls_valuation_data_upd-charcinternalid
                AND classtype          = ls_valuation_data_upd-classtype
                AND timeintervalnumber = ls_valuation_data_upd-timeintervalnumber
                AND charcvalue         = ls_valuation_data_upd-charcvalue
                AND object_state       <> if_ngc_c=>gc_object_state-deleted.
              EXIT.
            ENDLOOP.

            IF ls_existing_value IS INITIAL.
              cs_new_valuation_data-charcvaluepositionnumber = get_next_charcvalpositionnum(
              is_characteristic_header = is_charc_header
              iv_classtype             = is_change_value_atwrt_i-classtype ).
            cs_new_valuation_data-timeintervalnumber = get_next_charcvaltimeintervaln(
              iv_charcinternalid = is_change_value_atwrt_i-charcinternalid
              iv_classtype       = is_change_value_atwrt_i-classtype ).

            <ls_valuation_data_upd>-charcvaluepositionnumber = cs_new_valuation_data-charcvaluepositionnumber.
            <ls_valuation_data_upd>-timeintervalnumber = cs_new_valuation_data-timeintervalnumber.
            <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-created.
            ELSE.
              " The same char. value was already set to the multi-value characteristic -> ignore.
            ENDIF.

          ELSE.
            " ignore the whole change
          ENDIF.
        ENDIF.

      ENDIF.
    ENDIF.
    GET RUN TIME FIELD DATA(t2).
    DATA(t) = t2 - t1.
  ENDMETHOD.