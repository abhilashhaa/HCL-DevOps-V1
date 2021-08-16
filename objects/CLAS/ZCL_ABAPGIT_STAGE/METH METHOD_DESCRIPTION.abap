  METHOD method_description.

    CASE iv_method.
      WHEN zif_abapgit_definitions=>c_method-add.
        rv_description = 'add'.
      WHEN zif_abapgit_definitions=>c_method-rm.
        rv_description = 'rm'.
      WHEN zif_abapgit_definitions=>c_method-ignore.
        rv_description = 'ignore'.
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( 'unknown staging method type' ).
    ENDCASE.

  ENDMETHOD.