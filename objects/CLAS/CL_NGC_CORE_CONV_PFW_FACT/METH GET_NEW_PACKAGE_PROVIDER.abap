  METHOD get_new_package_provider.

    " Static instance can be filled by factory injector to enable unit testing.
    ro_instance = go_package_provider.

    IF ro_instance IS INITIAL.
      ro_instance = cl_shdb_pfw_factory=>new_package_provider( ).
    ENDIF.

  ENDMETHOD.