METHOD IF_DRF_OUTBOUND~ANALYZE_CHANGES_BY_OTHERS.

  CLEAR: es_stat_info.

  mo_ngc_drf_util->get_selected_characteristics(
    IMPORTING
      et_chr_key     = ct_changed_objects
  ).

ENDMETHOD.