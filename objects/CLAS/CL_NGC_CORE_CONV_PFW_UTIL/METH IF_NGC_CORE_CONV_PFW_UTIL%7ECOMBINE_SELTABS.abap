  METHOD if_ngc_core_conv_pfw_util~combine_seltabs.

    rv_where = cl_shdb_pfw_seltab=>combine_seltabs(
      it_named_flat         = it_named_flat
      it_named_seltabs      = it_named_seltabs
      iv_avoid_empty_clause = iv_avoid_empty_clause
      iv_client_field       = iv_client_field
      iv_dbsys              = iv_dbsys
      iv_table_alias        = iv_table_alias
    ).

  ENDMETHOD.