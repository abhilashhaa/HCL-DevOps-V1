  METHOD if_sdm_migration~get_table_name.

    " Table name used for package split and data model version check.
    rv_tabname = mc_db_view_name.

  ENDMETHOD.