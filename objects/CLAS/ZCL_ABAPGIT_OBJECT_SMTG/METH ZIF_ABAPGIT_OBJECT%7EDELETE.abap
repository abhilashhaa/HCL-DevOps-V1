  METHOD zif_abapgit_object~delete.

    DATA: lx_error TYPE REF TO cx_root.

    TRY.
        CALL METHOD ('CL_SMTG_EMAIL_TEMPLATE')=>delete
          EXPORTING
            iv_id = mv_template_id.
      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.