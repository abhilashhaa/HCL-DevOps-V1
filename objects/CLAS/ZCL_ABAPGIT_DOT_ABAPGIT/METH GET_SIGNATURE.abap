  METHOD get_signature.

    rs_signature-path     = zif_abapgit_definitions=>c_root_dir.
    rs_signature-filename = zif_abapgit_definitions=>c_dot_abapgit.
    rs_signature-sha1     = zcl_abapgit_hash=>sha1( iv_type = zif_abapgit_definitions=>c_type-blob
                                                    iv_data = serialize( ) ).

  ENDMETHOD.