METHOD constructor.

  ms_runtime_param = is_runtime_param.

  mo_cif_functions        = NEW lcl_cif_functions( ).

  mo_ngc_drf_util         = cl_ngc_drf_util=>get_instance( ms_runtime_param-dlmod ).
  mo_ewm_util             = cl_ngc_drf_ewm_util=>get_instance( ).

ENDMETHOD.