  METHOD create_instance.
    CREATE OBJECT ro_manifest_writer EXPORTING is_apack_manifest_descriptor = is_apack_manifest_descriptor.
  ENDMETHOD.