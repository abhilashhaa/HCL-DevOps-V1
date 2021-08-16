  METHOD if_sdm_migration~get_status_value_done.

    " Value of field defined in IF_SDM_MIGRATION~GET_STATUS_FIELD indicating the target data model version.
    rv_status_value_done = mc_sdm_status-done.

  ENDMETHOD.