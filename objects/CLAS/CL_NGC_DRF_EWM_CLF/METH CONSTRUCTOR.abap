METHOD constructor.

  ms_runtime_param = is_runtime_param.

  mo_cif_functions        = NEW lcl_cif_functions( ).
  mo_db_access            = NEW lcl_db_access( ).

  mo_ewm_util     = cl_ngc_drf_ewm_util=>get_instance( ).

ENDMETHOD.