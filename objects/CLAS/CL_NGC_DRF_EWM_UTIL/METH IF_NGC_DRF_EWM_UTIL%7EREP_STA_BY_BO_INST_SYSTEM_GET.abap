METHOD if_ngc_drf_ewm_util~rep_sta_by_bo_inst_system_get.
  cl_drf_replication_status=>rep_sta_by_bo_inst_system_get(
    EXPORTING
      iv_business_system      = iv_business_system
      iv_bo                   = iv_bo
      iv_object_id            = iv_object_id
    IMPORTING
      et_replication          = et_replication
  ).
ENDMETHOD.