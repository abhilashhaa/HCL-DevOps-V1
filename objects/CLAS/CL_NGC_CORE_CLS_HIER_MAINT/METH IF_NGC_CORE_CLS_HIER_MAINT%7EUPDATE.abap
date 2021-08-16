  METHOD if_ngc_core_cls_hier_maint~update.
    IF iv_mandt IS NOT INITIAL.
      LOOP AT mt_clhier_idx_insert ASSIGNING FIELD-SYMBOL(<ls_clhier_idx>).
        <ls_clhier_idx>-mandt = iv_mandt.
      ENDLOOP.
      LOOP AT mt_clhier_idx_delete ASSIGNING <ls_clhier_idx>.
        <ls_clhier_idx>-mandt = iv_mandt.
      ENDLOOP.
      LOOP AT mt_clhier_idx_update ASSIGNING <ls_clhier_idx>.
        <ls_clhier_idx>-mandt = iv_mandt.
      ENDLOOP.
    ENDIF.
    mo_db_access->update(
      it_insert = mt_clhier_idx_insert
      it_delete = mt_clhier_idx_delete
      it_update = mt_clhier_idx_update ).

    me->if_ngc_core_cls_hier_maint~reset(  ).
  ENDMETHOD.