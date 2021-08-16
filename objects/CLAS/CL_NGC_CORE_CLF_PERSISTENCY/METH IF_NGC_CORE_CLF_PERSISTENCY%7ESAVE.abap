  METHOD if_ngc_core_clf_persistency~save.

    DATA: lv_new_update TYPE boole_d VALUE abap_true.

    IF lv_new_update = abap_true.
      me->map_cds_to_fm(
        EXPORTING
          it_ausp_changes = mt_ausp_changes
          it_kssk_changes = mt_kssk_changes
          it_inob_changes = mt_inob_changes
        IMPORTING
          et_ausp_fm        = DATA(lt_ausp_fm)
          et_kssk_insert_fm = DATA(lt_kssk_insert_fm)
          et_kssk_delete_fm = DATA(lt_kssk_delete_fm)
          et_inob_insert_fm = DATA(lt_inob_insert_fm)
          et_inob_delete_fm = DATA(lt_inob_delete_fm) ).

      " Call BTE Event
      call_bte(
        it_ausp_fm        = lt_ausp_fm
        it_kssk_insert_fm = lt_kssk_insert_fm
        it_kssk_delete_fm = lt_kssk_delete_fm
        it_inob_insert_fm = lt_inob_insert_fm
        it_inob_delete_fm = lt_inob_delete_fm ).

      " Fill table for Dispo-records (structure for Classification View of MRP Record (Dispo-Sätze / Dispostufe))
      fill_dispo_table(
        EXPORTING
          it_ausp_fm        = lt_ausp_fm
          it_kssk_insert_fm = lt_kssk_insert_fm
        IMPORTING
          et_clmdcp         = DATA(lt_clmdcp)
      ).

      " call update function modules
      mo_db_update->clf_db_update(
        it_ausp_fm        = lt_ausp_fm
        it_inob_delete_fm = lt_inob_delete_fm
        it_inob_insert_fm = lt_inob_insert_fm
        it_kssk_delete_fm = lt_kssk_delete_fm
        it_kssk_insert_fm = lt_kssk_insert_fm
        it_clmdcp         = lt_clmdcp
      ).

    ELSE.
*    map_cds_to_db(
*      EXPORTING
*        it_kssk_changes = mt_kssk_changes
*        it_inob_changes = mt_inob_changes
*        it_ausp_changes = mt_ausp_changes
*      IMPORTING
*        et_kssk_update  = DATA(lt_kssk_update)
*        et_inob_update  = DATA(lt_inob_update)
*        et_ausp_update  = DATA(lt_ausp_update)
*    ).
*
*    mo_db_update->ngc_core_clf_db_update( it_kssk_update = lt_kssk_update
*                                          it_inob_update = lt_inob_update
*                                          it_ausp_update = lt_ausp_update ).
    ENDIF.

  ENDMETHOD.