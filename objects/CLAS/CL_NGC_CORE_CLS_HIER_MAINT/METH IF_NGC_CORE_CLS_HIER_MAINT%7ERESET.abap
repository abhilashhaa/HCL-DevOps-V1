  METHOD if_ngc_core_cls_hier_maint~reset.
    CLEAR:
      mt_relevant_relations,
      mt_direct_relations,
      mt_clhier_idx_insert,
      mt_clhier_idx_update,
      mt_clhier_idx_delete.
  ENDMETHOD.