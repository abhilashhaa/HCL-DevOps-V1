METHOD IF_DRF_OUTBOUND~INITIALIZE.

  CLEAR: eo_if_drf_outbound, es_runtime_param_out_impl.

  CREATE OBJECT go_drf_clsmas.

  MOVE is_runtime_param TO go_drf_clsmas->ms_runtime_param.

  es_runtime_param_out_impl-table_type_name = if_ngc_drf_c=>gc_clsmas_drf_table_type.
  eo_if_drf_outbound = go_drf_clsmas.

  " in case of direct repl. we suppress the implemented filter
  es_runtime_param_out_impl-suppress_apply_filter =
    boolc( is_runtime_param-dlmod = if_drf_const=>mode_directly ).

ENDMETHOD.