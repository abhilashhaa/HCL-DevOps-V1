  METHOD zif_abapgit_object~exists.

    TRY.
        cl_enh_factory=>load_enhancement_composite(
          name = mv_composite_id
          lock = abap_false ).
        rv_bool = abap_true.
      CATCH cx_enh_root.
        rv_bool = abap_false.
    ENDTRY.

  ENDMETHOD.