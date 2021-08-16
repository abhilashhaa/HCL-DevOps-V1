  METHOD build_apack_manifest_file.
    DATA: lo_manifest_reader TYPE REF TO zcl_abapgit_apack_reader,
          ls_descriptor      TYPE zif_abapgit_apack_definitions=>ty_descriptor,
          lo_manifest_writer TYPE REF TO zcl_abapgit_apack_writer.

    lo_manifest_reader = zcl_abapgit_apack_reader=>create_instance( ms_data-package ).
    IF lo_manifest_reader->has_manifest( ) = abap_true.
      ls_descriptor = lo_manifest_reader->get_manifest_descriptor( ).
      lo_manifest_writer = zcl_abapgit_apack_writer=>create_instance( ls_descriptor ).
      rs_file-path     = zif_abapgit_definitions=>c_root_dir.
      rs_file-filename = zif_abapgit_apack_definitions=>c_dot_apack_manifest.
      rs_file-data     = zcl_abapgit_convert=>string_to_xstring_utf8( lo_manifest_writer->serialize( ) ).
      rs_file-sha1     = zcl_abapgit_hash=>sha1( iv_type = zif_abapgit_definitions=>c_type-blob
                                                 iv_data = rs_file-data ).
    ENDIF.
  ENDMETHOD.