METHOD IF_DRF_OUTBOUND~ANALYZE_CHANGES_BY_OTHERS.

  CLEAR: es_stat_info.

  mo_ngc_drf_util->get_selected_classes(
    IMPORTING
      et_cls_key = ct_changed_objects
  ).

ENDMETHOD.