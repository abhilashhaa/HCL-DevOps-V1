  METHOD create_facade.

    CREATE OBJECT ri_facade TYPE lcl_package_interface_facade
      EXPORTING
        ii_interface = ii_interface.

  ENDMETHOD.