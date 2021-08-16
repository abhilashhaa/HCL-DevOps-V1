FUNCTION ngc_core_cls_hier_upd_task .
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_CLHIER_IDX_INSERT) TYPE  NGCT_CLHIER_IDX
*"     VALUE(IT_CLHIER_IDX_UPDATE) TYPE  NGCT_CLHIER_IDX
*"     VALUE(IT_CLHIER_IDX_DELETE) TYPE  NGCT_CLHIER_IDX
*"  EXCEPTIONS
*"      UPDATE_FAILED
*"      MODIFY_FAILED
*"      DELETE_FAILED
*"----------------------------------------------------------------------


  DELETE ngc_clhier_idx FROM TABLE it_clhier_idx_delete.
  IF sy-subrc <> 0.
    RAISE delete_failed.
  ENDIF.

  INSERT ngc_clhier_idx FROM TABLE it_clhier_idx_insert.
  IF sy-subrc <> 0.
    RAISE modify_failed.
  ENDIF.

  UPDATE ngc_clhier_idx FROM TABLE it_clhier_idx_update.
  IF sy-subrc <> 0.
    RAISE update_failed.
  ENDIF.
ENDFUNCTION.