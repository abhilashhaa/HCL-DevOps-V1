  METHOD zif_abapgit_object~deserialize.

    DATA: ls_metadata TYPE zif_abapgit_definitions=>ty_metadata.

    ls_metadata = io_xml->get_metadata( ).

    CASE ls_metadata-version.

      WHEN 'v1.0.0'.
        deserialize_dsys( io_xml ).

      WHEN 'v2.0.0'.
        zcl_abapgit_factory=>get_longtexts( )->deserialize(
          ii_xml             = io_xml
          iv_master_language = mv_language ).

      WHEN OTHERS.
        zcx_abapgit_exception=>raise( 'unsupported DSYS version' ).

    ENDCASE.

    tadir_insert( iv_package ).

  ENDMETHOD.