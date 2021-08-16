  METHOD get_manifest_descriptor.

    DATA: lo_manifest_provider       TYPE REF TO object,
          ls_manifest_implementation TYPE ty_s_manifest_declaration.

    IF mv_is_cached IS INITIAL AND mv_package_name IS NOT INITIAL.
      SELECT SINGLE seometarel~clsname tadir~devclass FROM seometarel "#EC CI_NOORDER
         INNER JOIN tadir ON seometarel~clsname = tadir~obj_name "#EC CI_BUFFJOIN
         INTO ls_manifest_implementation
         WHERE tadir~pgmid = 'R3TR' AND
               tadir~object = 'CLAS' AND
               seometarel~version = '1' AND
               seometarel~refclsname = 'ZIF_APACK_MANIFEST' AND
               tadir~devclass = me->mv_package_name.
      IF ls_manifest_implementation IS INITIAL.
        SELECT SINGLE seometarel~clsname tadir~devclass FROM seometarel "#EC CI_NOORDER
           INNER JOIN tadir ON seometarel~clsname = tadir~obj_name "#EC CI_BUFFJOIN
           INTO ls_manifest_implementation
           WHERE tadir~pgmid = 'R3TR' AND
                 tadir~object = 'CLAS' AND
                 seometarel~version = '1' AND
                 seometarel~refclsname = 'IF_APACK_MANIFEST' AND
                 tadir~devclass = me->mv_package_name.
      ENDIF.
      IF ls_manifest_implementation IS NOT INITIAL.
        TRY.
            CREATE OBJECT lo_manifest_provider TYPE (ls_manifest_implementation-clsname).
          CATCH cx_sy_create_object_error.
            CLEAR: rs_manifest_descriptor.
        ENDTRY.
        IF lo_manifest_provider IS BOUND.
          me->copy_manifest_descriptor( io_manifest_provider = lo_manifest_provider ).
        ENDIF.
      ENDIF.

      mv_is_cached = abap_true.

    ENDIF.

    rs_manifest_descriptor = me->ms_cached_descriptor.
  ENDMETHOD.