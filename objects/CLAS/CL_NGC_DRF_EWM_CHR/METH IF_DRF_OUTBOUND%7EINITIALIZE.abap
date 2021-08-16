METHOD if_drf_outbound~initialize.

  " Create an instance of the class
  " The runtime parameters is filled with sorted table type used for
  " main filter

  CLEAR: eo_if_drf_outbound, es_runtime_param_out_impl.

  go_drf_ewm_chr = NEW cl_ngc_drf_ewm_chr( is_runtime_param ).

  es_runtime_param_out_impl-table_type_name = gc_chr_key.
  eo_if_drf_outbound = go_drf_ewm_chr.

ENDMETHOD.