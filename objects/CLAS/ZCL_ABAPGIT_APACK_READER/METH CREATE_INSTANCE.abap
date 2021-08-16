  METHOD create_instance.
    CREATE OBJECT ro_manifest_reader
      EXPORTING
        iv_package_name = iv_package_name.
  ENDMETHOD.