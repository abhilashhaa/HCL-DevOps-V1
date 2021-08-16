  METHOD get_installed_packages.

    DATA: lo_apack_reader            TYPE REF TO zcl_abapgit_apack_reader,
          lt_manifest_implementation TYPE tt_manifest_declaration,
          ls_manifest_implementation TYPE ty_manifest_declaration,
          lo_manifest_provider       TYPE REF TO object,
          ls_descriptor              TYPE zif_abapgit_apack_definitions=>ty_descriptor.

    SELECT seometarel~clsname tadir~devclass FROM seometarel "#EC CI_NOORDER
       INNER JOIN tadir ON seometarel~clsname = tadir~obj_name "#EC CI_BUFFJOIN
       INTO TABLE lt_manifest_implementation
       WHERE tadir~pgmid = 'R3TR'
         AND tadir~object = 'CLAS'
         AND seometarel~version = '1'
         AND ( seometarel~refclsname = 'ZIF_APACK_MANIFEST' OR seometarel~refclsname = 'IF_APACK_MANIFEST' ).

    LOOP AT lt_manifest_implementation INTO ls_manifest_implementation.
      CLEAR: lo_manifest_provider, lo_apack_reader.

      TRY.
          CREATE OBJECT lo_manifest_provider TYPE (ls_manifest_implementation-clsname).
        CATCH cx_sy_create_object_error.
          CLEAR: lo_manifest_provider.
      ENDTRY.

      IF lo_manifest_provider IS NOT BOUND.
        CONTINUE.
      ENDIF.

      lo_apack_reader = zcl_abapgit_apack_reader=>create_instance( ls_manifest_implementation-devclass ).
      lo_apack_reader->copy_manifest_descriptor( io_manifest_provider = lo_manifest_provider ).
      ls_descriptor = lo_apack_reader->get_manifest_descriptor( ).

      IF ls_descriptor IS NOT INITIAL.
        INSERT ls_descriptor INTO TABLE rt_packages.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.