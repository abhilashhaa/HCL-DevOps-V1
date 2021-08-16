  METHOD if_sdm_migration~get_package_size.

    " Define the target package size (target is runtime of ~1min per package).
    rv_size = mc_package_size.

  ENDMETHOD.