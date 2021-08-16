METHOD constructor.

  ms_runtime_param = is_runtime_param.

  mo_db_access =            NEW lcl_db_access( ).

  mo_ngc_drf_util = cl_ngc_drf_util=>get_instance( ms_runtime_param-dlmod ).
  mo_ewm_util     = cl_ngc_drf_ewm_util=>get_instance( ).

ENDMETHOD.