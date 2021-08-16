  METHOD map_cds_to_db.

    " Conversion of KSSK and INOB entries to DB-like table (table row type enhanced with object state).
    " Input tables contain KSSK and INOB as well as unchanged (loaded) entries.
    " Loaded entries are not put to the output tables.

*    CLEAR:
*      et_kssk_update, et_inob_update.
*
*    LOOP AT it_kssk_changes ASSIGNING FIELD-SYMBOL(<ls_kssk_changes>)
*      WHERE object_state <> if_ngc_core_c=>gc_object_state-loaded.
*      APPEND INITIAL LINE TO et_kssk_update ASSIGNING FIELD-SYMBOL(<ls_kssk_update>).
*      <ls_kssk_update>-mandt        = sy-mandt.
*      <ls_kssk_update>-objek        = <ls_kssk_changes>-clfnobjectid.
*      <ls_kssk_update>-mafid        = <ls_kssk_changes>-mafid.
*      <ls_kssk_update>-klart        = <ls_kssk_changes>-classtype.
*      <ls_kssk_update>-clint        = <ls_kssk_changes>-classinternalid.
*      <ls_kssk_update>-adzhl        = <ls_kssk_changes>-timeintervalnumber.
*      <ls_kssk_update>-zaehl        = <ls_kssk_changes>-classpositionnumber.
*      <ls_kssk_update>-statu        = <ls_kssk_changes>-clfnstatus.
*      <ls_kssk_update>-stdcl        = <ls_kssk_changes>-classisstandardclass.
*      <ls_kssk_update>-rekri        = <ls_kssk_changes>-bomisrecursive.
*      <ls_kssk_update>-aennr        = <ls_kssk_changes>-changenumber.
*      <ls_kssk_update>-datuv        = <ls_kssk_changes>-validitystartdate.
*      <ls_kssk_update>-lkenz        = <ls_kssk_changes>-ismarkedfordeletion.
*      <ls_kssk_update>-datub        = <ls_kssk_changes>-validityenddate.
*      <ls_kssk_update>-object_state = <ls_kssk_changes>-object_state.
*    ENDLOOP.
*
*    LOOP AT it_inob_changes ASSIGNING FIELD-SYMBOL(<ls_inob_changes>)
*      WHERE object_state <> if_ngc_core_c=>gc_object_state-loaded.
*      APPEND INITIAL LINE TO et_inob_update ASSIGNING FIELD-SYMBOL(<ls_inob_update>).
*      <ls_inob_update>-mandt        = sy-mandt.
*      <ls_inob_update>-cuobj        = <ls_inob_changes>-clfnobjectinternalid.
*      <ls_inob_update>-klart        = <ls_inob_changes>-classtype.
*      <ls_inob_update>-obtab        = <ls_inob_changes>-clfnobjecttable.
*      <ls_inob_update>-objek        = <ls_inob_changes>-clfnobjectid.
*      <ls_inob_update>-robtab       = <ls_inob_changes>-robtab.
*      <ls_inob_update>-robjek       = <ls_inob_changes>-robjek.
*      <ls_inob_update>-clint        = <ls_inob_changes>-clint.
*      <ls_inob_update>-statu        = <ls_inob_changes>-statu.
*      <ls_inob_update>-cucozhl      = <ls_inob_changes>-cucozhl.
*      <ls_inob_update>-parent       = <ls_inob_changes>-parent.
*      <ls_inob_update>-root         = <ls_inob_changes>-root.
*      <ls_inob_update>-experte      = <ls_inob_changes>-experte.
*      <ls_inob_update>-matnr        = <ls_inob_changes>-matnr.
*      <ls_inob_update>-datuv        = <ls_inob_changes>-datuv.
*      <ls_inob_update>-techs        = <ls_inob_changes>-techs.
*      <ls_inob_update>-object_state = <ls_inob_changes>-object_state.
*    ENDLOOP.
*
*    LOOP AT it_ausp_changes ASSIGNING FIELD-SYMBOL(<ls_ausp_changes>)
*      WHERE object_state <> if_ngc_core_c=>gc_object_state-loaded.
*      APPEND INITIAL LINE TO et_ausp_update ASSIGNING FIELD-SYMBOL(<ls_ausp_update>).
*      <ls_ausp_update>-mandt           = sy-mandt.
*      <ls_ausp_update>-objek           = <ls_ausp_changes>-clfnobjectid.
*      <ls_ausp_update>-atinn           = <ls_ausp_changes>-charcinternalid.
*      <ls_ausp_update>-atzhl           = <ls_ausp_changes>-charcvaluepositionnumber.
*      <ls_ausp_update>-mafid           = <ls_ausp_changes>-clfnobjecttype.
*      <ls_ausp_update>-klart           = <ls_ausp_changes>-classtype.
*      <ls_ausp_update>-adzhl           = <ls_ausp_changes>-timeintervalnumber.
*      <ls_ausp_update>-atwrt           = <ls_ausp_changes>-charcvalue.
*      <ls_ausp_update>-atflv           = <ls_ausp_changes>-charcfromnumericvalue.
*      <ls_ausp_update>-atawe           = <ls_ausp_changes>-charcfromnumericvalueunit.
*      <ls_ausp_update>-atflb           = <ls_ausp_changes>-charctonumericvalue.
*      <ls_ausp_update>-ataw1           = <ls_ausp_changes>-charctonumericvalueunit.
*      <ls_ausp_update>-atcod           = <ls_ausp_changes>-charcvaluedependency.
*      <ls_ausp_update>-attlv           = <ls_ausp_changes>-attlv.
*      <ls_ausp_update>-attlb           = <ls_ausp_changes>-attlb.
*      <ls_ausp_update>-atprz           = <ls_ausp_changes>-atprz.
*      <ls_ausp_update>-atinc           = <ls_ausp_changes>-atinc.
*      <ls_ausp_update>-ataut           = <ls_ausp_changes>-characteristicauthor.
*      <ls_ausp_update>-aennr           = <ls_ausp_changes>-changenumber.
*      <ls_ausp_update>-datuv           = <ls_ausp_changes>-validitystartdate.
*      <ls_ausp_update>-lkenz           = <ls_ausp_changes>-ismarkedfordeletion.
*      <ls_ausp_update>-atimb           = <ls_ausp_changes>-atimb.
*      <ls_ausp_update>-atzis           = <ls_ausp_changes>-atzis.
*      <ls_ausp_update>-atsrt           = <ls_ausp_changes>-atsrt.
*      <ls_ausp_update>-atvglart        = <ls_ausp_changes>-atvglart.
*      <ls_ausp_update>-datub           = <ls_ausp_changes>-validityenddate.
*      <ls_ausp_update>-dec_value_from  = <ls_ausp_changes>-charcfromdecimalvalue.
*      <ls_ausp_update>-dec_value_to    = <ls_ausp_changes>-charctodecimalvalue.
*      <ls_ausp_update>-curr_value_from = <ls_ausp_changes>-charcfromamount.
*      <ls_ausp_update>-curr_value_to   = <ls_ausp_changes>-charctoamount.
*      <ls_ausp_update>-currency        = <ls_ausp_changes>-currency.
*      <ls_ausp_update>-date_from       = <ls_ausp_changes>-charcfromdate.
*      <ls_ausp_update>-date_to         = <ls_ausp_changes>-charctodate.
*      <ls_ausp_update>-time_from       = <ls_ausp_changes>-charcfromtime.
*      <ls_ausp_update>-time_to         = <ls_ausp_changes>-charctotime.
*      <ls_ausp_update>-object_state    = <ls_ausp_changes>-object_state.
*    ENDLOOP.

  ENDMETHOD.