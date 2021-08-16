  METHOD if_sdm_migration~must_run.

    " This SDM is on-premise only.
    rv_must_run = xsdbool( cl_cos_utilities=>is_cloud( ) = abap_false ).

  ENDMETHOD.