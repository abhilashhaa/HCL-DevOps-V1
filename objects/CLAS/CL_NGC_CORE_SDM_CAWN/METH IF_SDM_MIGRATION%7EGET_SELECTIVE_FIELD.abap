  METHOD if_sdm_migration~get_selective_field.

    " Get the selective field for migration, which field is used to build packages of distinct header table records.

    rv_field = mc_key_field_name.

  ENDMETHOD.