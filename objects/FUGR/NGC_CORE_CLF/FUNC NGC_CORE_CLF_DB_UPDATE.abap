FUNCTION ngc_core_clf_db_update.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_KSSK_UPDATE) TYPE  NGCT_CORE_CLF_KSSK_UPD
*"     VALUE(IT_INOB_UPDATE) TYPE  NGCT_CORE_CLF_INOB_UPD
*"     VALUE(IT_AUSP_UPDATE) TYPE  NGCT_CORE_CLF_AUSP_UPD
*"  EXCEPTIONS
*"      INSERT_FAILED
*"      UPDATE_FAILED
*"      DELETE_FAILED
*"----------------------------------------------------------------------

  DATA:
    ls_kssk        TYPE kssk,
    ls_inob        TYPE inob,
    ls_ausp        TYPE ausp,
    lt_kssk_insert TYPE STANDARD TABLE OF kssk,
    lt_kssk_update TYPE STANDARD TABLE OF kssk,
    lt_kssk_delete TYPE STANDARD TABLE OF kssk,
    lt_inob_insert TYPE STANDARD TABLE OF inob,
    lt_inob_update TYPE STANDARD TABLE OF inob,
    lt_inob_delete TYPE STANDARD TABLE OF inob,
    lt_ausp_insert TYPE STANDARD TABLE OF ausp,
    lt_ausp_update TYPE STANDARD TABLE OF ausp,
    lt_ausp_delete TYPE STANDARD TABLE OF ausp.

  LOOP AT it_kssk_update ASSIGNING FIELD-SYMBOL(<ls_kssk_update>)
    WHERE object_state <> if_ngc_core_c=>gc_object_state-loaded.
    MOVE-CORRESPONDING <ls_kssk_update> TO ls_kssk.
    CASE <ls_kssk_update>-object_state.
      WHEN if_ngc_core_c=>gc_object_state-created.
        APPEND ls_kssk TO lt_kssk_insert.
      WHEN if_ngc_core_c=>gc_object_state-updated.
        APPEND ls_kssk TO lt_kssk_update.
      WHEN if_ngc_core_c=>gc_object_state-deleted.
        APPEND ls_kssk TO lt_kssk_delete.
    ENDCASE.
  ENDLOOP.

  LOOP AT it_inob_update ASSIGNING FIELD-SYMBOL(<ls_inob_update>)
    WHERE object_state <> if_ngc_core_c=>gc_object_state-loaded.
    MOVE-CORRESPONDING <ls_inob_update> TO ls_inob.
    CASE <ls_inob_update>-object_state.
      WHEN if_ngc_core_c=>gc_object_state-created.
        APPEND ls_inob TO lt_inob_insert.
      WHEN if_ngc_core_c=>gc_object_state-updated.
        APPEND ls_inob TO lt_inob_update.
      WHEN if_ngc_core_c=>gc_object_state-deleted.
        APPEND ls_inob TO lt_inob_delete.
    ENDCASE.
  ENDLOOP.

  LOOP AT it_ausp_update ASSIGNING FIELD-SYMBOL(<ls_ausp_update>)
    WHERE object_state <> if_ngc_core_c=>gc_object_state-loaded.
    MOVE-CORRESPONDING <ls_ausp_update> TO ls_ausp.
    CASE <ls_ausp_update>-object_state.
      WHEN if_ngc_core_c=>gc_object_state-created.
        APPEND ls_ausp TO lt_ausp_insert.
      WHEN if_ngc_core_c=>gc_object_state-updated.
        APPEND ls_ausp TO lt_ausp_update.
      WHEN if_ngc_core_c=>gc_object_state-deleted.
        APPEND ls_ausp TO lt_ausp_delete.
    ENDCASE.
  ENDLOOP.

  INSERT kssk FROM TABLE lt_kssk_insert.
  IF sy-subrc <> 0.
    RAISE insert_failed.
  ENDIF.

  UPDATE kssk FROM TABLE lt_kssk_update.
  IF sy-subrc <> 0.
    RAISE update_failed.
  ENDIF.

  DELETE kssk FROM TABLE lt_kssk_delete.
  IF sy-subrc <> 0.
    RAISE delete_failed.
  ENDIF.

  INSERT inob FROM TABLE lt_inob_insert.
  IF sy-subrc <> 0.
    RAISE insert_failed.
  ENDIF.

  UPDATE inob FROM TABLE lt_inob_update.
  IF sy-subrc <> 0.
    RAISE update_failed.
  ENDIF.

  DELETE inob FROM TABLE lt_inob_delete.
  IF sy-subrc <> 0.
    RAISE delete_failed.
  ENDIF.

  INSERT ausp FROM TABLE lt_ausp_insert.
  IF sy-subrc <> 0.
    RAISE insert_failed.
  ENDIF.

  UPDATE ausp FROM TABLE lt_ausp_update.
  IF sy-subrc <> 0.
    RAISE update_failed.
  ENDIF.

  DELETE ausp FROM TABLE lt_ausp_delete.
  IF sy-subrc <> 0.
    RAISE delete_failed.
  ENDIF.

ENDFUNCTION.