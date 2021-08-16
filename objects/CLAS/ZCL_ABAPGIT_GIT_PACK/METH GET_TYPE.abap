  METHOD get_type.

    CONSTANTS: lc_mask TYPE x VALUE 112.
    DATA: lv_xtype TYPE x.

    lv_xtype = iv_x BIT-AND lc_mask.

    CASE lv_xtype.
      WHEN 16.
        rv_type = zif_abapgit_definitions=>c_type-commit.
      WHEN 32.
        rv_type = zif_abapgit_definitions=>c_type-tree.
      WHEN 48.
        rv_type = zif_abapgit_definitions=>c_type-blob.
      WHEN 64.
        rv_type = zif_abapgit_definitions=>c_type-tag.
      WHEN 112.
        rv_type = zif_abapgit_definitions=>c_type-ref_d.
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( |Todo, unknown git pack type| ).
    ENDCASE.

  ENDMETHOD.