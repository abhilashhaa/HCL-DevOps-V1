METHOD CONSTRUCTOR.
  CREATE OBJECT mo_drf_access_cust_data TYPE lcl_drf_access_cust_data.
  CREATE OBJECT mo_drf_ale_info TYPE lcl_drf_ale_info.
  CREATE OBJECT mo_idoc_functions TYPE lcl_idoc_functions.
  mo_ngc_drf_util = cl_ngc_drf_util=>get_instance( ).
ENDMETHOD.