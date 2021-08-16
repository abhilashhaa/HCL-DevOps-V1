  METHOD map_cds_to_fm.

    CLEAR: et_kssk_insert_fm, et_kssk_delete_fm, et_inob_insert_fm, et_inob_delete_fm, et_ausp_fm.

    LOOP AT mt_loaded_data ASSIGNING FIELD-SYMBOL(<ls_loaded_data>).

      "$. Region Map KSSK

      LOOP AT it_kssk_changes ASSIGNING FIELD-SYMBOL(<ls_kssk_change>)
        WHERE object_key       = <ls_loaded_data>-object_key
          AND technical_object = <ls_loaded_data>-technical_object "2819076
          AND change_number    = <ls_loaded_data>-change_number "2819076
          AND key_date         = <ls_loaded_data>-key_date. "2819076

        " read class data to get the class name
        READ TABLE mt_classes ASSIGNING FIELD-SYMBOL(<ls_class>)
          WITH KEY key_date        = <ls_kssk_change>-key_date
                   classinternalid = <ls_kssk_change>-classinternalid
                   BINARY SEARCH.
        IF sy-subrc <> 0.
          ASSERT 1 = 2.
        ENDIF.

        IF <ls_kssk_change>-object_state = if_ngc_c=>gc_object_state-deleted.
          APPEND INITIAL LINE TO et_kssk_delete_fm ASSIGNING FIELD-SYMBOL(<ls_kssk_delete_fm>).
          <ls_kssk_delete_fm>-mafid = <ls_kssk_change>-mafid.
          <ls_kssk_delete_fm>-klart = <ls_kssk_change>-classtype.
          <ls_kssk_delete_fm>-objek = <ls_kssk_change>-object_key.
          <ls_kssk_delete_fm>-clint = <ls_kssk_change>-classinternalid.
          <ls_kssk_delete_fm>-obtab = <ls_loaded_data>-technical_object.
          <ls_kssk_delete_fm>-cuobj = COND #(
                                        WHEN <ls_kssk_change>-object_key = <ls_kssk_change>-clfnobjectid
                                        THEN ''
                                        ELSE <ls_kssk_change>-clfnobjectid ).
        ELSE.
          APPEND INITIAL LINE TO et_kssk_insert_fm ASSIGNING FIELD-SYMBOL(<ls_kssk_insert_fm>).
          <ls_kssk_insert_fm>-objek = <ls_kssk_change>-object_key.
          <ls_kssk_insert_fm>-clint = <ls_kssk_change>-classinternalid.
          <ls_kssk_insert_fm>-klart = <ls_kssk_change>-classtype.
          <ls_kssk_insert_fm>-mafid = <ls_kssk_change>-mafid.
          <ls_kssk_insert_fm>-zaehl = <ls_kssk_change>-classpositionnumber.
          <ls_kssk_insert_fm>-adzhl = <ls_kssk_change>-timeintervalnumber.
          <ls_kssk_insert_fm>-statu = <ls_kssk_change>-clfnstatus.
          <ls_kssk_insert_fm>-stdcl = <ls_kssk_change>-classisstandardclass.
          <ls_kssk_insert_fm>-obtab = <ls_loaded_data>-technical_object.
          <ls_kssk_insert_fm>-aennr = <ls_kssk_change>-changenumber.
          <ls_kssk_insert_fm>-datuv = <ls_kssk_change>-validitystartdate.

          " can be used in BOM flag - VWSTL - based on class master data
          <ls_kssk_insert_fm>-vwstl = <ls_class>-classisusableinbom.
          <ls_kssk_insert_fm>-class = <ls_class>-class.

          <ls_kssk_insert_fm>-cuobj = COND #(
                                        WHEN <ls_kssk_change>-object_key = <ls_kssk_change>-clfnobjectid
                                        THEN ''
                                        ELSE <ls_kssk_change>-clfnobjectid ).

          CASE <ls_kssk_change>-object_state.
            WHEN if_ngc_c=>gc_object_state-created.
              <ls_kssk_insert_fm>-vbkz = 'I'.
            WHEN if_ngc_c=>gc_object_state-loaded.
              <ls_kssk_insert_fm>-vbkz = ''.
            WHEN if_ngc_c=>gc_object_state-updated.
              <ls_kssk_insert_fm>-vbkz = 'U'.
            WHEN OTHERS.
              " Invalid object state
              ASSERT 1 = 2.
          ENDCASE.
        ENDIF.
      ENDLOOP.

      "$. Endregion Map KSSK

      "$. Region Map AUSP

      LOOP AT it_ausp_changes ASSIGNING FIELD-SYMBOL(<ls_ausp_change>)
        WHERE object_key       = <ls_loaded_data>-object_key
          AND technical_object = <ls_loaded_data>-technical_object "2819076
          AND change_number    = <ls_loaded_data>-change_number "2819076
          AND key_date         = <ls_loaded_data>-key_date "2819076
          AND object_state    <> if_ngc_c=>gc_object_state-loaded.
        APPEND INITIAL LINE TO et_ausp_fm ASSIGNING FIELD-SYMBOL(<ls_ausp_fm>).
        <ls_ausp_fm>-objek    = <ls_ausp_change>-object_key.
        <ls_ausp_fm>-atinn    = <ls_ausp_change>-charcinternalid.
        <ls_ausp_fm>-atzhl    = <ls_ausp_change>-charcvaluepositionnumber.
        <ls_ausp_fm>-mafid    = <ls_ausp_change>-clfnobjecttype.
        <ls_ausp_fm>-klart    = <ls_ausp_change>-classtype.
        <ls_ausp_fm>-adzhl    = <ls_ausp_change>-timeintervalnumber.
        <ls_ausp_fm>-atwrt    = <ls_ausp_change>-charcvalue.
        <ls_ausp_fm>-atflv    = <ls_ausp_change>-charcfromnumericvalue.
        <ls_ausp_fm>-atawe    = <ls_ausp_change>-charcfromnumericvalueunit.
        <ls_ausp_fm>-atflb    = <ls_ausp_change>-charctonumericvalue.
        <ls_ausp_fm>-ataw1    = <ls_ausp_change>-charctonumericvalueunit.
        <ls_ausp_fm>-atcod    = <ls_ausp_change>-charcvaluedependency.
        <ls_ausp_fm>-attlv    = <ls_ausp_change>-attlv.
        <ls_ausp_fm>-attlb    = <ls_ausp_change>-attlb.
        <ls_ausp_fm>-atprz    = <ls_ausp_change>-atprz.
        <ls_ausp_fm>-atinc    = <ls_ausp_change>-atinc.
        <ls_ausp_fm>-ataut    = <ls_ausp_change>-characteristicauthor.
        <ls_ausp_fm>-aennr    = <ls_ausp_change>-changenumber.
        <ls_ausp_fm>-datuv    = <ls_ausp_change>-validitystartdate.
        <ls_ausp_fm>-atimb    = <ls_ausp_change>-atimb.
        <ls_ausp_fm>-atzis    = <ls_ausp_change>-atzis.
        <ls_ausp_fm>-atsrt    = <ls_ausp_change>-atsrt.
        <ls_ausp_fm>-atvglart = <ls_ausp_change>-atvglart.
        <ls_ausp_fm>-obtab    = <ls_loaded_data>-technical_object.
        <ls_ausp_fm>-cuobj    = COND #(
                                  WHEN <ls_ausp_change>-object_key = <ls_ausp_change>-clfnobjectid
                                  THEN ''
                                  ELSE <ls_ausp_change>-clfnobjectid ).

        CASE <ls_ausp_change>-object_state.
          WHEN if_ngc_c=>gc_object_state-created.
            <ls_ausp_fm>-statu = 'H'.
          WHEN if_ngc_c=>gc_object_state-updated.
            <ls_ausp_fm>-statu = 'V'.
          WHEN if_ngc_c=>gc_object_state-deleted.
            <ls_ausp_fm>-statu = 'L'.
          WHEN OTHERS.
            " Invalid object state
            ASSERT 1 = 2.
        ENDCASE.
      ENDLOOP.

      "$. Endregion Map AUSP

    ENDLOOP.

    "$. Region Map INOB

    LOOP AT it_inob_changes ASSIGNING FIELD-SYMBOL(<ls_inob_change>).
      IF <ls_inob_change>-object_state = if_ngc_c=>gc_object_state-created.
        APPEND INITIAL LINE TO et_inob_insert_fm ASSIGNING FIELD-SYMBOL(<ls_inob_insert_fm>).
        <ls_inob_insert_fm>-mandt   = sy-mandt.
        <ls_inob_insert_fm>-cuobj   = <ls_inob_change>-clfnobjectinternalid.
        <ls_inob_insert_fm>-klart   = <ls_inob_change>-classtype.
        <ls_inob_insert_fm>-obtab   = <ls_inob_change>-clfnobjecttable.
        <ls_inob_insert_fm>-objek   = <ls_inob_change>-clfnobjectid.
        <ls_inob_insert_fm>-robtab  = <ls_inob_change>-robtab.
        <ls_inob_insert_fm>-robjek  = <ls_inob_change>-robjek.
        <ls_inob_insert_fm>-clint   = <ls_inob_change>-clint.
        <ls_inob_insert_fm>-statu   = <ls_inob_change>-statu.
        <ls_inob_insert_fm>-cucozhl = <ls_inob_change>-cucozhl.
        <ls_inob_insert_fm>-parent  = <ls_inob_change>-parent.
        <ls_inob_insert_fm>-root    = <ls_inob_change>-root.
        <ls_inob_insert_fm>-experte = <ls_inob_change>-experte.
        <ls_inob_insert_fm>-matnr   = <ls_inob_change>-matnr.
        <ls_inob_insert_fm>-datuv   = <ls_inob_change>-datuv.
        <ls_inob_insert_fm>-techs   = <ls_inob_change>-techs.
      ELSEIF <ls_inob_change>-object_state = if_ngc_c=>gc_object_state-deleted.
        APPEND INITIAL LINE TO et_inob_delete_fm ASSIGNING FIELD-SYMBOL(<ls_inob_delete_fm>).
        <ls_inob_delete_fm>-cuobj = <ls_inob_change>-clfnobjectinternalid.
      ENDIF.
    ENDLOOP.

    "$. Endregion Map INOB

  ENDMETHOD.